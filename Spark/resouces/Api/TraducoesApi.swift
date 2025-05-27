import Foundation

let traducoesBodyPart: [String: String] = [
        "back": "Costas",
        "cardio": "Cardiovascular",
        "chest": "Peito",
        "lower arms": "Antebraços",
        "lower legs": "Panturrilhas",
        "neck": "Pescoço",
        "shoulders": "Ombros",
        "upper arms": "Braços",
        "upper legs": "Pernas",
        "waist": "Abdômen"
]
let traducoesEquipment: [String: String] = [
        "assisted": "Com Assistência",
        "band": "Faixa Elástica",
        "barbell": "Barra",
        "body weight": "Peso Corporal",
        "bosu ball": "Bosu",
        "cable": "Polia",
        "dumbbell": "Halter",
        "elliptical machine": "Elíptico",
        "ez barbell": "Barra W",
        "hammer": "Pegada Neutra",
        "kettlebell": "Kettlebell",
        "leverage machine": "Máquina Articulada",
        "medicine ball": "Bola Medicinal",
        "olympic barbell": "Barra Olímpica",
        "resistance band": "Faixa de Resistência",
        "roller": "Rolo",
        "rope": "Corda",
        "skierg machine": "Máquina de Ski",
        "sled machine": "Trenó (Sled)",
        "smith machine": "Máquina Smith",
        "stability ball": "Bola de Estabilidade",
        "stationary bike": "Bicicleta Ergométrica",
        "stepmill machine": "Simulador de Escada",
        "tire": "Pneu",
        "trap bar": "Barra Hexagonal",
        "weighted": "Com Peso Adicional",
        "wheel roller": "Roda Abdominal"
]
let traducoesMuscle: [String: String] = [
    "abductors": "Abdutores",
        "abs": "Abdômen",
        "adductors": "Adutores",
        "biceps": "Bíceps",
        "calves": "Panturrilhas",
        "cardiovascular system": "Sistema Cardiovascular",
        "delts": "Deltóides",
        "forearms": "Antebraços",
        "glutes": "Glúteos",
        "hamstrings": "Isquiotibiais",
        "lats": "Dorsais",
        "levator scapulae": "Escápulas",
        "pectorals": "Peitorais",
        "quads": "Quadríceps",
        "serratus anterior": "Serrátil Anterior",
        "spine": "Coluna",
        "traps": "Trapézio",
        "triceps": "Tríceps",
        "upper back": "Costas Superiores"
]
func traduzir(_ termo: String?, usando dicionario: [String: String]) -> String? {
    guard let termo = termo?.lowercased(), !termo.isEmpty else { return nil }
    return dicionario[termo] ?? termo.capitalized
}
