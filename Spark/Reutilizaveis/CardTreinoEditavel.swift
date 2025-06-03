import SwiftUI

struct CardTreinoEditavel: View {
    var titulo: String
    var exercicios: [String]

    var body: some View {
        NavigationLink(destination: DetalhesTreinoView(titulo: titulo, exercicios: exercicios)) {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(titulo)
                        .font(.headline)
                        .foregroundColor(.white)

                    ForEach(exercicios, id: \.self) { exercicio in
                        Text("• \(exercicio)")
                            .foregroundColor(.white.opacity(0.85))
                            .font(.subheadline)
                        
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.1))
                .cornerRadius(12)
            }
        }
        .buttonStyle(PlainButtonStyle()) 
    }
}
