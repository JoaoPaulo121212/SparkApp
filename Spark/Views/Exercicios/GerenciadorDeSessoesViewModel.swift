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
        print("DEBUG: GerenciadorSessoesViewModel inicializado. Sessões salvas: \(sessoesDeTreinoSalvas.count). Treinos iniciais já criados: \(treinosIniciaisCriados). Objetivo salvo: '\(objetivoUsuarioSalvo)'.")
        print("DEBUG: Sessões carregadas no init (verifique 'isModeloIntocado'):")
        sessoesDeTreinoSalvas.forEach { sessao in
            print("DEBUG: - Sessão: '\(sessao.nomeSessao)', ID: \(sessao.id), ModeloIntocado: \(String(describing: sessao.isModeloIntocado))")
        atualizarSessoesParaExibir()
                    print("DEBUG: GerenciadorSessoesViewModel inicializado. sessoesParaExibir calculada.")
        }
    }
    // MARK: - Lógica para Criação de Treinos Iniciais
    func atualizarSessoesParaExibir() {
            let sessoesPersonalizadas = sessoesDeTreinoSalvas.filter { $0.isModeloIntocado == false }
            if !sessoesPersonalizadas.isEmpty {
                sessoesParaExibir = sessoesPersonalizadas
                if !usuarioJaTeveSessoesPersonalizadas {
                    usuarioJaTeveSessoesPersonalizadas = true
                    print("DEBUG: Usuário agora tem sessões personalizadas. 'usuarioJaTeveSessoesPersonalizadas' = true")
                }
            } else {
                if usuarioJaTeveSessoesPersonalizadas {
                    sessoesParaExibir = []
                    print("DEBUG: Usuário já teve sessões personalizadas, mas deletou todas. Exibindo lista vazia.")
                } else {
                    sessoesParaExibir = sessoesDeTreinoSalvas.filter {
                        $0.isModeloIntocado == true &&
                        (treinosPredefinidos[objetivoUsuarioSalvo]?.keys.contains($0.nomeSessao) ?? false)
                    }
                    print("DEBUG: Usuário ainda não tem sessões personalizadas. Exibindo \(sessoesParaExibir.count) modelos para o objetivo '\(objetivoUsuarioSalvo)'.")
                }
            }
            print("DEBUG: sessoesParaExibir atualizada. Contém \(sessoesParaExibir.count) sessoes.")
            sessoesParaExibir.forEach { sessao in
                 print("DEBUG: -> Para Exibir: '\(sessao.nomeSessao)', ID: \(sessao.id), ModeloIntocado: \(String(describing: sessao.isModeloIntocado))")
            }
        }
    func configurarTreinosIniciaisParaUsuario(objetivoDoUsuario: String) {
        guard !objetivoDoUsuario.isEmpty else {
            print("DEBUG: ERRO em configurarTreinosIniciais: objetivoDoUsuario está vazio.")
            return
        }
        self.objetivoUsuarioSalvo = objetivoDoUsuario
        print("DEBUG: Objetivo do usuário definido como: '\(objetivoDoUsuario)'. Iniciando criação de treinos iniciais (se necessário)...")
        criarTreinosIniciaisSeNecessario()
        atualizarSessoesParaExibir()
    }
    private func criarTreinosIniciaisSeNecessario() {
        guard !treinosIniciaisCriados else {
            print("DEBUG: Treinos iniciais já foram criados anteriormente. Nada a fazer.")
            return
        }
        guard !objetivoUsuarioSalvo.isEmpty, let treinosParaObjetivo = treinosPredefinidos[objetivoUsuarioSalvo] else {
            print("DEBUG: ERRO em criarTreinosIniciais: Objetivo do usuário ('\(objetivoUsuarioSalvo)') não definido ou não encontrado na lista de treinos pré-definidos.")
            return
        }
        print("DEBUG: Iniciando processo de criação de treinos modelo para o objetivo: \(objetivoUsuarioSalvo)")
        var sessoesModeloParaAdicionar: [SessaoDeTreino] = []
        let dataCriacaoModelos = Date()
        for (nomeSessaoModelo, nomesExerciciosNoModelo) in treinosParaObjetivo {
            var exerciciosDaSessaoModelo: [ExercicioNaSessao] = []
            for nomeExercicioString in nomesExerciciosNoModelo {
                var exercicioLocalFinal: ExercicioLocal
                if let exercicioDetalhadoEncontrado = dadosExerciciosLocais.first(where: { $0.nome.trimmingCharacters(in: .whitespacesAndNewlines).compare(nomeExercicioString.trimmingCharacters(in: .whitespacesAndNewlines), options: .caseInsensitive) == .orderedSame }) {
                    exercicioLocalFinal = exercicioDetalhadoEncontrado
                } else {
                    print("DEBUG: AVISO: Exercício '\(nomeExercicioString)' não encontrado em dadosExerciciosLocais. Usando placeholders.")
                    exercicioLocalFinal = ExercicioLocal(
                        nome: nomeExercicioString,
                        grupoMuscular: "A definir",
                        musculoPrincipal: "A definir",
                        musculosSecundarios: nil,
                        equipamento: nil,
                        instrucoes: ["Consulte um profissional para instruções detalhadas."],
                        observacoes: nil,
                        gifUrlLocal: nil
                    )
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
            let sessaoModelo = SessaoDeTreino(
                id: UUID(),
                nomeSessao: nomeSessaoModelo,
                exercicios: exerciciosDaSessaoModelo,
                dataCriacao: dataCriacaoModelos,
                isModeloIntocado: true
            )
            sessoesModeloParaAdicionar.append(sessaoModelo)
            print("DEBUG: Modelo de treino preparado: '\(sessaoModelo.nomeSessao)', isModeloIntocado: \(String(describing: sessaoModelo.isModeloIntocado))")
        }

        if !sessoesModeloParaAdicionar.isEmpty {
            let espacoDisponivel = limiteMaximoSessoes - sessoesDeTreinoSalvas.count
            if sessoesModeloParaAdicionar.count <= espacoDisponivel {
                sessoesDeTreinoSalvas.append(contentsOf: sessoesModeloParaAdicionar)
                persistirSessoes(sessoesParaSalvar: sessoesDeTreinoSalvas)
                self.treinosIniciaisCriados = true // Marca que os treinos iniciais foram criados
                print("DEBUG: SUCESSO: \(sessoesModeloParaAdicionar.count) treinos modelo iniciais foram CRIADOS e salvos.")
                print("DEBUG: --- Estado de sessoesDeTreinoSalvas após adicionar modelos (verifique 'isModeloIntocado'): ---")
                sessoesDeTreinoSalvas.forEach { sessao in
                    print("DEBUG: - Sessão: '\(sessao.nomeSessao)', ID: \(sessao.id), ModeloIntocado: \(String(describing: sessao.isModeloIntocado))")
                }
                atualizarSessoesParaExibir()
            } else {
                print("DEBUG: ERRO em criarTreinosIniciais: Espaço insuficiente (\(espacoDisponivel) disponíveis) para adicionar todos os \(sessoesModeloParaAdicionar.count) treinos modelo.")
            }
        } else {
            print("DEBUG: Nenhum treino modelo para adicionar para o objetivo '\(objetivoUsuarioSalvo)'. Verifique o dicionário treinosPredefinidos.")
        }
    }
    // MARK: - Salvar, Atualizar e Substituir Sessões
    func salvarOuAtualizarSessao(idSessao: UUID? = nil, nome: String, exercicios: [ExercicioNaSessao], originadoPeloBotaoMais: Bool = false) -> Bool {
            print("\nDEBUG: --- Iniciando salvarOuAtualizarSessao ---")
            print("DEBUG: Parâmetros: idSessao=\(String(describing: idSessao)), nome='\(nome)', originadoPeloBotaoMais=\(originadoPeloBotaoMais)")
            print("DEBUG: Modelos intocados disponíveis ANTES da lógica de substituição (total: \(sessoesDeTreinoSalvas.filter { $0.isModeloIntocado == true }.count)):")
            sessoesDeTreinoSalvas.filter { $0.isModeloIntocado == true }.forEach { print("DEBUG: - ANTES: '\($0.nomeSessao)' (ID: \($0.id), Intocado: \($0.isModeloIntocado ?? false))") }

            guard !nome.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                print("DEBUG: Salvar falhou: Nome da sessão vazio.")
                return false
            }
            guard !exercicios.isEmpty else {
                print("DEBUG: Salvar falhou: Sessão sem exercícios.")
                return false
            }

            var sessaoModificadaComSucesso = false
            let dataAtual = Date()
            var idAlvoParaOperacao = idSessao

            if idSessao == nil && originadoPeloBotaoMais {
                print("DEBUG: Tentando substituir modelo (idSessao é nil E originadoPeloBotaoMais é true).")
                if let indiceModeloASubstituir = sessoesDeTreinoSalvas.firstIndex(where: { $0.isModeloIntocado == true }) {
                    idAlvoParaOperacao = sessoesDeTreinoSalvas[indiceModeloASubstituir].id
                    print("DEBUG: --> SUBSTITUIÇÃO: Modelo intocado ENCONTRADO para substituir. ID do modelo alvo: \(idAlvoParaOperacao!)")
                } else {
                    print("DEBUG: --> SUBSTITUIÇÃO: Nenhum modelo intocado encontrado para substituir. Tentará criar uma nova sessão se houver espaço.")
                }
            }

            if let idExistente = idAlvoParaOperacao, let indexNaLista = sessoesDeTreinoSalvas.firstIndex(where: { $0.id == idExistente }) {
                print("DEBUG: ATUALIZANDO sessão existente/modelo com ID: \(idExistente). Novo nome: '\(nome)'")
                sessoesDeTreinoSalvas[indexNaLista].nomeSessao = nome
                sessoesDeTreinoSalvas[indexNaLista].exercicios = exercicios
                if sessoesDeTreinoSalvas[indexNaLista].isModeloIntocado == true {
                    sessoesDeTreinoSalvas[indexNaLista].dataCriacao = dataAtual
                    print("DEBUG: Era modelo intocado, dataCriacao atualizada para \(dataAtual).")
                }
                sessoesDeTreinoSalvas[indexNaLista].isModeloIntocado = false
                sessaoModificadaComSucesso = true
                print("DEBUG: Sessão ATUALIZADA: '\(sessoesDeTreinoSalvas[indexNaLista].nomeSessao)', isModeloIntocado agora é \(sessoesDeTreinoSalvas[indexNaLista].isModeloIntocado ?? false)")
            } else if idAlvoParaOperacao == nil && podeCriarNovaSessao {
                print("DEBUG: CRIANDO sessão totalmente nova com nome: '\(nome)'")
                let novaSessao = SessaoDeTreino(
                    id: UUID(), nomeSessao: nome, exercicios: exercicios,
                    dataCriacao: dataAtual, isModeloIntocado: false
                )
                sessoesDeTreinoSalvas.append(novaSessao)
                sessaoModificadaComSucesso = true
                print("DEBUG: Nova sessão CRIADA: '\(novaSessao.nomeSessao)'")
            } else {
                if idAlvoParaOperacao != nil {
                     print("DEBUG: ERRO em salvar/atualizar: ID alvo para operação definido (\(idAlvoParaOperacao!)) mas não encontrado na lista.")
                } else if !podeCriarNovaSessao {
                     print("DEBUG: ERRO em salvar/atualizar: Limite máximo de sessões (\(limiteMaximoSessoes)) atingido. Não é possível criar nova sessão.")
                }
                return false
            }

            if sessaoModificadaComSucesso {
                persistirSessoes(sessoesParaSalvar: sessoesDeTreinoSalvas)
                if idSessao == nil && idAlvoParaOperacao == nil {
                    let setVazio: Set<UUID> = []
                    self.sessoesConcluidasNesteCicloSet = setVazio
                    persistirSessoesConcluidasCiclo(setParaSalvar: setVazio)
                    print("DEBUG: Ciclo de treinos concluídos resetado (devido à adição de uma sessão verdadeiramente nova).")
                }
                atualizarSessoesParaExibir()
            }
            print("DEBUG: --- Estado de sessoesDeTreinoSalvas APÓS salvar/atualizar: ---")
            sessoesDeTreinoSalvas.forEach { sessao in
                print("DEBUG: Sessão: '\(sessao.nomeSessao)', ID: \(sessao.id), ModeloIntocado: \(String(describing: sessao.isModeloIntocado))")
            }
            print("DEBUG: --- Finalizando salvarOuAtualizarSessao ---\n")
            return sessaoModificadaComSucesso
        }
    private func persistirSessoes(sessoesParaSalvar: [SessaoDeTreino]) {
        DispatchQueue.global(qos: .background).async {
            do {
                let encoded = try JSONEncoder().encode(sessoesParaSalvar)
                UserDefaults.standard.set(encoded, forKey: "sessoesSalvas")
            } catch {
                print("DEBUG: ERRO ao persistir sessões: \(error)")
            }
        }
    }
    private func persistirSessoesConcluidasCiclo(setParaSalvar: Set<UUID>) {
        DispatchQueue.global(qos: .background).async {
            do {
                let encoded = try JSONEncoder().encode(setParaSalvar)
                UserDefaults.standard.set(encoded, forKey: "sessoesConcluidasCicloAtualIDs_Data")
            } catch {
                 print("DEBUG: ERRO ao persistir sessoesConcluidasCiclo: \(error)")
            }
        }
    }
    private func persistirDatasCiclosCompletos(datasParaSalvar: Set<Date>) {
        DispatchQueue.global(qos: .background).async {
            do {
                let encoded = try JSONEncoder().encode(datasParaSalvar)
                UserDefaults.standard.set(encoded, forKey: "datasCiclosDeTreinoCompletos_Data")
            } catch {
                print("DEBUG: ERRO ao persistir datasCiclosCompletos: \(error)")
            }
        }
    }
    func excluirSessao(at offsets: IndexSet) {
            sessoesDeTreinoSalvas.remove(atOffsets: offsets)
            print("DEBUG: Sessão excluída. Total agora: \(sessoesDeTreinoSalvas.count).")
            let setVazio: Set<UUID> = []
            self.sessoesConcluidasNesteCicloSet = setVazio
            persistirSessoes(sessoesParaSalvar: Array(self.sessoesDeTreinoSalvas))
            persistirSessoesConcluidasCiclo(setParaSalvar: setVazio)
            atualizarSessoesParaExibir()
            atualizarContagemStreak()
        }
    func registrarSessaoIndividualConcluida(idSessaoConcluida: UUID, dataConclusao: Date = Date()) {
        if let ultimaSessaoTS = dataUltimaSessaoIndividualConcluidaTS,
           Calendar.current.isDateInToday(Date(timeIntervalSinceReferenceDate: ultimaSessaoTS)) {
            print("DEBUG: Sessão individual já registrada hoje.")
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
            print("DEBUG: Data do primeiro treino definida: \(dataNormalizada)")
        }
        print("DEBUG: Sessão individual '\(idSessaoConcluida)' registrada para \(dataNormalizada).")
        verificarSeCicloCompleto(dataConclusaoCiclo: dataConclusao)
    }
    private func verificarSeCicloCompleto(dataConclusaoCiclo: Date) {
        guard !sessoesDeTreinoSalvas.isEmpty else {
            print("DEBUG: Nenhuma sessão salva para verificar ciclo completo.")
            return
        }
        let todosIDsDasSessoesSalvas = Set(sessoesDeTreinoSalvas.map { $0.id })
        if sessoesConcluidasNesteCicloSet.isSuperset(of: todosIDsDasSessoesSalvas) {
            print("DEBUG: CICLO COMPLETO! Todas as sessões (\(todosIDsDasSessoesSalvas.count)) foram concluídas.")
            let dataNormalizada = Calendar.current.startOfDay(for: dataConclusaoCiclo)
            var datasCompletasAtuais = self.datasCiclosDeTreinoCompletosSet
            if !datasCompletasAtuais.contains(dataNormalizada) {
                datasCompletasAtuais.insert(dataNormalizada)
                self.datasCiclosDeTreinoCompletosSet = datasCompletasAtuais
                persistirDatasCiclosCompletos(datasParaSalvar: datasCompletasAtuais)
                print("DEBUG: Data do ciclo completo (\(dataNormalizada)) adicionada.")
            }
            let setVazio: Set<UUID> = []
            self.sessoesConcluidasNesteCicloSet = setVazio
            persistirSessoesConcluidasCiclo(setParaSalvar: setVazio)
            atualizarContagemStreak()
            print("DEBUG: Ciclo resetado. Sessões concluídas zeradas.")
        } else {
            print("DEBUG: Ciclo ainda não completo. Sessões concluídas neste ciclo: \(sessoesConcluidasNesteCicloSet.count) de \(todosIDsDasSessoesSalvas.count) totais.")
        }
    }
    private func carregarSessoesSalvas() {
         if let data = UserDefaults.standard.data(forKey: "sessoesSalvas"),
            let decoded = try? JSONDecoder().decode([SessaoDeTreino].self, from: data) {
             sessoesDeTreinoSalvas = decoded
        } else {
            print("DEBUG: Nenhuma sessão salva encontrada ou falha ao decodificar.")
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
        
        for dataCiclo in datasOrdenadas {
            let dataCicloNormalizada = calendario.startOfDay(for: dataCiclo)
            if calendario.isDate(dataCicloNormalizada, inSameDayAs: diaVerificando) {
                sequencia += 1
                guard let diaAnterior = calendario.date(byAdding: .day, value: -1, to: diaVerificando) else { break }
                diaVerificando = calendario.startOfDay(for: diaAnterior)
            } else if dataCicloNormalizada < diaVerificando {
                break
            }
        }
        return sequencia
    }
    func atualizarContagemStreak() {
        self.contagemStreakAtual = calcularSequenciaAtual()
        print("DEBUG: Contagem de streak atualizada para: \(contagemStreakAtual)")
    }
}
