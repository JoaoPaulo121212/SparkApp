import SwiftUI
struct StreakModel: View {
    @Environment(\.dismiss) var dismiss
    @State private var tipoSequencia: String = "Semanal"
    let tiposDeStreak = ["Semanal", "Diário"]
    let diasDestacados: [Int] = [3, 4, 5]
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 15) {
                Spacer()
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                    Spacer()
                    Text("Sua sequência")
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal)
                Menu {
                    ForEach(tiposDeStreak, id: \.self) { tipo in
                        Button(action: {
                            tipoSequencia = tipo
                        }) {
                            Text(tipo)
                        }
                    }
                } label: {
                    HStack {
                        Text(tipoSequencia)
                            .font(.subheadline)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(.gray).opacity(0.5))
                            .cornerRadius(5)
                            .foregroundColor(.white)
                    }
                    .padding(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView {
                    VStack(spacing: 24) {
                        CalendarioView(nomeMes: "Maio", totalDias: 31, diasDestacados: diasDestacados)
                        CalendarioView(nomeMes: "Junho", totalDias: 30, diasDestacados: [])
                    }
                }
            .padding()
        }
    }
}
struct CalendarioView: View {
        let nomeMes: String
        let totalDias: Int
        let diasDestacados: [Int]
        let colunas = Array(repeating: GridItem(.flexible()), count: 7)
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(nomeMes)
                    .foregroundColor(.white)
                    .bold()
                    .font(.title3)
                    .padding(.horizontal)
                
                LazyVGrid(columns: colunas, spacing: 12) {
                    ForEach(1...totalDias, id: \.self) { dia in
                        Text("\(dia)")
                            .frame(width: 30, height: 30)
                            .background(diasDestacados.contains(dia) ? Color("CorBotao") : Color.clear)
                            .clipShape(Circle())
                            .foregroundColor(.white)
                            .font(.subheadline)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
#Preview {
    StreakModel()
}
