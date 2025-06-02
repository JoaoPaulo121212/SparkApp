import SwiftUI

struct ProgressBarCadastro: View {
    var currentTela : Int
    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...3, id: \.self) { tela in
                Rectangle()
                    .fill(tela <= currentTela
                    ? Color(red: 233/255, green: 9/255, blue: 22/255)
                    : Color("ColorCard"))
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
