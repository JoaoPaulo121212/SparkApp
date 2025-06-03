import SwiftUI

struct WelcomeView: View {
    @AppStorage("cadastroConcluido") var cadastroConcluido = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 17/255, green: 14/255, blue: 11/255)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Image("SparkLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    Text("Treine inteligente \nTreine com o Spark!")
                        .padding(.bottom)
                        .font(.title2)
//                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(width: 350, height: 100)
                    NavigationLink(destination: TempoCadastro()) {
                            Text("Começar")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 200, height: 50)
                                .background(Color("CorOk"))
                                .cornerRadius(12)
                    }
                }
                .padding()
            }
        }
    }
}
#Preview {
    WelcomeView()
        
}
