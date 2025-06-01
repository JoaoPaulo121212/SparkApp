import SwiftUI
import Combine

@MainActor
class GerenciadorSessoesViewModel: ObservableObject {
    @Published var sessoesDeTreinoSalvas: [SessaoDeTreino] = []
    let limiteMaximoSessoes = 6
    // A chave aqui é "sessoesConcluidasCicloAtualIDs_Data"
    @AppStorage("sessoesConcluidasCicloAtualIDs_Data") private var sessoesConcluidasCicloAtualIDsData: Data = Data()
    @Published var sessoesConcluidasNesteCicloSet: Set<UUID> = []

    @AppStorage("dataUltimaSessaoIndividualConcluidaTS") var dataUltimaSessaoIndividualConcluidaTS: Double?
    @AppStorage("datasCiclosDeTreinoCompletos_Data") private var datasCiclosDeTreinoCompletosData: Data = Data()
    @Published var datasCiclosDeTreinoCompletosSet: Set<Date> = []
    @AppStorage("dataPrimeiroUsoOuTreino") var dataPrimeiroUsoOuTreinoTS: Double?
    @Published var contagemStreakAtual: Int = 0
    @Published var treinoDeHojeParaExibir: SessaoDeTreino? = nil
    @Published var proximosTreinosDoCicloParaExibir: [SessaoDeTreino] = []

    var podeCriarNovaSessao: Bool {
        sessoesDeTreinoSalvas.count < limiteMaximoSessoes
    }

    var podeRealizarSessaoHoje: Bool {
        guard let ultimaSessaoTimestamp = dataUltimaSessaoIndividualConcluidaTS else {
            return true
        }
        let ultimaDataConcluida = Date(timeIntervalSinceReferenceDate: ultimaSessaoTimestamp)
        return !Calendar.current.isDateInToday(ultimaDataConcluida)
    }

    init() {
        carregarSessoesSalvas() // Síncrono, pode ser otimizado no futuro se necessário
        carregarSessoesConcluidasCiclo() // Síncrono, pode ser otimizado no futuro se necessário
        carregarDatasCiclosCompletos() // Síncrono, pode ser otimizado no futuro se necessário
        atualizarContagemStreak()
        prepararDadosDeExibicaoDosTreinos()
        print("GerenciadorSessoesViewModel inicializado. Sessões: \(sessoesDeTreinoSalvas.count). Ciclos completos em: \(datasCiclosDeTreinoCompletosSet.count) dias. Streak: \(contagemStreakAtual) dias.")
    }

    // MARK: - Métodos de Persistência Modificados (Background Thread)

    private func persistirSessoes(sessoesParaSalvar: [SessaoDeTreino]) {
        DispatchQueue.global(qos: .background).async {
            print("🔄 Iniciando persistência de sessões em background...")
            if let encoded = try? JSONEncoder().encode(sessoesParaSalvar) {
                UserDefaults.standard.set(encoded, forKey: "sessoesSalvas")
                print("✅ 💿 Sessões persistidas em background.")
            } else {
                print("⚠️ Falha ao encodar sessões para persistência em background.")
            }
        }
    }

    private func persistirSessoesConcluidasCiclo(setParaSalvar: Set<UUID>) {
        DispatchQueue.global(qos: .background).async {
            print("🔄 Iniciando persistência de IDs de ciclo em background...")
            if let encoded = try? JSONEncoder().encode(setParaSalvar) {
                // Usando a chave correta do @AppStorage para escrita via UserDefaults
                UserDefaults.standard.set(encoded, forKey: "sessoesConcluidasCicloAtualIDs_Data")
                print("✅ 💿 IDs de ciclo persistidos em background.")
            } else {
                print("⚠️ Falha ao encodar IDs de ciclo para persistência em background.")
            }
        }
    }

    // MARK: - Métodos Principais com Chamadas de Persistência Atualizadas

    func salvarOuAtualizarSessao(idSessao: UUID? = nil, nome: String, exercicios: [ExercicioNaSessao]) -> Bool {
        guard !nome.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("⚠️ Nome da sessão não pode ser vazio."); return false
        }
        guard !exercicios.isEmpty else {
            print("⚠️ A sessão de treino precisa ter pelo menos um exercício."); return false
        }

        var sessaoModificadaComSucesso = false

        if let idExistente = idSessao, let index = sessoesDeTreinoSalvas.firstIndex(where: { $0.id == idExistente }) {
            sessoesDeTreinoSalvas[index].nomeSessao = nome
            sessoesDeTreinoSalvas[index].exercicios = exercicios
            sessoesDeTreinoSalvas[index].dataCriacao = Date()
            print("✅ Sessão '\(nome)' atualizada em memória.")
            sessaoModificadaComSucesso = true
        } else if podeCriarNovaSessao {
            let novaSessao = SessaoDeTreino(nomeSessao: nome, exercicios: exercicios)
            sessoesDeTreinoSalvas.append(novaSessao)
            print("✅ Nova Sessão '\(nome)' adicionada à memória. Total: \(sessoesDeTreinoSalvas.count).")
            sessaoModificadaComSucesso = true
        } else {
            print("⚠️ Limite de sessões atingido.")
            return false
        }

        if sessaoModificadaComSucesso {
            persistirSessoes(sessoesParaSalvar: self.sessoesDeTreinoSalvas)

            if idSessao == nil { // Se for uma nova sessão
                self.sessoesConcluidasNesteCicloSet.removeAll() // Modifica a propriedade @Published
                persistirSessoesConcluidasCiclo(setParaSalvar: self.sessoesConcluidasNesteCicloSet) // Passa o estado atual
            }
        }
        return sessaoModificadaComSucesso
    }

    func excluirSessao(at offsets: IndexSet) {
        sessoesDeTreinoSalvas.remove(atOffsets: offsets)
        self.sessoesConcluidasNesteCicloSet.removeAll() // Modifica a propriedade @Published

        persistirSessoes(sessoesParaSalvar: self.sessoesDeTreinoSalvas)
        persistirSessoesConcluidasCiclo(setParaSalvar: self.sessoesConcluidasNesteCicloSet)

        atualizarContagemStreak() // Estes métodos subsequentes podem precisar rodar após a persistência ter sido iniciada
        prepararDadosDeExibicaoDosTreinos() // ou podem depender apenas do estado em memória, o que é o caso aqui.
        print("Sessão excluída. Persistência iniciada em background.")
    }

    func registrarSessaoIndividualConcluida(idSessaoConcluida: UUID, dataConclusao: Date = Date()) {
        if let ultimaSessaoTS = dataUltimaSessaoIndividualConcluidaTS,
           Calendar.current.isDateInToday(Date(timeIntervalSinceReferenceDate: ultimaSessaoTS)) {
            print("Uma sessão individual já foi concluída hoje. Não registrando novamente.")
            return
        }

        self.sessoesConcluidasNesteCicloSet.insert(idSessaoConcluida) // Modifica a propriedade @Published
        persistirSessoesConcluidasCiclo(setParaSalvar: self.sessoesConcluidasNesteCicloSet)

        let dataNormalizada = Calendar.current.startOfDay(for: dataConclusao)
        self.dataUltimaSessaoIndividualConcluidaTS = dataNormalizada.timeIntervalSinceReferenceDate
        
        if self.dataPrimeiroUsoOuTreinoTS == nil {
            self.dataPrimeiroUsoOuTreinoTS = dataNormalizada.timeIntervalSinceReferenceDate
        }
        print("Sessão \(idSessaoConcluida) marcada como concluída para o ciclo atual em \(dataNormalizada). Persistência iniciada.")
        verificarSeCicloCompleto(dataConclusaoCiclo: dataConclusao)
        prepararDadosDeExibicaoDosTreinos()
    }

    private func verificarSeCicloCompleto(dataConclusaoCiclo: Date) {
        guard !sessoesDeTreinoSalvas.isEmpty else {
            print("Nenhuma sessão de treino salva para verificar ciclo."); return
        }
        let todosIDsDasSessoesSalvas = Set(sessoesDeTreinoSalvas.map { $0.id })
        
        if sessoesConcluidasNesteCicloSet.isSuperset(of: todosIDsDasSessoesSalvas) {
            let dataNormalizada = Calendar.current.startOfDay(for: dataConclusaoCiclo)
            datasCiclosDeTreinoCompletosSet.insert(dataNormalizada)
            persistirDatasCiclosCompletos() // Esta função também salva em UserDefaults e pode ser otimizada da mesma forma se necessário
            
            self.sessoesConcluidasNesteCicloSet.removeAll() // Modifica a propriedade @Published
            persistirSessoesConcluidasCiclo(setParaSalvar: self.sessoesConcluidasNesteCicloSet)
            
            print("Dia de streak adicionado para: \(dataNormalizada). Ciclo resetado. Persistência iniciada.")
            atualizarContagemStreak()
        } else {
            print("Ciclo ainda não completo. Concluídas: \(sessoesConcluidasNesteCicloSet.count)/\(todosIDsDasSessoesSalvas.count)")
        }
    }

    // MARK: - Funções de Carregamento (Síncronas - Podem ser otimizadas no futuro)

    private func carregarSessoesSalvas() {
         if let data = UserDefaults.standard.data(forKey: "sessoesSalvas"),
            let decoded = try? JSONDecoder().decode([SessaoDeTreino].self, from: data) {
             sessoesDeTreinoSalvas = decoded
        }
    }
    
    private func carregarSessoesConcluidasCiclo() {
        // Usa a propriedade @AppStorage 'sessoesConcluidasCicloAtualIDsData' para carregar,
        // que por sua vez lê de UserDefaults com a chave "sessoesConcluidasCicloAtualIDs_Data"
        if let decoded = try? JSONDecoder().decode(Set<UUID>.self, from: sessoesConcluidasCicloAtualIDsData) {
            sessoesConcluidasNesteCicloSet = decoded
        } else {
            sessoesConcluidasNesteCicloSet = []
        }
    }

    private func carregarDatasCiclosCompletos() {
        // Usa a propriedade @AppStorage 'datasCiclosDeTreinoCompletosData'
        if let decoded = try? JSONDecoder().decode(Set<Date>.self, from: datasCiclosDeTreinoCompletosData) {
            datasCiclosDeTreinoCompletosSet = decoded
        } else {
            datasCiclosDeTreinoCompletosSet = []
        }
        // atualizarContagemStreak() já é chamado no init após este carregamento
    }

    // MARK: - Outras Funções (sem alterações diretas na persistência aqui)
    // Manter as funções calcularSequenciaAtual, atualizarContagemStreak, prepararDadosDeExibicaoDosTreinos como estavam.
    // A função persistirDatasCiclosCompletos também existe e salva em UserDefaults.
    // Se ela for chamada frequentemente com muitos dados, ou se o arquivo dela se tornar grande,
    // considere aplicar o mesmo padrão de persistência em background para ela também.

    private func persistirDatasCiclosCompletos() {
        // Esta função ainda é síncrona. Se os dados de datasCiclosDeTreinoCompletosSet
        // se tornarem muito grandes, considere refatorar para background também.
        // Por enquanto, focamos nas que causam o travamento no salvamento da sessão.
        if let encoded = try? JSONEncoder().encode(datasCiclosDeTreinoCompletosSet) {
            datasCiclosDeTreinoCompletosData = encoded // Atualiza @AppStorage
        }
    }

    func calcularSequenciaAtual() -> Int {
        guard !datasCiclosDeTreinoCompletosSet.isEmpty else { return 0 }
        let calendario = Calendar.current
        var diaVerificando = calendario.startOfDay(for: Date())
        var sequencia = 0
        let datasOrdenadas = datasCiclosDeTreinoCompletosSet.sorted(by: >)
        var i = 0
        while i < datasOrdenadas.count {
            let dataCiclo = datasOrdenadas[i]
            if calendario.isDate(dataCiclo, inSameDayAs: diaVerificando) {
                sequencia += 1
                guard let diaAnterior = calendario.date(byAdding: .day, value: -1, to: diaVerificando) else { break }
                diaVerificando = calendario.startOfDay(for: diaAnterior)
                i += 1
            } else if dataCiclo < diaVerificando { break }
              else { i += 1 }
        }
        return sequencia
    }
    
    func atualizarContagemStreak() {
        self.contagemStreakAtual = calcularSequenciaAtual()
    }

    func prepararDadosDeExibicaoDosTreinos() {
        guard !sessoesDeTreinoSalvas.isEmpty else {
            self.treinoDeHojeParaExibir = nil
            self.proximosTreinosDoCicloParaExibir = []
            return
        }
        var proximasSessoesDoCiclo: [SessaoDeTreino] = []
        var jaFeitasNesteCiclo: [SessaoDeTreino] = []
        for sessao in sessoesDeTreinoSalvas {
            if sessoesConcluidasNesteCicloSet.contains(sessao.id) {
                jaFeitasNesteCiclo.append(sessao)
            } else {
                proximasSessoesDoCiclo.append(sessao)
            }
        }
        let cicloOrdenadoParaDisplay = proximasSessoesDoCiclo + jaFeitasNesteCiclo
                
        self.treinoDeHojeParaExibir = cicloOrdenadoParaDisplay.first
        self.proximosTreinosDoCicloParaExibir = Array(cicloOrdenadoParaDisplay.dropFirst())
                
        print("ViewModel: Treino de hoje para exibir: \(self.treinoDeHojeParaExibir?.nomeSessao ?? "Nenhum"). Próximos: \(self.proximosTreinosDoCicloParaExibir.map { $0.nomeSessao })")
    }
}
