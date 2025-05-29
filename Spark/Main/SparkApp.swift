import SwiftUI

@main
struct SparkApp: App {
    @AppStorage("cadastroConcluido") var cadastroConcluido = false
    @StateObject private var gerenciadorSessoes = GerenciadorSessoesViewModel()
    var body: some Scene {
        WindowGroup {
//            if cadastroConcluido {
//              TabViewTeste()
//            }else {
//                WelcomeView()
//            }
            WelcomeView()
                .environmentObject(gerenciadorSessoes)
        }
    }
}
#Preview {
    WelcomeView()
        .preferredColorScheme(.dark)
        .environmentObject(GerenciadorSessoesViewModel())
        .environmentObject(ExerciseViewModel())
}
