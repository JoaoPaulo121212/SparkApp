import SwiftUI

struct TabViewTeste: View {
    var body: some View {
        TabView {
            TelaListTreino()
                .tabItem {
                    Image(systemName: "book.pages")
                    Text("Seus planos")
                }
            TelaTreinos()
                .tabItem {
                    Image(systemName: "dumbbell")
                    Text("Treino")
                }
            TelaPerfil()
                .tabItem {
                    Image(systemName: "person")
                    Text("Perfil")
                }
        }
        .accentColor(Color(red: 233/255, green: 9/255, blue: 22/255))
        .navigationBarBackButtonHidden(true)
    }
}
#Preview {
    TabViewTeste()
        .preferredColorScheme(.dark)
        .environmentObject(GerenciadorSessoesViewModel())

}
