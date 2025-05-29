import SwiftUI

struct TelaTreinos: View {
    @State private var streakPresented = false

    struct Treino: Identifiable {
        let id = UUID()
        let nome: String
        let view: (Binding<() -> Void>) -> AnyView
    }

    @State private var treinos: [Treino] = []
    @State private var concluirTreinoCallback: () -> Void = {}

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .leading) {
                    Spacer()

                    HStack {
                        Text("Treino de hoje")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        Button {
                            streakPresented = true
                        } label: {
                            Image(systemName: "flame")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                        }
                    }
                    .padding(.horizontal)

                    if let treinoAtual = treinos.first {
                        NavigationLink(destination: treinoAtual.view($concluirTreinoCallback)) {
                            CardTreino(titulo: treinoAtual.nome)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                    }

                    Text("Próximos Treinos")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.bottom, 10)

                    ScrollView {
                        VStack(spacing: 25) {
                            ForEach(treinos.dropFirst()) { treino in
                                NavigationLink(destination: treino.view($concluirTreinoCallback)) {
                                    CardTreino(titulo: treino.nome)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }

                    Spacer()
                }
            }
            .sheet(isPresented: $streakPresented) {
                StreakModel()
            }
            .navigationBarHidden(true)
            .onAppear {
                if treinos.isEmpty {
                    carregarTreinos()
                }
                concluirTreinoCallback = {
                    concluirTreino()
                }
            }
        }
    }

    func concluirTreino() {
        guard !treinos.isEmpty else { return }
        let treinoConcluido = treinos.removeFirst()
        treinos.append(treinoConcluido)
    }

    func carregarTreinos() {
        treinos = [
            Treino(nome: "Treino A", view: { concluir in
                AnyView(TreinoAView(concluirTreino: concluir))
            }),
            Treino(nome: "Treino B", view: { concluir in
                AnyView(TreinoBView(concluirTreino: concluir))
            }),
            Treino(nome: "Treino C", view: { concluir in
                AnyView(TreinoCView(concluirTreino: concluir))
            }),
            Treino(nome: "Treino D", view: { concluir in
                AnyView(TreinoDView(concluirTreino: concluir))
            })
        ]
    }
}


#Preview {
    TelaTreinos()
        .preferredColorScheme(.dark)
}
