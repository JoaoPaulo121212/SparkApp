import SwiftUI

@MainActor
class ExerciseViewModel: ObservableObject {
    
    @Published var exerciciosExibidos: [ExercicioLocal] = []
    @Published var isLoading: Bool = false
    @Published var alertMessage: String? = nil 

    private let todosExercicios: [ExercicioLocal] = dadosExerciciosLocais

    func carregarExerciciosLocais(grupoMuscular: String? = nil) {
        isLoading = true
        alertMessage = nil
        
        print("ViewModel: Carregando exercícios locais para grupo: \(grupoMuscular ?? "Todos")")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let grupoMuscularEspecifico = grupoMuscular, !grupoMuscularEspecifico.isEmpty {
                self.exerciciosExibidos = self.todosExercicios.filter {
                    $0.grupoMuscular.localizedCaseInsensitiveContains(grupoMuscularEspecifico)
                }
            } else {
                self.exerciciosExibidos = self.todosExercicios
            }
            
            print("ViewModel: \(self.exerciciosExibidos.count) exercícios locais carregados para exibição.")
            
            if self.exerciciosExibidos.isEmpty && grupoMuscular != nil {
                self.alertMessage = "Nenhum exercício encontrado para o grupo muscular: \(grupoMuscular!)."
            } else if self.exerciciosExibidos.isEmpty {
                self.alertMessage = "Nenhum exercício local encontrado."
            }
            
            self.isLoading = false
        }
    }
}
