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
        if gerenciadorSessoes.salvarOuAtualizarSessao(idSessao: idSessaoEditando, nome: nomeFinalParaSalvar, exercicios: exerciciosSessaoAtual)  {
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
    func excluirExercicioDaSessao(at offsets: IndexSet) { //Definição da função ausente
            exerciciosSessaoAtual.remove(atOffsets: offsets)
        }
    func excluirSerieDoExercicioPorSwipe(exercicioId: UUID, at offsets: IndexSet) {
        if let indexExercicio = self.exerciciosSessaoAtual.firstIndex(where: { $0.id == exercicioId }) {
            var exercicioModificado = self.exerciciosSessaoAtual[indexExercicio]
            exercicioModificado.series.remove(atOffsets: offsets)
            for i in 0..<exercicioModificado.series.count {
                exercicioModificado.series[i].numeroSerie = i + 1
            }
            self.exerciciosSessaoAtual[indexExercicio] = exercicioModificado
        }
    }
}
