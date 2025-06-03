import SwiftUI

struct TreinoCView: View {
    var concluirAcao: () -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            VStack {
                Text("Exercícios do Treino C")
                    .font(.title).foregroundColor(.white).padding()
                Spacer()
                Button("Concluir Treino C") {
                    concluirAcao()
                    dismiss()
                }
                .font(.headline).padding().foregroundColor(.white)
                .frame(maxWidth: .infinity).background(Color("CorBotao")).cornerRadius(10).padding()
            }
        }
        .navigationTitle("Treino C")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: { Image(systemName: "chevron.left").foregroundColor(Color("CorBotao")) }
            }
        }
    }
}
