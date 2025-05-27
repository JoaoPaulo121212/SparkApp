import SwiftUI

struct CardTreino: View {
    @State var title = ""
    
    var body: some View {
        VStack{
            Text(title).font(.title3).bold().foregroundColor(.white)
            Group{
                Text("• Costas; \n • Bíceps;");
            }.foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("ColorCard"))
                )
                .padding()
        }
    }
}

#Preview {
    CardTreino(title: "Treino C")
}
