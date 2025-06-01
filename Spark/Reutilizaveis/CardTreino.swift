import SwiftUI
struct CardTreino: View {
    let titulo: String
    var body: some View {
        Text(titulo)
            .font(.title2).bold()
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.secondary.opacity(0.2))
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}
