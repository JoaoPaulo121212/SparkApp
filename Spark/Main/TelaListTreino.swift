import SwiftUI

struct TelaListTreino: View {
    @State var addModelPresented = false // Para o botão '+'
    @EnvironmentObject private var gerenciadorSessoes: GerenciadorSessoesViewModel
    
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
                            if gerenciadorSessoes.sessoesDeTreinoSalvas.isEmpty {
                                Text("Nenhum treino personalizado salvo.\nCrie um novo treino no botão '+' acima.")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding(.vertical, 50)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            } else {
                                ForEach(gerenciadorSessoes.sessoesDeTreinoSalvas) { sessao in
                                    // Navega para AddModel para editar a sessão existente
                                    NavigationLink(destination:
                                        // Para onde você quer ir ao clicar? Execução ou Edição?
                                        // Exemplo para editar:
                                        AddModel(idSessaoEditando: sessao.id) // Passa o ID para AddModel carregar
                                            .environmentObject(gerenciadorSessoes)
                                        // Ou para a tela de execução:
                                        // ExecucaoSessaoView(sessao: sessao, ...)
                                    ) {
                                        // Seu CardTreinoEditavel ou similar
                                        Text("Treino Salvo: \(sessao.nomeSessao)") // Placeholder do card
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(Color.gray.opacity(0.2))
                                            .foregroundColor(.white)
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
                AddModel() // Chama AddModel sem parâmetros para criar nova sessão
                    .environmentObject(gerenciadorSessoes)
                    .interactiveDismissDisabled(true) // Como você tinha
            }
        }
    }
}

#Preview {
    TelaListTreino()
        .preferredColorScheme(.dark)
        .environmentObject(GerenciadorSessoesViewModel())
}
