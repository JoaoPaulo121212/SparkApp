import SwiftUI

struct DetalhesTreinoView: View {
    var titulo: String
    var exercicios: [String]

    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(titulo)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
//                    NavigationLink(destination: AddModel()) {
//                        Image(systemName: "square.and.pencil")
//                            .resizable()
//                            .frame(width: 25, height: 25) 
//                            .foregroundColor(.white)
//                    }
                }

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
