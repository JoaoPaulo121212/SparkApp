import SwiftUI

struct TreinosTemplatesView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            Text("Templates de Treino (A Implementar)")
                .foregroundColor(.white)
                .navigationTitle("Templates")
        }
    }
}
#Preview {
    TreinosTemplatesView()
}
