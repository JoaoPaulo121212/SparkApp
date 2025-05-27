import Foundation

struct ExercicioDetalhado: Codable, Identifiable {
    let id: String
    let name: String
    let target: String?
    let equipment: String?
    let bodyPart: String?
    let gifUrl: String?
}
struct ExerciseIDListResponse: Codable {
    let idsDosExercicios: [String]
    enum CodingKeys: String, CodingKey {
        case idsDosExercicios = "excercises_ids"
    }
}
