import SwiftUI

struct PosStreak: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Image(systemName: "flame.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color(red: 233/255, green: 9/255, blue: 22/255))

                Text("Streak de treinos!")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)

                Text("Você está mantendo uma sequência incrível de treinos. Mantenha o foco e continue evoluindo!")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)

                Button(action: {
                    dismiss()
                }) {
                    Text("Fechar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 233/255, green: 9/255, blue: 22/255))
                        .cornerRadius(15)
                }
                .padding(.horizontal, 40)
            }
            .padding()
            .background(Color("ColorCard"))
            .cornerRadius(25)
            .shadow(radius: 10)
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    PosStreak()
}
