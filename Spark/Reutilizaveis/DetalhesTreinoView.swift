import SwiftUI

struct DetalhesTreinoView: View {
    var titulo: String
    var exercicios: [String]

    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 16) {
                Text(titulo)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                ForEach(exercicios, id: \.self) { exercicio in
                    Text("• \(exercicio)")
                        .foregroundColor(.white)
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

               Spacer()
            }
            .padding()
        }
        .navigationTitle("Detalhes")
        .navigationBarTitleDisplayMode(.inline)
    }
}
