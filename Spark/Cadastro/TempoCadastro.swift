import SwiftUI

struct TempoCadastro: View {
    @EnvironmentObject var gerenciadorSessoes: GerenciadorSessoesViewModel
    @State private var tempoSelecionado: String = ""
    @State private var deveNavegar = false
    let opcoesTempo = ["Nunca treinei", "1 - 3 mês", "3 - 6 meses", "6m - 1 ano", "1 - 2 anos", "2+ anos"]
    var body: some View {
       
            ZStack {
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    ProgressBarCadastro(currentTela: 1)
                        .padding()
                    Spacer()
                        
                }
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    VStack(spacing: 10) {
                        Text("Qual é sua experiência com academia?")
                            .font(.system(size: 27))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 15) {
                        ForEach(opcoesTempo, id: \.self) { opcao in
                            Button(action: {
                                tempoSelecionado = opcao
                            }) {
                                Text(opcao)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        tempoSelecionado == opcao
                                        ? Color("CorBotao")
                                        : Color("ColorCard")
                                    )
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(action: {
                        if !tempoSelecionado.isEmpty {
                            print("Selecionado: \(tempoSelecionado)")
                            deveNavegar = true
                        }
                    }) {
                        Text("Continuar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                tempoSelecionado.isEmpty
                                ? Color("ColorCard")
                                : Color("CorOk")
                            )
                            .cornerRadius(12)
                    }
                    .disabled(tempoSelecionado.isEmpty)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .navigationDestination(isPresented: $deveNavegar) {
                                    CadastroObjetivo()
                            .environmentObject(gerenciadorSessoes)
                                }
            }
            .padding(.top)
        }
        .navigationBarBackButtonHidden(true)
    }
}
#Preview {
    TempoCadastro()
        .environmentObject(GerenciadorSessoesViewModel())
        .preferredColorScheme(.dark)
}
