import SwiftUI

extension AddModel {
    func prepararNovaSessao() {
        idSessaoEditando = nil
        nomeSessaoAtual = gerarNomeSessaoPlaceholderCalculado()
        exerciciosSessaoAtual = []
        modoCriacaoEdicaoAtivo = true
        nomeSessaoInteragido = false
    }
    func carregarSessaoParaEdicao(sessao: SessaoDeTreino) {
        idSessaoEditando = sessao.id
        nomeSessaoAtual = sessao.nomeSessao
        exerciciosSessaoAtual = sessao.exercicios
        modoCriacaoEdicaoAtivo = true
        nomeSessaoInteragido = true
    }
    func cancelarEdicaoOuCriacao() {
        modoCriacaoEdicaoAtivo = false
        if idSessaoEditando == nil {
            nomeSessaoAtual = ""
            exerciciosSessaoAtual = []
        }
        idSessaoEditando = nil
        nomeSessaoInteragido = false
    }
    func salvarSessaoAtual() {
        var nomeFinalParaSalvar = nomeSessaoAtual.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if idSessaoEditando == nil {
            if nomeFinalParaSalvar.isEmpty && !nomeSessaoInteragido {
                nomeFinalParaSalvar = gerarNomeSessaoPlaceholderCalculado()
            } else if nomeFinalParaSalvar.isEmpty && nomeSessaoInteragido {
                feedbackAlertTitle = "Nome Inválido"; feedbackAlertMessage = "Por favor, dê um nome para a sua sessão."; showFeedbackAlert = true; return
            } else if nomeFinalParaSalvar == gerarNomeSessaoPlaceholderCalculado() && !nomeSessaoInteragido {
            }
        } else {
             if nomeFinalParaSalvar.isEmpty {
                 feedbackAlertTitle = "Nome Inválido"; feedbackAlertMessage = "O nome da sessão não pode ficar vazio."; showFeedbackAlert = true; return
             }
        }
        if exerciciosSessaoAtual.isEmpty {
            feedbackAlertTitle = "Sessão Vazia"; feedbackAlertMessage = "Adicione pelo menos um exercício."; showFeedbackAlert = true; return
        }
        if gerenciadorSessoes.salvarOuAtualizarSessao(idSessao: idSessaoEditando, nome: nomeFinalParaSalvar, exercicios: exerciciosSessaoAtual) {
            feedbackAlertTitle = "Sucesso!"
            feedbackAlertMessage = "Sessão '\(nomeFinalParaSalvar)' foi salva."
            modoCriacaoEdicaoAtivo = false
            nomeSessaoAtual = ""
            exerciciosSessaoAtual = []
            idSessaoEditando = nil
            nomeSessaoInteragido = false

            dismiss()
        } else {
            feedbackAlertTitle = "Falha ao Salvar"
            if !gerenciadorSessoes.podeCriarNovaSessao && idSessaoEditando == nil {
                feedbackAlertMessage = "Limite de \(gerenciadorSessoes.limiteMaximoSessoes) sessões atingido."
            } else {
                feedbackAlertMessage = "Não foi possível salvar. Verifique os dados ou o nome da sessão."
            }
        }
        showFeedbackAlert = true
    }
    func adicionarExercicioASessao(exercicioLocal: ExercicioLocal) {
        let novoExercicioSessao = ExercicioNaSessao(exercicioBase: exercicioLocal, series: [SerieDetalhe(numeroSerie: 1)])
        self.exerciciosSessaoAtual.append(novoExercicioSessao)
    }
    func adicionarSerie(a idExercicioSessao: UUID) {
        if let index = exerciciosSessaoAtual.firstIndex(where: { $0.id == idExercicioSessao }) {
            let proximoNumeroSerie = (exerciciosSessaoAtual[index].series.last?.numeroSerie ?? 0) + 1
            exerciciosSessaoAtual[index].series.append(SerieDetalhe(numeroSerie: proximoNumeroSerie))
        }
    }
    func excluirSerieDoExercicioPorSwipe(exercicioId: UUID, at offsets: IndexSet) {
            // Encontra o índice do exercício no array @State exerciciosSessaoAtual
            if let indexExercicio = self.exerciciosSessaoAtual.firstIndex(where: { $0.id == exercicioId }) {
                
                // Cria uma cópia mutável do exercício para modificar suas séries
                var exercicioModificado = self.exerciciosSessaoAtual[indexExercicio]
                
                // Remove as séries pelos offsets fornecidos pelo swipe
                exercicioModificado.series.remove(atOffsets: offsets)
                
                // VERIFICA SE O EXERCÍCIO FICOU SEM SÉRIES
                if exercicioModificado.series.isEmpty {
                    // Se sim, remove o exercício inteiro da sessão atual
                    self.exerciciosSessaoAtual.remove(at: indexExercicio)
                    print("Exercício '\(exercicioModificado.exercicioBase.nome)' removido da sessão pois todas as suas séries foram excluídas por swipe.")
                    
                    // Opcional: Feedback ao usuário de que o exercício foi removido
                    self.feedbackAlertTitle = "Exercício Removido"
                    self.feedbackAlertMessage = "'\(exercicioModificado.exercicioBase.nome)' foi removido pois não possuía mais séries."
                    self.showFeedbackAlert = true
                    return // Sai da função pois o exercício foi removido
                }
                
                // Se ainda há séries, renumera as séries restantes para este exercício
                for i in 0..<exercicioModificado.series.count {
                    exercicioModificado.series[i].numeroSerie = i + 1
                }
                
                // Atualiza o exercício no array @State principal
                self.exerciciosSessaoAtual[indexExercicio] = exercicioModificado
                print("Série(s) removida(s) por swipe do exercício: \(exercicioModificado.exercicioBase.nome)")
            }
        }
    func excluirExercicioDaSessao(at offsets: IndexSet) {
            
            exerciciosSessaoAtual.remove(atOffsets: offsets)
            print("Exercício(s) na posição \(offsets) removido(s) da sessão atual.")
            
            // Se não houver mais exercícios, e estivermos criando uma nova sessão,
            // podemos querer resetar o nome da sessão para o placeholder, se o usuário ainda não o editou.
            if exerciciosSessaoAtual.isEmpty && idSessaoEditando == nil && !nomeSessaoInteragido {
                nomeSessaoAtual = gerarNomeSessaoPlaceholderCalculado()
                // (Assumindo que gerarNomeSessaoPlaceholderCalculado() está em AddModel+Helpers.swift)
            }
        }
}
