import SwiftUI

struct TempoCadastro: View {
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
                                        : Color(red: 41/255, green: 38/255, blue: 35/255)
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
                                ? Color(red: 41/255, green: 38/255, blue: 35/255)
                                : Color(red: 233/255, green: 9/255, blue: 22/255)
                            )
                            .cornerRadius(12)
                    }
                    .disabled(tempoSelecionado.isEmpty)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    NavigationLink(destination: CadastroObjetivo(), isActive: $deveNavegar) {
                        EmptyView()
                }
            }
            .padding(.top)
        }
        .navigationBarBackButtonHidden(true)
    }
}
#Preview {
    TempoCadastro()
}
