import SwiftUI
import Combine

@MainActor
class GerenciadorSessoesViewModel: ObservableObject {
    @Published var sessoesDeTreinoSalvas: [SessaoDeTreino] = []
    let limiteMaximoSessoes = 6
    @AppStorage("sessoesConcluidasCicloAtualIDs_Data") private var sessoesConcluidasCicloAtualIDsData: Data = Data()
    @Published var sessoesConcluidasNesteCicloSet: Set<UUID> = []

    @AppStorage("dataUltimaSessaoIndividualConcluidaTS") var dataUltimaSessaoIndividualConcluidaTS: Double?
    @AppStorage("datasCiclosDeTreinoCompletos_Data") private var datasCiclosDeTreinoCompletosData: Data = Data()
    @Published var datasCiclosDeTreinoCompletosSet: Set<Date> = []
    @AppStorage("dataPrimeiroUsoOuTreino") var dataPrimeiroUsoOuTreinoTS: Double?
    @Published var contagemStreakAtual: Int = 0

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
        carregarSessoesSalvas()
        carregarSessoesConcluidasCiclo()
        carregarDatasCiclosCompletos()
        print("GerenciadorSessoesViewModel inicializado. Sessões: \(sessoesDeTreinoSalvas.count). Ciclos completos em: \(datasCiclosDeTreinoCompletosSet.count) dias. Streak: \(contagemStreakAtual) dias.")
    }

    private func persistirSessoes(sessoesParaSalvar: [SessaoDeTreino]) {
        DispatchQueue.global(qos: .background).async {
            if let encoded = try? JSONEncoder().encode(sessoesParaSalvar) {
                UserDefaults.standard.set(encoded, forKey: "sessoesSalvas")
            }
        }
    }

    private func persistirSessoesConcluidasCiclo(setParaSalvar: Set<UUID>) {
        DispatchQueue.global(qos: .background).async {
            if let encoded = try? JSONEncoder().encode(setParaSalvar) {
                UserDefaults.standard.set(encoded, forKey: "sessoesConcluidasCicloAtualIDs_Data")
            }
        }
    }
    
    private func persistirDatasCiclosCompletos(datasParaSalvar: Set<Date>) {
        DispatchQueue.global(qos: .background).async {
            if let encoded = try? JSONEncoder().encode(datasParaSalvar) {
                UserDefaults.standard.set(encoded, forKey: "datasCiclosDeTreinoCompletos_Data")
            }
        }
    }

    func salvarOuAtualizarSessao(idSessao: UUID? = nil, nome: String, exercicios: [ExercicioNaSessao]) -> Bool {
        guard !nome.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        guard !exercicios.isEmpty else {
            return false
        }
        var sessaoModificadaComSucesso = false
        let dataAtual = Date()
        if let idExistente = idSessao, let index = sessoesDeTreinoSalvas.firstIndex(where: { $0.id == idExistente }) {
            sessoesDeTreinoSalvas[index].nomeSessao = nome
            sessoesDeTreinoSalvas[index].exercicios = exercicios
            sessoesDeTreinoSalvas[index].dataCriacao = dataAtual
            sessaoModificadaComSucesso = true
        } else if podeCriarNovaSessao {
            let novaSessao = SessaoDeTreino(id: UUID(), nomeSessao: nome, exercicios: exercicios, dataCriacao: dataAtual)
            sessoesDeTreinoSalvas.append(novaSessao)
            sessaoModificadaComSucesso = true
        } else {
            return false
        }
        if sessaoModificadaComSucesso {
            persistirSessoes(sessoesParaSalvar: Array(self.sessoesDeTreinoSalvas))
            if idSessao == nil {
                let setVazio: Set<UUID> = []
                self.sessoesConcluidasNesteCicloSet = setVazio
                persistirSessoesConcluidasCiclo(setParaSalvar: setVazio)
            }
        }
        return sessaoModificadaComSucesso
    }

    func excluirSessao(at offsets: IndexSet) {
        sessoesDeTreinoSalvas.remove(atOffsets: offsets)
        let setVazio: Set<UUID> = []
        self.sessoesConcluidasNesteCicloSet = setVazio
        persistirSessoes(sessoesParaSalvar: Array(self.sessoesDeTreinoSalvas))
        persistirSessoesConcluidasCiclo(setParaSalvar: setVazio)
        atualizarContagemStreak()
    }

    func registrarSessaoIndividualConcluida(idSessaoConcluida: UUID, dataConclusao: Date = Date()) {
        if let ultimaSessaoTS = dataUltimaSessaoIndividualConcluidaTS,
           Calendar.current.isDateInToday(Date(timeIntervalSinceReferenceDate: ultimaSessaoTS)) {
            return
        }
        var concluidasAtualmente = self.sessoesConcluidasNesteCicloSet
        concluidasAtualmente.insert(idSessaoConcluida)
        self.sessoesConcluidasNesteCicloSet = concluidasAtualmente
        persistirSessoesConcluidasCiclo(setParaSalvar: Set(self.sessoesConcluidasNesteCicloSet))
        let dataNormalizada = Calendar.current.startOfDay(for: dataConclusao)
        self.dataUltimaSessaoIndividualConcluidaTS = dataNormalizada.timeIntervalSinceReferenceDate
        if self.dataPrimeiroUsoOuTreinoTS == nil {
            self.dataPrimeiroUsoOuTreinoTS = dataNormalizada.timeIntervalSinceReferenceDate
        }
        verificarSeCicloCompleto(dataConclusaoCiclo: dataConclusao)
    }

    private func verificarSeCicloCompleto(dataConclusaoCiclo: Date) {
        guard !sessoesDeTreinoSalvas.isEmpty else {
            return
        }
        let todosIDsDasSessoesSalvas = Set(sessoesDeTreinoSalvas.map { $0.id })
        if sessoesConcluidasNesteCicloSet.isSuperset(of: todosIDsDasSessoesSalvas) {
            let dataNormalizada = Calendar.current.startOfDay(for: dataConclusaoCiclo)
            var datasCompletasAtuais = self.datasCiclosDeTreinoCompletosSet
            datasCompletasAtuais.insert(dataNormalizada)
            self.datasCiclosDeTreinoCompletosSet = datasCompletasAtuais
            persistirDatasCiclosCompletos(datasParaSalvar: datasCompletasAtuais)
            let setVazio: Set<UUID> = []
            self.sessoesConcluidasNesteCicloSet = setVazio
            persistirSessoesConcluidasCiclo(setParaSalvar: setVazio)
            atualizarContagemStreak()
        }
    }

    private func carregarSessoesSalvas() {
         if let data = UserDefaults.standard.data(forKey: "sessoesSalvas"),
            let decoded = try? JSONDecoder().decode([SessaoDeTreino].self, from: data) {
             sessoesDeTreinoSalvas = decoded
        }
    }
    
    private func carregarSessoesConcluidasCiclo() {
        if let data = UserDefaults.standard.data(forKey: "sessoesConcluidasCicloAtualIDs_Data"),
           let decoded = try? JSONDecoder().decode(Set<UUID>.self, from: data) {
            sessoesConcluidasNesteCicloSet = decoded
        } else {
            sessoesConcluidasNesteCicloSet = []
        }
    }

    private func carregarDatasCiclosCompletos() {
        if let data = UserDefaults.standard.data(forKey: "datasCiclosDeTreinoCompletos_Data"),
           let decoded = try? JSONDecoder().decode(Set<Date>.self, from: data) {
            datasCiclosDeTreinoCompletosSet = decoded
        } else {
            datasCiclosDeTreinoCompletosSet = []
        }
        atualizarContagemStreak()
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
}
