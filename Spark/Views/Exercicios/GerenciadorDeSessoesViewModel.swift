import SwiftUI
import Combine

@MainActor
class GerenciadorSessoesViewModel: ObservableObject {
    @Published var sessoesDeTreinoSalvas: [SessaoDeTreino] = []
    @Published var sessoesParaExibir: [SessaoDeTreino] = []
    let limiteMaximoSessoes = 6
    
    @AppStorage("sessoesConcluidasCicloAtualIDs_Data") private var sessoesConcluidasCicloAtualIDsData: Data = Data()
    @Published var sessoesConcluidasNesteCicloSet: Set<UUID> = []
    
    @AppStorage("usuarioJaTeveSessoesPersonalizadas_v1") var usuarioJaTeveSessoesPersonalizadas: Bool = false
    @AppStorage("dataUltimaSessaoIndividualConcluidaTS") var dataUltimaSessaoIndividualConcluidaTS: Double?
    
    @AppStorage("datasCiclosDeTreinoCompletos_Data") private var datasCiclosDeTreinoCompletosData: Data = Data()
    @Published var datasCiclosDeTreinoCompletosSet: Set<Date> = []
    
    @AppStorage("dataPrimeiroUsoOuTreino") var dataPrimeiroUsoOuTreinoTS: Double?
    @Published var contagemStreakAtual: Int = 0
    
    @AppStorage("objetivoUsuarioApp") var objetivoUsuarioSalvo: String = ""
    @AppStorage("treinosIniciaisAppCriados") var treinosIniciaisCriados: Bool = false

    // MARK: - Propriedades para Histórico Detalhado de Treinos
    struct TreinoConcluidoInfo: Codable, Identifiable {
        let id = UUID()
        var idSessao: UUID
        var nomeSessao: String
        var dataConclusao: Date
    }
    @Published var historicoTreinosConcluidos: [TreinoConcluidoInfo] = []
    @AppStorage("historicoTreinosConcluidos_v1_Data") private var historicoTreinosConcluidosData: Data = Data()

    private let treinosPredefinidos: [String: [String: [String]]] = [
        "Emagrecimento": [
            "Superior Resistência & Cardio": ["Supino Reto na máquina", "Supino Inclinado com Halteres", "Crucifixo máquina (Peck Deck)", "Elevação Frontal com Halteres (Alternada ou Bilateral)", "Elevação Lateral com Halteres", "Tríceps Pulley com Corda", "Tríceps Testa com Barra W"],
            "Aeróbico Geral & Pernas Leve": ["Corrida", "Agachamento Livre com Barra", "Bicicleta Ergométrica"],
            "Circuito HIIT Corporal": ["Burpees", "Mountain Climbers", "Jumping Jacks"]
        ],
        "Ganho de massa muscular": [
            "Peito, Ombros & Tríceps (GM)": ["Supino Reto na máquina", "Supino Inclinado com Halteres", "Crucifixo máquina (Peck Deck)", "Elevação Frontal com Halteres (Alternada ou Bilateral)", "Elevação Lateral com Halteres", "Tríceps Pulley com Corda", "Tríceps Testa com Barra W"],
            "Pernas & Panturrilhas (GM)": ["Agachamento Livre com Barra", "Leg Press 45°", "Cadeira Extensora", "Mesa Flexora", "Cadeira Flexora", "Panturrilha em Pé (Smith ou Máquina de Panturrilha)", "Panturrilha Sentado"],
            "Costas & Bíceps (GM)": ["Puxada Alta Frontal (Pulley)", "Remada Baixa (Remada Sentada na Polia)", "Pulldown com Braços Retos (Polia Alta)", "Remada Curvada com Barra", "Rosca Direta com Barra", "Rosca Inclinada com Halteres"]
        ]
    ]
    
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
        carregarHistoricoTreinosConcluidos()
        
        print("DEBUG: GerenciadorSessoesViewModel inicializado. Sessões salvas: \(sessoesDeTreinoSalvas.count). Treinos iniciais já criados: \(treinosIniciaisCriados). Objetivo salvo: '\(objetivoUsuarioSalvo)'.")
        atualizarSessoesParaExibir()
    }
    
    private func carregarHistoricoTreinosConcluidos() {
        if let decoded = try? JSONDecoder().decode([TreinoConcluidoInfo].self, from: historicoTreinosConcluidosData) {
            self.historicoTreinosConcluidos = decoded
            print("DEBUG: Histórico de treinos concluídos carregado: \(self.historicoTreinosConcluidos.count) registros.")
        } else {
            self.historicoTreinosConcluidos = []
            print("DEBUG: Nenhum histórico de treinos concluídos válido encontrado ou falha ao decodificar. Iniciando com histórico vazio.")
        }
    }

    private func persistirHistoricoTreinosConcluidos() {
        let calendario = Calendar.current
        let dataLimite = calendario.date(byAdding: .day, value: -90, to: Date()) ?? Date()
        let historicoRecente = self.historicoTreinosConcluidos.filter { $0.dataConclusao >= dataLimite }
        DispatchQueue.global(qos: .background).async {
            do {
                let encoded = try JSONEncoder().encode(historicoRecente)
                UserDefaults.standard.set(encoded, forKey: "historicoTreinosConcluidos_v1_Data")
                print("DEBUG: Histórico de treinos concluídos persistido (\(historicoRecente.count) registros recentes).")
            } catch {
                print("DEBUG: ERRO ao persistir histórico de treinos concluídos: \(error)")
            }
        }
    }
    
    func registrarSessaoIndividualConcluida(idSessaoConcluida: UUID, dataConclusao: Date = Date()) {
        let calendario = Calendar.current
        
        if let ultimaSessaoTS = dataUltimaSessaoIndividualConcluidaTS,
           calendario.isDateInToday(Date(timeIntervalSinceReferenceDate: ultimaSessaoTS)) {
            print("DEBUG: Sessão individual já registrada hoje.")
        }
        
        var concluidasAtualmente = self.sessoesConcluidasNesteCicloSet
        concluidasAtualmente.insert(idSessaoConcluida)
        self.sessoesConcluidasNesteCicloSet = concluidasAtualmente
        persistirSessoesConcluidasCiclo(setParaSalvar: Set(self.sessoesConcluidasNesteCicloSet))

        let dataNormalizada = calendario.startOfDay(for: dataConclusao)
        self.dataUltimaSessaoIndividualConcluidaTS = dataNormalizada.timeIntervalSinceReferenceDate
        if self.dataPrimeiroUsoOuTreinoTS == nil {
            self.dataPrimeiroUsoOuTreinoTS = dataNormalizada.timeIntervalSinceReferenceDate
            print("DEBUG: Data do primeiro treino definida: \(dataNormalizada)")
        }

        if let sessaoConcluida = sessoesDeTreinoSalvas.first(where: { $0.id == idSessaoConcluida }) {
            let infoConclusao = TreinoConcluidoInfo(
                idSessao: idSessaoConcluida,
                nomeSessao: sessaoConcluida.nomeSessao,
                dataConclusao: dataNormalizada
            )
            self.historicoTreinosConcluidos.removeAll { registroExistente in
                calendario.isDate(registroExistente.dataConclusao, inSameDayAs: dataNormalizada)
            }
            self.historicoTreinosConcluidos.append(infoConclusao)
            self.historicoTreinosConcluidos.sort { $0.dataConclusao > $1.dataConclusao }
            
            persistirHistoricoTreinosConcluidos()
            
            print("DEBUG ViewModel: Sessão '\(sessaoConcluida.nomeSessao)' (ID: \(idSessaoConcluida)) adicionada/atualizada no histórico detalhado para \(dataNormalizada). Total no histórico agora: \(historicoTreinosConcluidos.count)")
        } else {
            print("DEBUG ViewModel: AVISO - Não foi possível encontrar a sessão com ID \(idSessaoConcluida) em sessoesDeTreinoSalvas para adicionar ao histórico detalhado.")
        }
        print("DEBUG ViewModel: Sessão individual com ID '\(idSessaoConcluida)' registrada (lógica de ciclo) para data \(dataNormalizada).")
        verificarSeCicloCompleto(dataConclusaoCiclo: dataConclusao)
    }
    // MARK: - Função para TelaPerfil (Dados da Semana Atual FIXA D-S-T-Q-Q-S-S)
    func obterDadosSemanaAtualParaPerfil() -> [InfoDiaTreinoParaPerfil] {
        var dadosDaSemana: [InfoDiaTreinoParaPerfil] = []
        let calendario = Calendar.current
        let hoje = calendario.startOfDay(for: Date())

        let diaDaSemanaDeHoje = calendario.component(.weekday, from: hoje)
        
        print("DEBUG ViewModel: INÍCIO obterDadosSemanaAtualParaPerfil(). Histórico tem: \(historicoTreinosConcluidos.count) itens.")
        historicoTreinosConcluidos.forEach { print("  -> Histórico Item: Sessão \($0.nomeSessao) em \($0.dataConclusao.formatted(date: .numeric, time: .omitted))") }
        
        guard let domingoDaSemanaAtual = calendario.date(byAdding: .day, value: -(diaDaSemanaDeHoje - 1), to: hoje) else {
            print("DEBUG ViewModel: Não foi possível determinar o domingo da semana atual.")
            return []
        }
        print("DEBUG ViewModel (Semana Atual): Hoje é \(hoje.formatted(date: .long, time: .omitted)) (\(diaDaSemanaDeHoje))")
        print("DEBUG ViewModel (Semana Atual): Domingo calculado: \(domingoDaSemanaAtual.formatted(date: .long, time: .omitted))")

        let letrasFixasDaSemana = ["D", "S", "T", "Q", "Q", "S", "S"]

        for i in 0..<7 {
            guard let diaConsiderado = calendario.date(byAdding: .day, value: i, to: domingoDaSemanaAtual) else {
                continue
            }
            
            let letraDoDia = letrasFixasDaSemana[i]
            print("DEBUG ViewModel (Semana Atual): Loop i=\(i), Data: \(diaConsiderado.formatted(date: .numeric, time: .omitted)), Letra Atribuída: \(letraDoDia)")
            let treinoConcluidoNesteDia = historicoTreinosConcluidos.first { info in
                calendario.isDate(info.dataConclusao, inSameDayAs: diaConsiderado)
            }

            if let infoConcluida = treinoConcluidoNesteDia {
                print("DEBUG ViewModel (Semana Atual): TREINO ENCONTRADO para \(letraDoDia) (\(diaConsiderado.formatted(date: .numeric, time: .omitted))): \(infoConcluida.nomeSessao)")
                dadosDaSemana.append(InfoDiaTreinoParaPerfil(
                    letraDia: letraDoDia,
                    nomeTreinoConcluido: infoConcluida.nomeSessao,
                    idSessaoConcluida: infoConcluida.idSessao,
                    dataRealDoDia: diaConsiderado,
                    foiConcluido: true
                ))
            } else {
                print("DEBUG ViewModel (Semana Atual): NENHUM treino para \(letraDoDia) (\(diaConsiderado.formatted(date: .numeric, time: .omitted)))")
                dadosDaSemana.append(InfoDiaTreinoParaPerfil(
                    letraDia: letraDoDia,
                    nomeTreinoConcluido: nil,
                    idSessaoConcluida: nil,
                    dataRealDoDia: diaConsiderado,
                    foiConcluido: false

                ))
            }
        }
        print("DEBUG ViewModel (Semana Atual): DadosDaSemana final antes de retornar (total: \(dadosDaSemana.count) itens):")
            for item in dadosDaSemana {
                print("  -> Letra: \(item.letraDia), Data: \(item.dataRealDoDia.formatted(date: .numeric, time: .omitted)), Nome: \(item.nomeTreinoConcluido ?? "N/A"), Concluído: \(item.foiConcluido), ID: \(String(describing: item.idSessaoConcluida))")
            }
            return dadosDaSemana
    }
    
    func atualizarSessoesParaExibir() {
            let sessoesPersonalizadas = sessoesDeTreinoSalvas.filter { $0.isModeloIntocado == false }
            if !sessoesPersonalizadas.isEmpty {
                sessoesParaExibir = sessoesPersonalizadas
                if !usuarioJaTeveSessoesPersonalizadas {
                    usuarioJaTeveSessoesPersonalizadas = true
                }
            } else {
                if usuarioJaTeveSessoesPersonalizadas {
                    sessoesParaExibir = []
                } else {
                    sessoesParaExibir = sessoesDeTreinoSalvas.filter {
                        $0.isModeloIntocado == true &&
                        (treinosPredefinidos[objetivoUsuarioSalvo]?.keys.contains($0.nomeSessao) ?? false)
                    }
                }
            }
        }
    func configurarTreinosIniciaisParaUsuario(objetivoDoUsuario: String) {
        guard !objetivoDoUsuario.isEmpty else {
            return
        }
        self.objetivoUsuarioSalvo = objetivoDoUsuario
        criarTreinosIniciaisSeNecessario()
        atualizarSessoesParaExibir()
    }
    private func criarTreinosIniciaisSeNecessario() {
        guard !treinosIniciaisCriados else {
            return
        }
        guard !objetivoUsuarioSalvo.isEmpty, let treinosParaObjetivo = treinosPredefinidos[objetivoUsuarioSalvo] else {
            return
        }
        var sessoesModeloParaAdicionar: [SessaoDeTreino] = []
        let dataCriacaoModelos = Date()
        for (nomeSessaoModelo, nomesExerciciosNoModelo) in treinosParaObjetivo {
            var exerciciosDaSessaoModelo: [ExercicioNaSessao] = []
            for nomeExercicioString in nomesExerciciosNoModelo {
                var exercicioLocalFinal: ExercicioLocal
                
                if let exercicioDetalhadoEncontrado = dadosExerciciosLocais.first(where: { $0.nome.trimmingCharacters(in: .whitespacesAndNewlines).compare(nomeExercicioString.trimmingCharacters(in: .whitespacesAndNewlines), options: .caseInsensitive) == .orderedSame }) {
                    exercicioLocalFinal = exercicioDetalhadoEncontrado
                } else {
                    exercicioLocalFinal = ExercicioLocal( nome: nomeExercicioString, grupoMuscular: "A definir", musculoPrincipal: "A definir", musculosSecundarios: nil, equipamento: nil, instrucoes: ["Consulte um profissional para instruções detalhadas."], observacoes: nil, gifUrlLocal: nil )
                }
                var seriesParaExercicio: [SerieDetalhe] = []
                if objetivoUsuarioSalvo == "Emagrecimento" && (nomeSessaoModelo == "Aeróbico Geral & Pernas Leve" || nomeSessaoModelo == "Circuito HIIT Corporal") {
                    if nomeExercicioString.lowercased().contains("corrida") || nomeExercicioString.lowercased().contains("bicicleta") {
                        seriesParaExercicio.append(SerieDetalhe(numeroSerie: 1, reps: "20-30 min", descanso: "N/A"))
                    } else {
                        seriesParaExercicio.append(SerieDetalhe(numeroSerie: 1, reps: "3-4 rounds", peso: "Máx. Reps", descanso: "60s entre rounds"))
                    }
                } else {
                    seriesParaExercicio.append(SerieDetalhe(numeroSerie: 1, reps: "8-12", peso: "", descanso: "60s"))
                    seriesParaExercicio.append(SerieDetalhe(numeroSerie: 2, reps: "8-12", peso: "", descanso: "60s"))
                    seriesParaExercicio.append(SerieDetalhe(numeroSerie: 3, reps: "8-12", peso: "", descanso: "60s"))
                }
                let exercicioNaSessao = ExercicioNaSessao(exercicioBase: exercicioLocalFinal, series: seriesParaExercicio.isEmpty ? [SerieDetalhe()] : seriesParaExercicio)
                exerciciosDaSessaoModelo.append(exercicioNaSessao)
            }
            let sessaoModelo = SessaoDeTreino( id: UUID(), nomeSessao: nomeSessaoModelo, exercicios: exerciciosDaSessaoModelo, dataCriacao: dataCriacaoModelos, isModeloIntocado: true )
            sessoesModeloParaAdicionar.append(sessaoModelo)
        }

        if !sessoesModeloParaAdicionar.isEmpty {
            let espacoDisponivel = limiteMaximoSessoes - sessoesDeTreinoSalvas.count
            if sessoesModeloParaAdicionar.count <= espacoDisponivel {
                sessoesDeTreinoSalvas.append(contentsOf: sessoesModeloParaAdicionar)
                persistirSessoes(sessoesParaSalvar: sessoesDeTreinoSalvas)
                self.treinosIniciaisCriados = true
                atualizarSessoesParaExibir()
            }
        }
    }
    func salvarOuAtualizarSessao(idSessao: UUID? = nil, nome: String, exercicios: [ExercicioNaSessao], originadoPeloBotaoMais: Bool = false) -> Bool {
            guard !nome.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return false }
            guard !exercicios.isEmpty else { return false }
            var sessaoModificadaComSucesso = false
            let dataAtual = Date()
            var idAlvoParaOperacao = idSessao
            if idSessao == nil && originadoPeloBotaoMais {
                if let indiceModeloASubstituir = sessoesDeTreinoSalvas.firstIndex(where: { $0.isModeloIntocado == true }) {
                    idAlvoParaOperacao = sessoesDeTreinoSalvas[indiceModeloASubstituir].id
                }
            }
            if let idExistente = idAlvoParaOperacao, let indexNaLista = sessoesDeTreinoSalvas.firstIndex(where: { $0.id == idExistente }) {
                sessoesDeTreinoSalvas[indexNaLista].nomeSessao = nome
                sessoesDeTreinoSalvas[indexNaLista].exercicios = exercicios
                if sessoesDeTreinoSalvas[indexNaLista].isModeloIntocado == true {
                    sessoesDeTreinoSalvas[indexNaLista].dataCriacao = dataAtual
                }
                sessoesDeTreinoSalvas[indexNaLista].isModeloIntocado = false
                sessaoModificadaComSucesso = true
            } else if idAlvoParaOperacao == nil && podeCriarNovaSessao {
                let novaSessao = SessaoDeTreino( id: UUID(), nomeSessao: nome, exercicios: exercicios, dataCriacao: dataAtual, isModeloIntocado: false )
                sessoesDeTreinoSalvas.append(novaSessao)
                sessaoModificadaComSucesso = true
            } else { return false }
            if sessaoModificadaComSucesso {
                persistirSessoes(sessoesParaSalvar: sessoesDeTreinoSalvas)
                if idSessao == nil && idAlvoParaOperacao == nil {
                    self.sessoesConcluidasNesteCicloSet = []
                    persistirSessoesConcluidasCiclo(setParaSalvar: [])
                }
                atualizarSessoesParaExibir()
            }
            return sessaoModificadaComSucesso
        }
    private func persistirSessoes(sessoesParaSalvar: [SessaoDeTreino]) {
        DispatchQueue.global(qos: .background).async {
            do { let encoded = try JSONEncoder().encode(sessoesParaSalvar); UserDefaults.standard.set(encoded, forKey: "sessoesSalvas") } catch { print("DEBUG: ERRO ao persistir sessões: \(error)") }
        }
    }
    private func persistirSessoesConcluidasCiclo(setParaSalvar: Set<UUID>) {
        DispatchQueue.global(qos: .background).async {
            do { let encoded = try JSONEncoder().encode(setParaSalvar); UserDefaults.standard.set(encoded, forKey: "sessoesConcluidasCicloAtualIDs_Data") } catch { print("DEBUG: ERRO ao persistir sessoesConcluidasCiclo: \(error)") }
        }
    }
    private func persistirDatasCiclosCompletos(datasParaSalvar: Set<Date>) {
        DispatchQueue.global(qos: .background).async {
            do { let encoded = try JSONEncoder().encode(datasParaSalvar); UserDefaults.standard.set(encoded, forKey: "datasCiclosDeTreinoCompletos_Data") } catch { print("DEBUG: ERRO ao persistir datasCiclosCompletos: \(error)") }
        }
    }
    func excluirSessao(at offsets: IndexSet) {
            sessoesDeTreinoSalvas.remove(atOffsets: offsets)
            self.sessoesConcluidasNesteCicloSet = []
            persistirSessoes(sessoesParaSalvar: Array(self.sessoesDeTreinoSalvas))
            persistirSessoesConcluidasCiclo(setParaSalvar: [])
            atualizarSessoesParaExibir()
            atualizarContagemStreak()
        }
    private func verificarSeCicloCompleto(dataConclusaoCiclo: Date) {
        guard !sessoesDeTreinoSalvas.isEmpty else { return }
        let todosIDsDasSessoesSalvas = Set(sessoesDeTreinoSalvas.map { $0.id })
        if sessoesConcluidasNesteCicloSet.isSuperset(of: todosIDsDasSessoesSalvas) {
            let dataNormalizada = Calendar.current.startOfDay(for: dataConclusaoCiclo)
            if !self.datasCiclosDeTreinoCompletosSet.contains(dataNormalizada) {
                self.datasCiclosDeTreinoCompletosSet.insert(dataNormalizada)
                persistirDatasCiclosCompletos(datasParaSalvar: self.datasCiclosDeTreinoCompletosSet)
            }
            self.sessoesConcluidasNesteCicloSet = []
            persistirSessoesConcluidasCiclo(setParaSalvar: [])
            atualizarContagemStreak()
        }
    }
    private func carregarSessoesSalvas() {
         if let data = UserDefaults.standard.data(forKey: "sessoesSalvas"), let decoded = try? JSONDecoder().decode([SessaoDeTreino].self, from: data) { sessoesDeTreinoSalvas = decoded }
    }
    private func carregarSessoesConcluidasCiclo() {
        if let data = UserDefaults.standard.data(forKey: "sessoesConcluidasCicloAtualIDs_Data"), let decoded = try? JSONDecoder().decode(Set<UUID>.self, from: data) { sessoesConcluidasNesteCicloSet = decoded } else { sessoesConcluidasNesteCicloSet = [] }
    }
    private func carregarDatasCiclosCompletos() {
        if let data = UserDefaults.standard.data(forKey: "datasCiclosDeTreinoCompletos_Data"), let decoded = try? JSONDecoder().decode(Set<Date>.self, from: data) { datasCiclosDeTreinoCompletosSet = decoded } else { datasCiclosDeTreinoCompletosSet = [] }
        atualizarContagemStreak()
    }
    func calcularSequenciaAtual() -> Int {
        guard !datasCiclosDeTreinoCompletosSet.isEmpty else { return 0 }
        let calendario = Calendar.current
        var diaVerificando = calendario.startOfDay(for: Date())
        var sequencia = 0
        let datasOrdenadas = datasCiclosDeTreinoCompletosSet.sorted(by: >)
        for dataCiclo in datasOrdenadas {
            let dataCicloNormalizada = calendario.startOfDay(for: dataCiclo)
            if calendario.isDate(dataCicloNormalizada, inSameDayAs: diaVerificando) {
                sequencia += 1
                guard let diaAnterior = calendario.date(byAdding: .day, value: -1, to: diaVerificando) else { break }
                diaVerificando = calendario.startOfDay(for: diaAnterior)
            } else if dataCicloNormalizada < diaVerificando { break }
        }
        return sequencia
    }
    func atualizarContagemStreak() {
        self.contagemStreakAtual = calcularSequenciaAtual()
    }
}
