import SwiftUI

struct WelcomeView: View {
    @AppStorage("cadastroConcluido") var cadastroConcluido = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 17/255, green: 14/255, blue: 11/255)
                    .ignoresSafeArea()
                VStack {
                    Image("SparkLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    Text("Treine inteligente \nTreine com o Spark!")
                        .offset(y: -30)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(width: 350, height: 100)
                    NavigationLink(destination: TempoCadastro()) {
                            Text("Começar")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 200, height: 50)
                                .background(Color(red : 233/255, green: 9/255, blue: 22/255))
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
