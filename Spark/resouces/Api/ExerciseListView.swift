import SwiftUI

struct ExerciseListView: View {
    @StateObject private var viewModel = ExerciseViewModel()
    @State private var searchText: String = ""
    var filteredExercises: [ExercicioDetalhado] {
        if searchText.isEmpty {
            return viewModel.exerciciosDetalhados
        } else {
            return viewModel.exerciciosDetalhados.filter { exercise in
                exercise.name.localizedCaseInsensitiveContains(searchText)

            }
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    TextField("Pesquisar...", text: $searchText)
                        .foregroundColor(Color.white.opacity(0.7))
                        .accentColor(Color.white.opacity(0.7))

                    Spacer()

                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.gray)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 15)
                
                if viewModel.isLoading && filteredExercises.isEmpty {
                    ProgressView("Carregando exercícios...")
                        .padding()
                        .frame(maxHeight: .infinity)
                } else if !filteredExercises.isEmpty {
                    List(filteredExercises) { exercise in
                        VStack(alignment: .leading) {
                            Text(exercise.name)
                                .font(.headline)
                                .foregroundColor(.white)
                            if let target = exercise.target {
                                Text("Alvo: \(target)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            if let equipment = exercise.equipment {
                                Text("Equipamento: \(equipment)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            if let gifUrlString = exercise.gifUrl, let url = URL(string: gifUrlString) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView().frame(width: 100, height: 100)
                                    case .success(let image):
                                        image.resizable().aspectRatio(contentMode: .fit).frame(maxWidth: 200, maxHeight: 150)
                                    case .failure:
                                        Image(systemName: "photo.on.rectangle.angled").frame(width: 100, height: 100).foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .padding(.top, 5)
                            }
                        }
                        .padding(.vertical, 4)
                                            }
                   
                } else if viewModel.alertMessage == nil {
                    if searchText.isEmpty {
                        Text("Nenhum exercício encontrado ou carregado ainda.")
                            .foregroundColor(.gray)
                            .padding()
                            .frame(maxHeight: .infinity)
                    } else {
                        Text("Nenhum exercício encontrado para \"\(searchText)\".")
                            .foregroundColor(.gray)
                            .padding()
                            .frame(maxHeight: .infinity)
                    }
                }
                
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("Exercícios")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                            searchText = ""
                            await viewModel.loadAllExerciseDetails(limit: 200)
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                            .foregroundColor(Color(red: 233/255, green: 9/255, blue: 22/255))
                    }
                    .disabled(viewModel.isLoading)
                }
            }
            .task {
                if viewModel.exerciciosDetalhados.isEmpty {
                    await viewModel.loadAllExerciseDetails(limit: 200)
                }
            }
            .alert("Erro", isPresented: Binding(
                get: { viewModel.alertMessage != nil },
                set: { if !$0 { viewModel.alertMessage = nil } }
            )) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.alertMessage ?? "Ocorreu um erro desconhecido.")
            }
        }
        .accentColor(Color(red: 233/255, green: 9/255, blue: 22/255))
    }
}

#Preview {
    ExerciseListView()
}
