import SwiftUI

struct AddModel: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var gerenciadorSessoes: GerenciadorSessoesViewModel

    @State var idSessaoEditando: UUID? = nil
    @State var nomeSessaoAtual: String = ""
    @State var exerciciosSessaoAtual: [ExercicioNaSessao] = []
    @State var showAlertInfo = false
    @State var showFeedbackAlert = false
    @State var feedbackAlertMessage = ""
    @State var feedbackAlertTitle = "Aviso"
    @State var modoCriacaoEdicaoAtivo = false
    @State var nomeSessaoInteragido = false

    // MARK: - UI Constants
    let textFieldPrincipalBackgroundColor = Color.gray.opacity(0.25)
    let placeholderColor = Color.gray.opacity(0.6)
    let corBotaoPrincipal = Color("CorBotao")
    let corTextoPrincipal = Color.white
    let corTextoSecundario = Color.gray

    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    if modoCriacaoEdicaoAtivo {
                        editorDeSessaoView()
                    } else {
                        listaDeSessoesView()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if modoCriacaoEdicaoAtivo {
                        Button(action: cancelarEdicaoOuCriacao) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(corTextoPrincipal)
                                .imageScale(.large)
                        }
                    } else {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(corTextoPrincipal)
                                .imageScale(.large)
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(tituloDaToolbar())
                        .font(.headline).bold().foregroundColor(corTextoPrincipal)
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if modoCriacaoEdicaoAtivo {
                        Button(idSessaoEditando == nil ? "Salvar" : "Atualizar") {
                            salvarSessaoAtual()
                        }
                        .foregroundColor(corBotaoPrincipal)
                        .disabled(
                            (nomeSessaoAtual.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && nomeSessaoInteragido)
                            || exerciciosSessaoAtual.isEmpty
                        )
                    } else {
                        Button(action: { showAlertInfo.toggle() }) {
                            Image(systemName: "info.circle").foregroundColor(corTextoPrincipal)
                        }
                        Button(action: {
                            if gerenciadorSessoes.podeCriarNovaSessao {
                                prepararNovaSessao()
                            } else {
                                feedbackAlertTitle = "Limite Atingido"
                                feedbackAlertMessage = "Você atingiu o limite de \(gerenciadorSessoes.limiteMaximoSessoes) sessões."
                                showFeedbackAlert = true
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(corBotaoPrincipal).imageScale(.large)
                        }
                        .disabled(!gerenciadorSessoes.podeCriarNovaSessao)
                    }
                }
            }
            .alert(feedbackAlertTitle, isPresented: $showFeedbackAlert) { Button("OK"){} } message: { Text(feedbackAlertMessage) }
            .alert("Como funciona", isPresented: $showAlertInfo) { Button("Entendido", action: { showAlertInfo = false }) } message: { Text("Você pode criar novas sessões ao clicar no botão de + no canto superior direito da tela.") }
        }
        .accentColor(corBotaoPrincipal)
        .navigationBarBackButtonHidden(true)
    }

    @ViewBuilder
    private func editorDeSessaoView() -> some View {
        VStack(spacing: 15) {
            TextField(
                "",
                text: $nomeSessaoAtual,
                prompt: Text(textoPlaceholderNomeSessao()).foregroundColor(placeholderColor)
            )
            .onChange(of: nomeSessaoAtual, perform: { _ in nomeSessaoInteragido = true })
            .foregroundColor(corTextoPrincipal)
            .padding()
            .background(textFieldPrincipalBackgroundColor)
            .cornerRadius(10)
            .padding(.horizontal)
            .onAppear {
                if idSessaoEditando == nil && !nomeSessaoInteragido && nomeSessaoAtual.isEmpty {
                    nomeSessaoAtual = gerarNomeSessaoPlaceholderCalculado()
                }
            }
             .onTapGesture {
                 if idSessaoEditando == nil && nomeSessaoAtual == gerarNomeSessaoPlaceholderCalculado() && !nomeSessaoInteragido {
                     nomeSessaoAtual = ""
                 }
            }
            if !exerciciosSessaoAtual.isEmpty {
                HStack {
                    Text("SÉRIE").modifier(CabecalhoSerieStyle())
                    Text("PESO").modifier(CabecalhoSerieStyle(alignment: .center))
                    Text("REPS").modifier(CabecalhoSerieStyle(alignment: .center))
                    Text("DESCANSO").modifier(CabecalhoSerieStyle(alignment: .center))
                }
                .padding(.horizontal)
            }
            List {
                ForEach($exerciciosSessaoAtual) { $itemSessaoBinding in // Renomeado para clareza
                    ExercicioSessaoRowView(
                        itemSessao: $itemSessaoBinding,
                        corBotaoPrincipal: corBotaoPrincipal,
                        excluirSerieAction: self.excluirSerieDoExercicioPorSwipe,
                        adicionarSerieAction: self.adicionarSerie
                    )
                }
                .onDelete(perform: excluirExercicioDaSessao) // DE AddModel+Actions.swift
            }
            .listStyle(.plain)
            .background(Color("BackgroundColor"))
            .scrollContentBackground(.hidden)

            NavigationLink(destination: ExerciseListView(
                aoSelecionarExercicio: { exercicioLocalSelecionado in
                    adicionarExercicioASessao(exercicioLocal: exercicioLocalSelecionado)
                }
            )) {
                Label("Adicionar Exercício", systemImage: "plus.rectangle.on.rectangle.fill")
                    .font(.headline).foregroundColor(.white).padding()
                    .frame(maxWidth: .infinity)
                    .background(corBotaoPrincipal.opacity(0.85)).cornerRadius(12)
            }.padding([.horizontal, .bottom])
        }
    }

    @ViewBuilder
    private func listaDeSessoesView() -> some View {
         VStack(spacing: 0) {
            if gerenciadorSessoes.sessoesDeTreinoSalvas.isEmpty && !gerenciadorSessoes.podeCriarNovaSessao {
                Spacer()
                Text("Limite de sessões atingido.\nNenhuma sessão salva para exibir.")
                    .font(.headline).foregroundColor(.orange).multilineTextAlignment(.center).padding()
                Spacer()
            } else if gerenciadorSessoes.sessoesDeTreinoSalvas.isEmpty {
                Spacer()
                Image(systemName: "figure.strengthtraining.traditional")
                     .font(.system(size: 70)).foregroundColor(corTextoPrincipal.opacity(0.3))
                     .padding(.bottom)
                Text("Nenhuma sessão de treino salva.").font(.title3).foregroundColor(corTextoSecundario)
                Spacer()
            } else {
                Text("Minhas Sessões (\(gerenciadorSessoes.sessoesDeTreinoSalvas.count)/\(gerenciadorSessoes.limiteMaximoSessoes))")
                    .font(.footnote).foregroundColor(corTextoSecundario).padding()
                List {
                    ForEach(gerenciadorSessoes.sessoesDeTreinoSalvas) { sessao in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(sessao.nomeSessao).font(.headline).foregroundColor(corTextoPrincipal)
                                Text("\(sessao.exercicios.count) exercícios • Criada em: \(formatarData(sessao.dataCriacao))") 
                                    .font(.caption).foregroundColor(corTextoSecundario)
                            }
                            Spacer()
                            Image(systemName: "square.and.pencil").foregroundColor(corBotaoPrincipal)
                        }
                        .padding(.vertical, 8)
                        .contentShape(Rectangle())
                        .onTapGesture { carregarSessaoParaEdicao(sessao: sessao) }
                        .listRowBackground(Color.gray.opacity(0.15))
                        .listRowSeparatorTint(Color.gray.opacity(0.3))
                    }
                    .onDelete(perform: gerenciadorSessoes.excluirSessao)
                }
                .listStyle(.insetGrouped)
                .background(Color("BackgroundColor")).scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    AddModel()
        .environmentObject(GerenciadorSessoesViewModel())
        .preferredColorScheme(.dark)
}
