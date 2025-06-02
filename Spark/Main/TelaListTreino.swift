import SwiftUI

struct TelaListTreino: View {
    @State var addModelPresented = false
    @EnvironmentObject private var gerenciadorSessoes: GerenciadorSessoesViewModel //
    
    let corDeFundoPrincipal = Color("BackgroundColor")
    let corTextoPrincipal = Color.white

    var body: some View {
        NavigationStack {
            ZStack {
                corDeFundoPrincipal.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Seu plano de treino")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(corTextoPrincipal)
                        Spacer()
                        
                        Button(action: {
                            addModelPresented = true
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color("CorBotao"))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, UIApplication.shared.connectedScenes
                        .compactMap { $0 as? UIWindowScene }
                        .first?.windows.first?.safeAreaInsets.top ?? 0 > 20 ? 15 : 30)
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            if gerenciadorSessoes.sessoesDeTreinoSalvas.isEmpty { //
                                Text("Nenhum treino personalizado salvo.\nCrie um novo treino no botão '+' acima.")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding(.vertical, 50)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            } else {
                                ForEach(gerenciadorSessoes.sessoesDeTreinoSalvas) { sessao in
                                    NavigationLink(destination:

                                        AddModel(idSessaoEditando: sessao.id)
                                            .environmentObject(gerenciadorSessoes)
                                    ) {
                                        
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(sessao.nomeSessao)
                                                .font(.headline)
                                                .foregroundColor(.white)

                                            if !sessao.exercicios.isEmpty {
                                                ForEach(sessao.exercicios.prefix(3), id: \.id) { exercicioNaSessao in
                                                    Text("• \(exercicioNaSessao.exercicioBase.nome)")
                                                        .font(.caption)
                                                        .foregroundColor(.white.opacity(0.8))
                                                }
                                                if sessao.exercicios.count > 3 {
                                                    Text("- e mais \(sessao.exercicios.count - 3)...")
                                                        .font(.caption)
                                                        .italic()
                                                        .foregroundColor(.gray)
                                                }
                                            } else {
                                                Text("Nenhum exercício adicionado.")
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .sheet(isPresented: $addModelPresented) {
                AddModel()
                    .environmentObject(gerenciadorSessoes)
                    .interactiveDismissDisabled(true)
            }
        }
    }
}

#Preview {
    TelaListTreino()
        .preferredColorScheme(.dark)
        .environmentObject(GerenciadorSessoesViewModel()) 
}
