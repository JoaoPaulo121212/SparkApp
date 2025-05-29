import SwiftUI
import Combine

@MainActor
class GerenciadorSessoesViewModel: ObservableObject {
    @Published var sessoesDeTreinoSalvas: [SessaoDeTreino] = []
    let limiteMaximoSessoes = 6

    var podeCriarNovaSessao: Bool {
        sessoesDeTreinoSalvas.count < limiteMaximoSessoes
    }
    func salvarOuAtualizarSessao(idSessao: UUID? = nil, nome: String, exercicios: [ExercicioNaSessao]) -> Bool {
        guard !nome.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("⚠️ Nome da sessão não pode ser vazio.")
            return false
        }
        guard !exercicios.isEmpty else {
            print("⚠️ A sessão de treino precisa ter pelo menos um exercício.")
            return false
        }

        if let idExistente = idSessao, let index = sessoesDeTreinoSalvas.firstIndex(where: { $0.id == idExistente }) {
            
            sessoesDeTreinoSalvas[index].nomeSessao = nome
            sessoesDeTreinoSalvas[index].exercicios = exercicios
            sessoesDeTreinoSalvas[index].dataCriacao = Date()
            print("✅ Sessão '\(nome)' atualizada com sucesso!")
        } else if podeCriarNovaSessao {
            
            let novaSessao = SessaoDeTreino(nomeSessao: nome, exercicios: exercicios)
            sessoesDeTreinoSalvas.append(novaSessao)
            print("✅ Nova Sessão '\(nome)' salva com sucesso! Total: \(sessoesDeTreinoSalvas.count).")
        } else {
            print("⚠️ Limite de \(limiteMaximoSessoes) sessões atingido. Não foi possível salvar nova sessão.")
            return false
        }
        return true
    }

    func excluirSessao(at offsets: IndexSet) {
        sessoesDeTreinoSalvas.remove(atOffsets: offsets)
        print("🗑️ Sessão excluída. Total de sessões: \(sessoesDeTreinoSalvas.count).")

    }
    init() {
        print("GerenciadorSessoesViewModel inicializado. Sessões salvas: \(sessoesDeTreinoSalvas.count)")
    }
}
