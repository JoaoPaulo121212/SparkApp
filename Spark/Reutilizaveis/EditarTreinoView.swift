import SwiftUI

struct EditarTreinoView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            Text("Página de Edição do Treino")
                .foregroundColor(.white)
                .font(.title)
        }
        .navigationTitle("Editar Treino")
    }
}
