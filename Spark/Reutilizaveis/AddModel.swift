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
                            Text("Cancelar").foregroundColor(corBotaoPrincipal)
                        }
                    } else {
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark").foregroundColor(corTextoPrincipal).imageScale(.medium)
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
                            (nomeSessaoAtual.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && (idSessaoEditando != nil || nomeSessaoInteragido))
                            || exerciciosSessaoAtual.isEmpty
                        )
                    } else {
                        NavigationLink(destination: TreinosTemplatesView()) {
                            Image(systemName: "list.bullet.clipboard").foregroundColor(corTextoPrincipal)
                        }
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
            .alert("Como funciona", isPresented: $showAlertInfo) { Button("Entendido", action: { showAlertInfo = false }) } message: { Text("Você pode criar novas sessões ao clicar no botão de + no canto superior direito da tela. Ao clicar no ícone de lista, você pode acessar os templates.") }
        }
        .accentColor(corBotaoPrincipal)
    }
    @ViewBuilder
    private func editorDeSessaoView() -> some View {
        VStack(spacing: 15) {
            TextField(
                "",
                text: Binding(
                    get: { self.nomeSessaoAtual },
                    set: { newValue in
                        self.nomeSessaoAtual = newValue
                        self.nomeSessaoInteragido = true
                    }
                ),
                prompt: Text(textoPlaceholderNomeSessao()).foregroundColor(placeholderColor)
            )
            .foregroundColor(corTextoPrincipal)
            .padding()
            .background(textFieldPrincipalBackgroundColor)
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 20)
            .onAppear {
                if idSessaoEditando == nil && !nomeSessaoInteragido {
                    nomeSessaoAtual = gerarNomeSessaoPlaceholderCalculado()
                }
            }
             .onTapGesture {
                 if idSessaoEditando == nil && nomeSessaoAtual == gerarNomeSessaoPlaceholderCalculado() && !nomeSessaoInteragido {
                     nomeSessaoAtual = ""
                     nomeSessaoInteragido = true
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
                .padding(.top, 10)
                .padding(.bottom, 5)
            }
            List {
                ForEach($exerciciosSessaoAtual) { $itemSessao in
                    Section(header:
                        Text(itemSessao.exercicioBase.nome)
                            .font(.title3).bold().foregroundColor(corBotaoPrincipal)
                            .padding(.vertical, 8).frame(maxWidth: .infinity, alignment: .leading)
                            .textCase(nil)
                    ) {
                        ForEach($itemSessao.series) { $serieDetalhe in
                            SerieRowView(serie: $serieDetalhe)
                        }
                        .onDelete { offsets in
                            excluirSerieDoExercicioPorSwipe(exercicioId: itemSessao.id, at: offsets)
                        }
                        Button(action: { adicionarSerie(a: itemSessao.id) }) {
                            HStack { Image(systemName: "plus.circle.fill"); Text("Adicionar Série") }
                                .font(.caption.bold()).foregroundColor(corBotaoPrincipal)
                        }
                        .frame(maxWidth: .infinity, alignment: .center).padding(.vertical, 6)
                    }
                    .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .onDelete(perform: excluirExercicioDaSessao)
            }
            .listStyle(.plain).background(Color("BackgroundColor")).scrollContentBackground(.hidden)
            .environment(\.editMode, .constant(.active))

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
                     .font(.system(size: 70)).foregroundColor(corTextoPrincipal.opacity(0.3)).padding(.bottom)
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
    NavigationView {
        AddModel()
            .environmentObject(GerenciadorSessoesViewModel())
            .preferredColorScheme(.dark)
    }
}
