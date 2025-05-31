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
        carregarSessoesSalvas()
        carregarSessoesConcluidasCiclo()
        carregarDatasCiclosCompletos()
        atualizarContagemStreak()
        prepararDadosDeExibicaoDosTreinos()
        print("GerenciadorSessoesViewModel inicializado. Sessões: \(sessoesDeTreinoSalvas.count). Ciclos completos em: \(datasCiclosDeTreinoCompletosSet.count) dias. Streak: \(contagemStreakAtual) dias.")
        prepararDadosDeExibicaoDosTreinos()
    }
    func salvarOuAtualizarSessao(idSessao: UUID? = nil, nome: String, exercicios: [ExercicioNaSessao]) -> Bool {
            guard !nome.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                print("⚠️ Nome da sessão não pode ser vazio."); return false
            }
            guard !exercicios.isEmpty else {
                print("⚠️ A sessão de treino precisa ter pelo menos um exercício."); return false
            }
            if let idExistente = idSessao, let index = sessoesDeTreinoSalvas.firstIndex(where: { $0.id == idExistente }) {
                sessoesDeTreinoSalvas[index].nomeSessao = nome
                sessoesDeTreinoSalvas[index].exercicios = exercicios
                sessoesDeTreinoSalvas[index].dataCriacao = Date()
                print("✅ Sessão '\(nome)' atualizada.")
            } else if podeCriarNovaSessao {
                let novaSessao = SessaoDeTreino(nomeSessao: nome, exercicios: exercicios)
                sessoesDeTreinoSalvas.append(novaSessao)
                print("✅ Nova Sessão '\(nome)' salva. Total: \(sessoesDeTreinoSalvas.count).")
            } else {
                print("⚠️ Limite de sessões atingido.")
                return false
            }
            persistirSessoes()
             if idSessao == nil {
                sessoesConcluidasNesteCicloSet.removeAll()
                persistirSessoesConcluidasCiclo()
             }
            return true
        }
    func excluirSessao(at offsets: IndexSet) {
        sessoesDeTreinoSalvas.remove(atOffsets: offsets)
        sessoesConcluidasNesteCicloSet.removeAll()
        persistirSessoes()
        persistirSessoesConcluidasCiclo()
        atualizarContagemStreak()
        prepararDadosDeExibicaoDosTreinos()
        print("Sessão excluída.")
    }
    func registrarSessaoIndividualConcluida(idSessaoConcluida: UUID, dataConclusao: Date = Date()) {
        if let ultimaSessaoTS = dataUltimaSessaoIndividualConcluidaTS,
           Calendar.current.isDateInToday(Date(timeIntervalSinceReferenceDate: ultimaSessaoTS)) {
            print("Uma sessão individual já foi concluída hoje. Não registrando novamente.")
            
            return
        }
        sessoesConcluidasNesteCicloSet.insert(idSessaoConcluida)
        persistirSessoesConcluidasCiclo()

        let dataNormalizada = Calendar.current.startOfDay(for: dataConclusao)
        self.dataUltimaSessaoIndividualConcluidaTS = dataNormalizada.timeIntervalSinceReferenceDate
        
        if self.dataPrimeiroUsoOuTreinoTS == nil {
            self.dataPrimeiroUsoOuTreinoTS = dataNormalizada.timeIntervalSinceReferenceDate
        }
        print("Sessão \(idSessaoConcluida) marcada como concluída para o ciclo atual em \(dataNormalizada).")
        verificarSeCicloCompleto(dataConclusaoCiclo: dataConclusao)
        prepararDadosDeExibicaoDosTreinos() // Atualiza qual é o próximo treino
    }
    private func verificarSeCicloCompleto(dataConclusaoCiclo: Date) {
        guard !sessoesDeTreinoSalvas.isEmpty else {
            print("Nenhuma sessão de treino salva para verificar ciclo."); return
        }
        let todosIDsDasSessoesSalvas = Set(sessoesDeTreinoSalvas.map { $0.id })
        
        if sessoesConcluidasNesteCicloSet.isSuperset(of: todosIDsDasSessoesSalvas) {

            let dataNormalizada = Calendar.current.startOfDay(for: dataConclusaoCiclo)
            datasCiclosDeTreinoCompletosSet.insert(dataNormalizada)
            persistirDatasCiclosCompletos()
            
            sessoesConcluidasNesteCicloSet.removeAll()
            persistirSessoesConcluidasCiclo()
            
            print("Dia de streak adicionado para: \(dataNormalizada). Ciclo resetado.")
            atualizarContagemStreak()
        } else {
            print("Ciclo ainda não completo. Concluídas: \(sessoesConcluidasNesteCicloSet.count)/\(todosIDsDasSessoesSalvas.count)")
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
    private func carregarSessoesSalvas() {
         if let data = UserDefaults.standard.data(forKey: "sessoesSalvas"),
            let decoded = try? JSONDecoder().decode([SessaoDeTreino].self, from: data) {
             sessoesDeTreinoSalvas = decoded
        }
    }
    private func persistirSessoes() {
         if let encoded = try? JSONEncoder().encode(sessoesDeTreinoSalvas) {
             UserDefaults.standard.set(encoded, forKey: "sessoesSalvas")
         }
    }

    private func carregarSessoesConcluidasCiclo() {
        if let decoded = try? JSONDecoder().decode(Set<UUID>.self, from: sessoesConcluidasCicloAtualIDsData) {
            sessoesConcluidasNesteCicloSet = decoded
        } else {
            sessoesConcluidasNesteCicloSet = []
        }
    }
    private func persistirSessoesConcluidasCiclo() {
        if let encoded = try? JSONEncoder().encode(sessoesConcluidasNesteCicloSet) {
            sessoesConcluidasCicloAtualIDsData = encoded
        }
    }
    private func carregarDatasCiclosCompletos() {
        if let decoded = try? JSONDecoder().decode(Set<Date>.self, from: datasCiclosDeTreinoCompletosData) {
            datasCiclosDeTreinoCompletosSet = decoded
        } else {
            datasCiclosDeTreinoCompletosSet = []
        }
        atualizarContagemStreak()
    }
    private func persistirDatasCiclosCompletos() {
        if let encoded = try? JSONEncoder().encode(datasCiclosDeTreinoCompletosSet) {
            datasCiclosDeTreinoCompletosData = encoded
        }
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
