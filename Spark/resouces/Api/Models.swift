import Foundation

struct ExercicioDetalhado: Codable, Identifiable {
    let id: String
    let name: String
    let target: String?
    let equipment: String?
    let bodyPart: String?
    let gifUrl: String?
    
    var targetTraduzido: String? {
        traduzir(target, usando: traducoesMuscle)
    }

    var equipmentTraduzido: String? {
        traduzir(equipment, usando: traducoesEquipment)
    }

    var bodyPartTraduzido: String? {
        traduzir(bodyPart, usando: traducoesBodyPart)
    }
}

struct ExerciseIDListResponse: Codable {
    let idsDosExercicios: [String]

    enum CodingKeys: String, CodingKey {
        case idsDosExercicios = "excercises_ids"
    }
}
