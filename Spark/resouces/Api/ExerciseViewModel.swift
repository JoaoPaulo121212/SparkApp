import SwiftUI

@MainActor
class ExerciseViewModel: ObservableObject {
    
    @Published var exerciciosDetalhados: [ExercicioDetalhado] = []
    @Published var isLoading: Bool = false
    @Published var alertMessage: String? = nil

    private let apiService = ExerciseAPIService()
    func loadAllExerciseDetails(limit: Int = 10) async {
        isLoading = true
        alertMessage = nil
        

        do {
            let exerciseIDs = try await apiService.fetchAllExerciseIDs()
            print("ViewModel: \(exerciseIDs.count) IDs de exercícios recebidos.")

            var newDetails: [ExercicioDetalhado] = []
            
            for id in exerciseIDs.prefix(limit) {
                print("ViewModel: Buscando detalhes para o ID: \(id)...")
                do {
                    let detail = try await apiService.fetchExerciseDetails(id: id)
                    newDetails.append(detail)
                } catch {
                    print("ViewModel: Falha ao buscar detalhes para o ID \(id): \(error.localizedDescription)")
      
                }
            }
            self.exerciciosDetalhados = newDetails
            
            if exerciciosDetalhados.isEmpty && !exerciseIDs.isEmpty && limit > 0 {
                alertMessage = "Não foi possível carregar os detalhes dos exercícios."
            } else if exerciciosDetalhados.isEmpty && exerciseIDs.isEmpty {
                 alertMessage = "Nenhum exercício encontrado na API."
            }

        } catch let error as APIError {
            print("Erro API (geral) no ViewModel: \(error.localizedDescription)")
            alertMessage = error.localizedDescription
        } catch {
            print("Erro inesperado no ViewModel: \(error.localizedDescription)")
            alertMessage = "Um erro inesperado ocorreu: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
