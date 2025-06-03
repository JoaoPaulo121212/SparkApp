import SwiftUI

struct TreinoAView: View {
    var concluirAcao: () -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all) //
            VStack {
                Text("Exercícios do Treino A")
                    .font(.title).foregroundColor(.white)
                    .padding()
                
                List {
                    Text("Supino reto Máquina").foregroundColor(.white)
                    Text("Supino inclinado máquina").foregroundColor(.white)
                    Text("Cruxifico máquina").foregroundColor(.white)
                }
                .listStyle(.plain)
                .background(Color("BackgroundColor"))
                .scrollContentBackground(.hidden)

                Spacer()

                Button("Concluir Treino A") {
                    concluirAcao()
                    dismiss()
                }
                .font(.headline).padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .background(Color("CorBotao"))
                .cornerRadius(10)
                .padding()
            }
        }
        .navigationTitle("Treino A")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left").foregroundColor(Color("CorBotao"))
                }
            }
        }
    }
}
