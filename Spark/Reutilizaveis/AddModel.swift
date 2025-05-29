// Arquivo: AddModel.swift
import SwiftUI

struct AddModel: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var gerenciadorSessoes: GerenciadorSessoesViewModel

    @State private var idSessaoEditando: UUID? = nil
    @State private var nomeSessaoAtual: String = ""
    @State private var exerciciosSessaoAtual: [ExercicioNaSessao] = []

    let textFieldPrincipalBackgroundColor = Color.gray.opacity(0.25)
    let placeholderColor = Color.gray.opacity(0.6)
    let corBotaoPrincipal = Color("CorBotao")
    let corTextoPrincipal = Color.white
    let corTextoSecundario = Color.gray
    
    @State private var showAlertInfo = false
    @State private var showFeedbackAlert = false
    @State private var feedbackAlertMessage = ""
    @State private var feedbackAlertTitle = "Aviso"

    @State private var modoCriacaoEdicaoAtivo: Bool = false
    @State private var nomeSessaoEditadoPeloUsuario: Bool = false

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
                            Image(systemName: "chevron.left").foregroundColor(corTextoPrincipal).imageScale(.medium)
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
                            (nomeSessaoAtual.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && (idSessaoEditando != nil || nomeSessaoEditadoPeloUsuario))
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
            .alert(feedbackAlertTitle, isPresented: $showFeedbackAlert) { Button("OK"){} } message: {
                Text(feedbackAlertMessage) }
            .alert("Como funciona", isPresented: $showAlertInfo) { Button("Entendido", action: {}) } message: {
                Text("Você pode criar novas sessões ao clicar no botão de + no canto superior direito da tela. Ao clicar no ícone de lista, você pode acessar as suas sessões já criadas") }
        }
        .accentColor(corBotaoPrincipal)
    }
    @ViewBuilder
    private func editorDeSessaoView() -> some View {
        VStack(spacing: 12) {
            TextField(
                "",
                text: Binding(
                    get: { self.nomeSessaoAtual },
                    set: { newValue in
                        self.nomeSessaoAtual = newValue
                        self.nomeSessaoEditadoPeloUsuario = true
                    }
                ),
                prompt: Text(textoPlaceholderNomeSessao()).foregroundColor(placeholderColor)
            )
            .foregroundColor(corTextoPrincipal)
            .padding()
            .background(textFieldPrincipalBackgroundColor)
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 15)
            .onAppear {
                if idSessaoEditando == nil && !nomeSessaoEditadoPeloUsuario {
                }
            }
            if !exerciciosSessaoAtual.isEmpty {
                HStack {
                    Text("SÉRIE").modifier(CabecalhoSerieStyle())
                    Text("PESO").modifier(CabecalhoSerieStyle(alignment: .center))
                    Text("REPS").modifier(CabecalhoSerieStyle(alignment: .center))
                    Text("DESCANSO").modifier(CabecalhoSerieStyle(alignment: .center))
                    Spacer().frame(width: 30)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, -2)
            }
            List {
                ForEach($exerciciosSessaoAtual) { $itemSessao in
                    Section(header:
                        Text(itemSessao.exercicioBase.nome)
                            .font(.title3).bold()
                            .foregroundColor(corBotaoPrincipal)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .textCase(nil)
                    ) {
                        ForEach($itemSessao.series) { $serieDetalhe in
                            SerieRowView(
                                serie: $serieDetalhe,
                                canBeDeleted: itemSessao.series.count > 1,
                                onDelete: {
                                    removerSerieComObjeto(de: itemSessao.id, serieParaRemover: serieDetalhe)
                                }
                            )
                        }
                        
                        Button(action: { adicionarSerie(a: itemSessao.id) }) {
                            HStack { Image(systemName: "plus.circle.fill"); Text("Adicionar Série") }
                                .font(.caption.bold()).foregroundColor(corBotaoPrincipal)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 6)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .onDelete(perform: excluirExercicioDaSessao)
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
            }
            .padding(.horizontal)
            .padding(.bottom, 25)
        }
    }

    @ViewBuilder
    private func listaDeSessoesView() -> some View {
         VStack {
            if gerenciadorSessoes.sessoesDeTreinoSalvas.isEmpty && !gerenciadorSessoes.podeCriarNovaSessao {
                Spacer()
                Text("Limite de sessões atingido.\nNenhuma sessão salva para exibir.")
                    .font(.headline).foregroundColor(.orange).multilineTextAlignment(.center).padding()
                Spacer()
            } else if gerenciadorSessoes.sessoesDeTreinoSalvas.isEmpty {
                Spacer()
                Image(systemName: "figure.strengthtraining.traditional")
                     .font(.system(size: 70)).foregroundColor(corTextoPrincipal.opacity(0.3)).padding(.bottom)
                Text("Nenhuma sessão de treino.")
                    .font(.title3)
                    .foregroundColor(corTextoSecundario)
                
                Spacer()
            } else {
                Text("Minhas Sessões (\(gerenciadorSessoes.sessoesDeTreinoSalvas.count)/\(gerenciadorSessoes.limiteMaximoSessoes))")
                    .font(.callout).foregroundColor(corTextoSecundario).padding(.top)
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
                        .padding(.vertical, 6)
                        .contentShape(Rectangle())
                        .onTapGesture { carregarSessaoParaEdicao(sessao: sessao) }
                        .listRowBackground(Color.gray.opacity(0.15))
                    }
                    .onDelete(perform: gerenciadorSessoes.excluirSessao)
                }
                .listStyle(.insetGrouped)
                .background(Color("BackgroundColor")).scrollContentBackground(.hidden)
            }
        }
        .padding(.top)
    }
    func prepararNovaSessao() {
        idSessaoEditando = nil
        nomeSessaoAtual = gerarNomeSessaoPlaceholderCalculado()
        exerciciosSessaoAtual = []
        modoCriacaoEdicaoAtivo = true
        nomeSessaoEditadoPeloUsuario = false
    }

    func carregarSessaoParaEdicao(sessao: SessaoDeTreino) {
        idSessaoEditando = sessao.id
        nomeSessaoAtual = sessao.nomeSessao
        exerciciosSessaoAtual = sessao.exercicios
        modoCriacaoEdicaoAtivo = true
        nomeSessaoEditadoPeloUsuario = true
    }
    
    func cancelarEdicaoOuCriacao() {
        modoCriacaoEdicaoAtivo = false
        if idSessaoEditando == nil {
            nomeSessaoAtual = ""
            exerciciosSessaoAtual = []
        }
        idSessaoEditando = nil
        nomeSessaoEditadoPeloUsuario = false
    }

    func salvarSessaoAtual() {
        var nomeFinalParaSalvar = nomeSessaoAtual.trimmingCharacters(in: .whitespacesAndNewlines)
        let placeholderCalculadoAoSalvar = gerarNomeSessaoPlaceholderCalculado(considerandoSessaoAtualComoPotencialmenteNova: idSessaoEditando == nil)

        if idSessaoEditando == nil { // Nova sessão
            if nomeFinalParaSalvar.isEmpty && !nomeSessaoEditadoPeloUsuario {
                nomeFinalParaSalvar = placeholderCalculadoAoSalvar
            } else if nomeFinalParaSalvar.isEmpty && nomeSessaoEditadoPeloUsuario {
                feedbackAlertTitle = "Nome Inválido"; feedbackAlertMessage = "Por favor, dê um nome para a sua sessão."; showFeedbackAlert = true; return
            }
        } else {
             if nomeFinalParaSalvar.isEmpty {
                 feedbackAlertTitle = "Nome Inválido"; feedbackAlertMessage = "O nome da sessão não pode ficar vazio."; showFeedbackAlert = true; return
             }
        }


        if exerciciosSessaoAtual.isEmpty {
            feedbackAlertTitle = "Sessão Vazia"; feedbackAlertMessage = "Adicione pelo menos um exercício."; showFeedbackAlert = true; return
        }

        if gerenciadorSessoes.salvarOuAtualizarSessao(idSessao: idSessaoEditando, nome: nomeFinalParaSalvar, exercicios: exerciciosSessaoAtual) {
            feedbackAlertTitle = "Sucesso!"
            feedbackAlertMessage = "Sessão '\(nomeFinalParaSalvar)' foi salva."
            modoCriacaoEdicaoAtivo = false
            nomeSessaoAtual = ""; exerciciosSessaoAtual = []; idSessaoEditando = nil
            nomeSessaoEditadoPeloUsuario = false
        } else {
            feedbackAlertTitle = "Falha ao Salvar"
            if !gerenciadorSessoes.podeCriarNovaSessao && idSessaoEditando == nil {
                feedbackAlertMessage = "Limite de \(gerenciadorSessoes.limiteMaximoSessoes) sessões atingido."
            } else {
                feedbackAlertMessage = "Não foi possível salvar. Verifique os dados."
            }
        }
        showFeedbackAlert = true
    }

    func adicionarExercicioASessao(exercicioLocal: ExercicioLocal) {
        let novoExercicioSessao = ExercicioNaSessao(exercicioBase: exercicioLocal, series: [SerieDetalhe(numeroSerie: 1)])
        self.exerciciosSessaoAtual.append(novoExercicioSessao)
    }

    func excluirExercicioDaSessao(at offsets: IndexSet) {
        exerciciosSessaoAtual.remove(atOffsets: offsets)
    }

    func adicionarSerie(a idExercicioSessao: UUID) {
        if let index = exerciciosSessaoAtual.firstIndex(where: { $0.id == idExercicioSessao }) {
            let proximoNumeroSerie = (exerciciosSessaoAtual[index].series.last?.numeroSerie ?? 0) + 1
            exerciciosSessaoAtual[index].series.append(SerieDetalhe(numeroSerie: proximoNumeroSerie))
        }
    }

    func removerSerieComObjeto(de idExercicioSessao: UUID, serieParaRemover: SerieDetalhe) {
        if let indexExercicio = exerciciosSessaoAtual.firstIndex(where: { $0.id == idExercicioSessao }) {
            if exerciciosSessaoAtual[indexExercicio].series.count <= 1 {
                feedbackAlertTitle = "Aviso"; feedbackAlertMessage = "Cada exercício deve ter pelo menos uma série."; showFeedbackAlert = true; return
            }
            exerciciosSessaoAtual[indexExercicio].series.removeAll(where: { $0.id == serieParaRemover.id })
            for i in 0..<exerciciosSessaoAtual[indexExercicio].series.count {
                exerciciosSessaoAtual[indexExercicio].series[i].numeroSerie = i + 1
            }
        }
    }
    
    private func formatarData(_ data: Date) -> String {
        let formatter = DateFormatter(); formatter.dateStyle = .short; formatter.timeStyle = .none
        return formatter.string(from: data)
    }

    private func gerarNomeSessaoPlaceholderCalculado(considerandoSessaoAtualComoPotencialmenteNova: Bool = true) -> String {
        var proximoIndice = gerenciadorSessoes.sessoesDeTreinoSalvas.count

        if !considerandoSessaoAtualComoPotencialmenteNova && idSessaoEditando != nil {
            return "Nome da sessão"
        }

        if proximoIndice < gerenciadorSessoes.limiteMaximoSessoes {
            if proximoIndice < 26 {
                 let letra = String(UnicodeScalar("A".unicodeScalars.first!.value + UInt32(proximoIndice))!)
                 return "Treino \(letra)"
            } else {
                 return "Treino \(proximoIndice + 1)"
            }
        }
        return "Nova Sessão"
    }
    
    
    private func textoPlaceholderNomeSessao() -> String {
        if idSessaoEditando == nil {
            if !nomeSessaoEditadoPeloUsuario && nomeSessaoAtual == gerarNomeSessaoPlaceholderCalculado() {
                return nomeSessaoAtual
            }
            return gerarNomeSessaoPlaceholderCalculado()
        }
        return "Nome da sessão"
    }
    
    private func tituloDaToolbar() -> String {
        if modoCriacaoEdicaoAtivo {
            if idSessaoEditando == nil {
                if nomeSessaoAtual == gerarNomeSessaoPlaceholderCalculado() && !nomeSessaoEditadoPeloUsuario {
                    return "Nova Sessão"
                }
    
                return nomeSessaoAtual.isEmpty ? "Nova Sessão" : nomeSessaoAtual
            } else {
                return "Editar: \(nomeSessaoAtual.isEmpty ? "Sessão" : nomeSessaoAtual)"
            }
        } else {
            return "Minhas Sessões"
        }
    }
}

struct SerieRowView: View {
    @Binding var serie: SerieDetalhe
    let canBeDeleted: Bool
    var onDelete: () -> Void

    let placeholderColor = Color.gray.opacity(0.6)

    var body: some View {
        HStack(spacing: 8) {
            Text("\(serie.numeroSerie)")
                .foregroundColor(Color.white.opacity(0.9))
                .modifier(CabecalhoSerieStyle(alignment: .center))

            TextField("", text: $serie.peso, prompt: Text(serie.peso.isEmpty || serie.peso == "--" ? "--" : serie.peso).foregroundColor(placeholderColor))
                .modifier(TextFieldEditorSerieStyle())
                .onTapGesture { if serie.peso == "--" { serie.peso = "" } }

            TextField("", text: $serie.reps, prompt: Text(serie.reps.isEmpty || serie.reps == "8-12" ? "8-12" : serie.reps).foregroundColor(placeholderColor))
                .modifier(TextFieldEditorSerieStyle())
                .onTapGesture { if serie.reps == "8-12" { serie.reps = "" } }

            TextField("", text: $serie.descanso, prompt: Text(serie.descanso.isEmpty || serie.descanso == "2min" ? "2min" : serie.descanso).foregroundColor(placeholderColor))
                .modifier(TextFieldEditorSerieStyle())
                .onTapGesture { if serie.descanso == "2min" { serie.descanso = "" } }

            if canBeDeleted {
                Button(action: onDelete) {
                    Image(systemName: "minus.circle.fill").foregroundColor(.red.opacity(0.8)).imageScale(.medium)
                }.buttonStyle(BorderlessButtonStyle()).frame(width: 30, height: 30)
            } else {
                Spacer().frame(width: 30, height: 30)
            }
        }
        .padding(.vertical, 2)
    }
}

struct TextFieldEditorSerieStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
            .keyboardType(.default)
            .frame(maxWidth: .infinity, minHeight: 35)
            .multilineTextAlignment(.center)
            .overlay(
                VStack {
                    Spacer()
                    Rectangle().frame(height: 1).foregroundColor(Color.gray.opacity(0.4))
                }
            )
    }
}

//struct CabecalhoSerieStyle: ViewModifier {
//    var alignment: Alignment = .leading
//    func body(content: Content) -> some View {
//        content
//            .font(.caption.weight(.semibold))
//            .foregroundColor(.gray)
//            .frame(maxWidth: .infinity, alignment: alignment)
//    }
//}
#Preview {
    NavigationView {
        AddModel()
            .environmentObject(GerenciadorSessoesViewModel())
            .environmentObject(ExerciseViewModel())
            .preferredColorScheme(.dark)
    }
}
