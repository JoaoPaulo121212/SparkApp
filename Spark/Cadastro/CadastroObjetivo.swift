import SwiftUI

struct CadastroObjetivo: View {
    @EnvironmentObject var gerenciadorSessoes: GerenciadorSessoesViewModel
    @Environment(\.dismiss) var dismiss
    @State private var objetivoSelecionado: String = ""
    @State private var deveNavegar = false
    @AppStorage("objetivoSelecionado") private var objetivoSalvo: String = ""

    let opcoesObjetivo = ["Emagrecimento","Ganho de massa muscular"]
    var body: some View {
            ZStack {
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color(red: 233/255, green: 9/255, blue: 22/255))
                                .font(.system(size: 23, weight: .bold))
                        }
                        ProgressBarCadastro(currentTela: 2)

                    }
                    .padding(.horizontal)

                    Text("Qual seu objetivo na academia?")
                        .font(.system(size: 27, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.leading, -80)
                        .padding(.trailing, 60)
                        .padding(.top, 30)
                    Spacer()
                    VStack(spacing: 16) {
                        ForEach(opcoesObjetivo, id: \.self) { opcao in
                            Button(action: {
                                objetivoSelecionado = opcao
                            }) {
                                HStack {
                                    Image(uiImage: UIImage(named: opcao == "Emagrecimento" ? "Emagrecimento" : "Ganho de massa") ?? UIImage())
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 35, height: 35)

                                    Text(opcao)
                                        .font(.body)
                                        .foregroundColor(.white)

                                    Spacer()
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    objetivoSelecionado == opcao
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
                        if !objetivoSelecionado.isEmpty {
                            objetivoSalvo = objetivoSelecionado
                            print("Selecionado: \(objetivoSelecionado)")
                            deveNavegar = true
                        }
                    }) {
                        Text("Continuar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                objetivoSelecionado.isEmpty
                                ? Color("ColorCard")
                                : Color("CorOk")
                            )
                            .cornerRadius(12)
                    }
                    .disabled(objetivoSelecionado.isEmpty)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .navigationDestination(isPresented: $deveNavegar) {
                                    CadastroInfos()
                            .environmentObject(gerenciadorSessoes)
                                }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }

#Preview {
    CadastroObjetivo()
        .environmentObject(GerenciadorSessoesViewModel())
        .preferredColorScheme(.dark)
}
