import Foundation

func encontrarExercicio(nome: String) -> ExercicioLocal? {
    return dadosExerciciosLocais.first(where: { $0.nome.lowercased() == nome.lowercased() })
}

let dadosTemplates: [TemplatePlanoDeTreino] = [
    TemplatePlanoDeTreino(
        nomeTemplate: "Push/Legs/Pull",
        descricao: "Um treino full-body focado em movimentos compostos básicos, ideal para quem está começando.",
        sessoesDoTemplate: [
            SessaoDeTreino(nomeSessao: "Treino A (Full Body)", exercicios: [
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Agachamento Livre com Barra") ?? dadosExerciciosLocais[0], series: [SerieDetalhe(numeroSerie: 1, reps: "3x8-12", peso: "--", descanso: "90s")]),
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Supino Reto com Barra") ?? dadosExerciciosLocais[1], series: [SerieDetalhe(numeroSerie: 1, reps: "3x8-12", peso: "--", descanso: "90s")]),
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Remada Curvada com Barra") ?? dadosExerciciosLocais[2], series: [SerieDetalhe(numeroSerie: 1, reps: "3x8-12", peso: "--", descanso: "90s")]),
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Desenvolvimento Militar com Barra (em pé)") ?? dadosExerciciosLocais[3], series: [SerieDetalhe(numeroSerie: 1, reps: "3x10-15", peso: "--", descanso: "60s")]),
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Prancha Frontal") ?? dadosExerciciosLocais[4], series: [SerieDetalhe(numeroSerie: 1, reps: "3x30-60s", peso: "Corpo", descanso: "60s")])
            ]),
            SessaoDeTreino(nomeSessao: "Treino B (Full Body)", exercicios: [ /* Similar ao Treino A */ ]),
            SessaoDeTreino(nomeSessao: "Treino C (Full Body)", exercicios: [ /* Similar ao Treino A */ ])
        ]
    ),
    TemplatePlanoDeTreino(
        nomeTemplate: "Hipertrofia - Divisão Superior/Inferior (4x Semana)",
        descricao: "Foco em ganho de massa muscular com divisão de treino para membros superiores e inferiores.",
        sessoesDoTemplate: [
            SessaoDeTreino(nomeSessao: "Superior A", exercicios: [
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Supino Reto com Halteres") ?? dadosExerciciosLocais[0], series: [SerieDetalhe(numeroSerie: 1, reps: "4x8-10", peso: "--", descanso: "75s")]),
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Remada Cavalinho (Barra T ou Adaptador)") ?? dadosExerciciosLocais[1], series: [SerieDetalhe(numeroSerie: 1, reps: "4x8-10", peso: "--", descanso: "75s")]),
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Desenvolvimento com Halteres (Sentado ou em Pé)") ?? dadosExerciciosLocais[2], series: [SerieDetalhe(numeroSerie: 1, reps: "3x10-12", peso: "--", descanso: "60s")]),
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Rosca Direta com Barra") ?? dadosExerciciosLocais[3], series: [SerieDetalhe(numeroSerie: 1, reps: "3x10-12", peso: "--", descanso: "60s")]),
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Tríceps Testa com Barra W (ou Reta)") ?? dadosExerciciosLocais[4], series: [SerieDetalhe(numeroSerie: 1, reps: "3x10-12", peso: "--", descanso: "60s")])
            ]),
            SessaoDeTreino(nomeSessao: "Inferior A", exercicios: [
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Agachamento Livre com Barra") ?? dadosExerciciosLocais[0], series: [SerieDetalhe(numeroSerie: 1, reps: "4x6-10", peso: "--", descanso: "90s")]),
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Leg Press 45°") ?? dadosExerciciosLocais[1], series: [SerieDetalhe(numeroSerie: 1, reps: "3x10-15", peso: "--", descanso: "75s")]),
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Mesa Flexora (Isquiotibiais Deitado)") ?? dadosExerciciosLocais[2], series: [SerieDetalhe(numeroSerie: 1, reps: "3x12-15", peso: "--", descanso: "60s")]),
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Panturrilha em Pé (Máquina ou Livre)") ?? dadosExerciciosLocais[3], series: [SerieDetalhe(numeroSerie: 1, reps: "4x15-20", peso: "--", descanso: "45s")])
            ]),
            SessaoDeTreino(nomeSessao: "Superior B", exercicios: [ /* Variação do Superior A */ ]),
            SessaoDeTreino(nomeSessao: "Inferior B", exercicios: [ /* Variação do Inferior A */ ])
        ]
    ),
    TemplatePlanoDeTreino(
        nomeTemplate: "Emagrecimento",
        descricao: "Um treino ",
        sessoesDoTemplate: [
            SessaoDeTreino(nomeSessao: "Treino A (Full Body)", exercicios: [
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Agachamento Livre com Barra") ?? dadosExerciciosLocais[0], series: [SerieDetalhe(numeroSerie: 1, reps: "3x8-12", peso: "--", descanso: "90s")]),
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Supino Reto com Barra") ?? dadosExerciciosLocais[1], series: [SerieDetalhe(numeroSerie: 1, reps: "3x8-12", peso: "--", descanso: "90s")]),
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Remada Curvada com Barra") ?? dadosExerciciosLocais[2], series: [SerieDetalhe(numeroSerie: 1, reps: "3x8-12", peso: "--", descanso: "90s")]),
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Desenvolvimento Militar com Barra (em pé)") ?? dadosExerciciosLocais[3], series: [SerieDetalhe(numeroSerie: 1, reps: "3x10-15", peso: "--", descanso: "60s")]),
                ExercicioNaSessao(exercicioBase: encontrarExercicio(nome: "Prancha Frontal") ?? dadosExerciciosLocais[4], series: [SerieDetalhe(numeroSerie: 1, reps: "3x30-60s", peso: "Corpo", descanso: "60s")])
            ]),
            SessaoDeTreino(nomeSessao: "Treino B (Full Body)", exercicios: [ /* Similar ao Treino A */ ]),
            SessaoDeTreino(nomeSessao: "Treino C (Full Body)", exercicios: [ /* Similar ao Treino A */ ])
        ]
    ),
]

// NOTA: A função 'encontrarExercicio' e o uso de 'dadosExerciciosLocais[0]' são placeholders.
// O senhor precisará de uma maneira robusta de popular os 'exercicioBase' nos seus templates,
// idealmente buscando de 'dadosExerciciosLocais' por um ID ou nome único e confiável.
// Para este exemplo, usei nomes e alguns índices como fallback.
