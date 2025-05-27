import SwiftUI

@main
struct SparkApp: App {
    @AppStorage("cadastroConcluido") var cadastroConcluido = false
    var body: some Scene {
        WindowGroup {
//            if cadastroConcluido {
//              TabViewTeste()
//            }else {
//                WelcomeView()
//            }
            WelcomeView()
        }
    }
}
#Preview {
    WelcomeView()
}
