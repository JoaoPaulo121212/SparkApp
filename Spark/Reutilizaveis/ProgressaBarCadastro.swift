import SwiftUI

struct ProgressBarCadastro: View {
    var currentTela : Int
    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...3, id: \.self) { tela in
                Rectangle()
                    .fill(tela <= currentTela
                    ? Color(red: 233/255, green: 9/255, blue: 22/255)
                    : Color(red: 41/255, green: 38/255, blue: 35/255))
                    .frame(height: 6)
                    .cornerRadius(3)
            }
        }
        .padding(.horizontal)
    }
}
#Preview {
    ProgressBarCadastro(currentTela: 1)
}
