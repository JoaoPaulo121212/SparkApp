import SwiftUI

struct ExerciseListView: View {
    @StateObject private var viewModel = ExerciseViewModel()
    @State private var searchText: String = ""
    var grupoMuscularParaCarregar: String? = nil
    var aoSelecionarExercicio: ((ExercicioLocal) -> Void)? = nil
    @Environment(\.dismiss) var dismiss

    var filteredExercises: [ExercicioLocal] {
        if searchText.isEmpty {
            return viewModel.exerciciosExibidos
        } else {
            return viewModel.exerciciosExibidos.filter { exercise in
                exercise.nome.localizedCaseInsensitiveContains(searchText) ||
                exercise.musculoPrincipal.localizedCaseInsensitiveContains(searchText) ||
                (exercise.equipamento?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }

    @ViewBuilder
    private func searchBarView() -> some View {
        HStack {
            TextField("Pesquisar por nome, músculo, equipamento...", text: $searchText)
                .foregroundColor(Color.white.opacity(0.8))
                .accentColor(Color.white.opacity(0.8))
                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                .background(Color.gray.opacity(0.25))
                .cornerRadius(10)

            if !searchText.isEmpty {
                Button { searchText = "" } label: {
                    Image(systemName: "xmark.circle.fill").foregroundColor(.gray)
                }
                .padding(.trailing, 8)
            } else {
                Image(systemName: "magnifyingglass").foregroundColor(Color.gray).padding(.trailing, 8)
            }
        }
        .padding(.horizontal).padding(.top, 8).padding(.bottom, 15)
    }

    @ViewBuilder
    private func exerciseRowView(exercise: ExercicioLocal) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(exercise.nome)
                .font(.headline)
                .foregroundColor(.white)
            
            Group {
                Text("Grupo Muscular: \(exercise.grupoMuscular)")
                Text("Músculo Principal: \(exercise.musculoPrincipal)")
                if let equipamento = exercise.equipamento, !equipamento.isEmpty {
                    Text("Equipamento: \(equipamento)")
                }
            }
            .font(.subheadline)
            .foregroundColor(.gray)
        }
        .padding(.vertical, 10)
    }
    
    @ViewBuilder
    private func mainContentView() -> some View {
        if viewModel.isLoading && viewModel.exerciciosExibidos.isEmpty {
            ProgressView("Carregando Exercícios...")
                .frame(maxHeight: .infinity, alignment: .center)
        } else if !filteredExercises.isEmpty {
            List {
                ForEach(filteredExercises) { exercise in
                    exerciseRowView(exercise: exercise)
                        .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
        } else if viewModel.alertMessage == nil {
            Text(searchText.isEmpty ? "Nenhum exercício para exibir." : "Nenhum exercício encontrado para \"\(searchText)\".")
                .foregroundColor(.gray).padding().frame(maxHeight: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                searchBarView()
                mainContentView()
            }
            .background(Color("BackgroundColor").ignoresSafeArea())
            .navigationTitle("Exercícios")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        searchText = ""
                        viewModel.carregarExerciciosLocais(grupoMuscular: grupoMuscularParaCarregar)
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                            .foregroundColor(Color(red: 233/255, green: 9/255, blue: 22/255))
                    }
                    .disabled(viewModel.isLoading)
                }
            }
            .onAppear {
                if viewModel.exerciciosExibidos.isEmpty {
                    viewModel.carregarExerciciosLocais(grupoMuscular: grupoMuscularParaCarregar)
                }
            }
            .alert("Aviso", isPresented: Binding(
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
    ExerciseListView(grupoMuscularParaCarregar: nil)
        .preferredColorScheme(.dark)
}
