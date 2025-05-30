import Foundation

struct TemplatePlanoDeTreino: Identifiable {
    let id = UUID()
    let nomeTemplate: String
    let descricao: String?
    let sessoesDoTemplate: [SessaoDeTreino]
}
struct ExercicioLocal: Identifiable, Codable {
    var id = UUID()
    let nome: String
    let grupoMuscular: String
    let musculoPrincipal: String
    let musculosSecundarios: [String]?
    let equipamento: String?
    let instrucoes: [String]
    let observacoes: String?
    let gifUrlLocal: String?
}

struct SerieDetalhe: Identifiable, Codable {
    var id = UUID()
    var numeroSerie: Int = 1
    var reps: String = ""
    var peso: String = ""
    var descanso: String = "2min"
    var concluida: Bool = false
}

struct ExercicioNaSessao: Identifiable, Codable {
    var id = UUID()
    let exercicioBase: ExercicioLocal
    var series: [SerieDetalhe] = [SerieDetalhe(numeroSerie: 1)]
}

struct SessaoDeTreino: Identifiable, Codable {
    var id = UUID()
    var nomeSessao: String
    var exercicios: [ExercicioNaSessao]
    var dataCriacao: Date = Date()
}
