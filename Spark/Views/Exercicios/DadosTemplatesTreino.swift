//import Foundation
//
//func encontrarExercicioLocal(nome: String) -> ExercicioLocal? {
//    return dadosExerciciosLocais.first(where: { $0.nome.lowercased() == nome.lowercased() })
//}
//func parseSeries(fromString repString: String, pesoPadrao: String, descansoPadrao: String) -> [SerieDetalhe] {
//    var seriesDetalhadas: [SerieDetalhe] = []
//
//    let components = repString.lowercased().components(separatedBy: "x")
//    
//    guard components.count == 2, let numeroDeSeries = Int(components[0]) else {
//        print("⚠️ Aviso: Formato de reps não reconhecido para parse de múltiplas séries: '\(repString)'. Criando como 1 série.")
//        seriesDetalhadas.append(SerieDetalhe(numeroSerie: 1, reps: repString, peso: pesoPadrao, descanso: descansoPadrao))
//        return seriesDetalhadas
//    }
//    let repsParaCadaSerie = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
//    
//    for i in 1...numeroDeSeries {
//        seriesDetalhadas.append(SerieDetalhe(numeroSerie: i, reps: repsParaCadaSerie, peso: pesoPadrao, descanso: descansoPadrao))
//    }
//    
//    return seriesDetalhadas
//}
//
//let dadosTemplates: [TemplatePlanoDeTreino] = [
//    TemplatePlanoDeTreino(
//        nomeTemplate: "Emagrecimento Semanal (ABC)",
//        objetivoAssociado: "Emagrecimento",
//        descricao: "Treino dividido em três sessões (A, B, C) com foco em alta queima calórica, utilizando exercícios compostos e alguns isoladores para manutenção da massa magra. Repita o ciclo ABC conforme sua agenda, idealmente com dias de descanso ou cardio leve entre eles.",
//        sessoesDoTemplate: [
//            SessaoDeTreino(id: UUID(), nomeSessao: "Treino A – Peito, Ombros e Tríceps (Emagrecimento)", exercicios: [
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Supino Reto com Halteres")!, series: parseSeries(fromString: "3x10-15", pesoPadrao: "--", descansoPadrao: "60s")),
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Crossover (Polia Alta)")!, series: parseSeries(fromString: "3x12-15", pesoPadrao: "--", descansoPadrao: "45s")),
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Desenvolvimento com Halteres")!, series: parseSeries(fromString: "3x10-12", pesoPadrao: "--", descansoPadrao: "60s")),
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Elevação Lateral com Halteres")!, series: parseSeries(fromString: "3x15", pesoPadrao: "--", descansoPadrao: "45s")),
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Tríceps Pulley com Corda")!, series: parseSeries(fromString: "3x12-15", pesoPadrao: "--", descansoPadrao: "45s")), // Ajustado reps
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Flexão de Braço Clássica")!, series: parseSeries(fromString: "3xAMRAP", pesoPadrao: "Corpo", descansoPadrao: "60s")) // Usando Flexão Clássica
//            ].compactMap { $0 }, // Remove nil se encontrarExercicioLocal retornar nil (embora aqui 
//            dataCriacao: Date()
//            ),
//            SessaoDeTreino(id: UUID(), nomeSessao: "Treino B – Pernas e Glúteos (Emagrecimento)", exercicios: [
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Agachamento Livre com Barra")!, series: parseSeries(fromString: "4x10-15", pesoPadrao: "--", descansoPadrao: "75s")), // Ajustado reps
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Leg Press 45°")!, series: parseSeries(fromString: "3x12-15", pesoPadrao: "--", descansoPadrao: "60s")), // Ajustado reps
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Cadeira Extensora")!, series: parseSeries(fromString: "3x15-20", pesoPadrao: "--", descansoPadrao: "45s")), // Ajustado reps
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Mesa Flexora")!, series: parseSeries(fromString: "3x15-20", pesoPadrao: "--", descansoPadrao: "45s")), // Ajustado reps
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Elevação Pélvica (Hip Thrust) com Barra")!, series: parseSeries(fromString: "3x15", pesoPadrao: "--", descansoPadrao: "60s"))
//            ].compactMap { $0 },
//            dataCriacao: Date()
//            ),
//            SessaoDeTreino(id: UUID(), nomeSessao: "Treino C – Costas, Bíceps e Abdômen (Emagrecimento)", exercicios: [
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Puxada Alta Frontal (Pulley)")!, series: parseSeries(fromString: "3x10-12", pesoPadrao: "--", descansoPadrao: "60s")),
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Remada Baixa (Remada Sentada na Polia)")!, series: parseSeries(fromString: "3x10-12", pesoPadrao: "--", descansoPadrao: "60s")),
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Pulldown com Braços Retos (Polia Alta)")!, series: parseSeries(fromString: "3x15", pesoPadrao: "--", descansoPadrao: "45s")),
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Rosca Direta com Barra")!, series: parseSeries(fromString: "3x10-12", pesoPadrao: "--", descansoPadrao: "45s")),
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Rosca Alternada com Halteres")!, series: parseSeries(fromString: "3x12", pesoPadrao: "--", descansoPadrao: "45s")) // Adicionado
//                // Abdômen pode ser um exercício como "Prancha Frontal" ou adicionado manualmente
//            ].compactMap { $0 },
//            dataCriacao: Date()
//            )
//        ]
//    ),
//
//    TemplatePlanoDeTreino(
//        nomeTemplate: "Hipertrofia Clássica (ABC)",
//        objetivoAssociado: "Ganho de massa muscular",
//        descricao: "Treinamento clássico de hipertrofia com divisão ABC (Peito/Ombro/Tríceps, Pernas, Costas/Bíceps) e foco em exercícios compostos e isoladores para máximo estímulo muscular.",
//        sessoesDoTemplate: [
//            SessaoDeTreino(id: UUID(), nomeSessao: "Treino A – Peito, Ombros e Tríceps (Hipertrofia)", exercicios: [
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Supino Reto com Barra")!, series: parseSeries(fromString: "4x6-10", pesoPadrao: "--", descansoPadrao: "75-90s")), // Ajustado
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Supino Inclinado com Halteres")!, series: parseSeries(fromString: "3x8-12", pesoPadrao: "--", descansoPadrao: "75s")), // Ajustado
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Crucifixo Reto com Halteres")!, series: parseSeries(fromString: "3x10-12", pesoPadrao: "--", descansoPadrao: "60s")), // Ajustado
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Desenvolvimento Militar com Barra (em pé)")!, series: parseSeries(fromString: "4x6-10", pesoPadrao: "--", descansoPadrao: "75s")), // Ajustado
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Elevação Lateral com Halteres")!, series: parseSeries(fromString: "3x12-15", pesoPadrao: "--", descansoPadrao: "45s")), // Ajustado
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Tríceps Testa com Barra W")!, series: parseSeries(fromString: "3x8-12", pesoPadrao: "--", descansoPadrao: "60s")), // Ajustado
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Tríceps Pulley com Corda")!, series: parseSeries(fromString: "3x10-15", pesoPadrao: "--", descansoPadrao: "60s")) // Ajustado
//            ].compactMap { $0 },
//            dataCriacao: Date()
//            ),
//            SessaoDeTreino(id: UUID(), nomeSessao: "Treino B – Pernas Completas (Hipertrofia)", exercicios: [
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Agachamento Livre com Barra")!, series: parseSeries(fromString: "4x6-10", pesoPadrao: "--", descansoPadrao: "90s")),
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Leg Press 45°")!, series: parseSeries(fromString: "3x10-12", pesoPadrao: "--", descansoPadrao: "75s")),
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Cadeira Extensora")!, series: parseSeries(fromString: "3x12-15", pesoPadrao: "--", descansoPadrao: "60s")),
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Mesa Flexora")!, series: parseSeries(fromString: "3x10-15", pesoPadrao: "--", descansoPadrao: "60s")), // Ajustado
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Panturrilha em Pé (Smith ou Máquina de Panturrilha)")!, series: parseSeries(fromString: "4x15-20", pesoPadrao: "--", descansoPadrao: "45s")),
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Panturrilha Sentado (Máquina de Panturrilha Sentada)")!, series: parseSeries(fromString: "4x15-20", pesoPadrao: "--", descansoPadrao: "45s"))
//            ].compactMap { $0 },
//            dataCriacao: Date()
//            ),
//            SessaoDeTreino(id: UUID(), nomeSessao: "Treino C – Costas e Bíceps (Hipertrofia)", exercicios: [
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Barra Fixa (Pegada Pronada)")!, series: parseSeries(fromString: "4xAMRAP", pesoPadrao: "Corpo", descansoPadrao: "90s")), // AMRAP = As Many Reps As Possible
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Remada Curvada com Barra")!, series: parseSeries(fromString: "4x8-10", pesoPadrao: "--", descansoPadrao: "75s")),
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Puxada Alta Frontal (Pulley)")!, series: parseSeries(fromString: "3x10-12", pesoPadrao: "--", descansoPadrao: "75s")), // Ajustado
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Remada Serrote com Halter (Unilateral)")!, series: parseSeries(fromString: "3x10", pesoPadrao: "--", descansoPadrao: "60s")), // Por lado
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Rosca Direta com Barra")!, series: parseSeries(fromString: "3x8-12", pesoPadrao: "--", descansoPadrao: "60s")), // Ajustado
//                ExercicioNaSessao(exercicioBase: encontrarExercicioLocal(nome: "Rosca Alternada com Halteres")!, series: parseSeries(fromString: "3x10-12", pesoPadrao: "--", descansoPadrao: "60s")) // Por lado, ajustado
//            ].compactMap { $0 },
//            dataCriacao: Date()
//            )
//        ]
//    )
//    // Adicione mais TemplatePlanoDeTreino aqui conforme necessário para outros objetivos ou variações
//    // como o "Push/Legs/Pull" ou "Superior/Inferior" que você tinha antes,
//    // adaptando os exercícios e a função parseSeries.
//    // Certifique-se que os nomes dos exercícios em encontrarExercicioLocal()
//    // correspondem EXATAMENTE aos nomes em DadosExerciciosLocais.swift (ignorando maiúsculas/minúsculas).
//]
//
//// Nota: As structs SessaoDeTreino, ExercicioNaSessao, SerieDetalhe e ExercicioLocal
//// devem estar definidas em outros lugares do seu projeto.
//// Certifique-se que SessaoDeTreino e ExercicioNaSessao tenham inicializadores que permitam
//// criar instâncias como feito acima (passando id, nome, exercicios, data, etc.).
//// E que SerieDetalhe tenha um inicializador para numeroSerie, reps, peso, descanso.
//// ExercicioLocal é buscado pela função encontrarExercicioLocal.
