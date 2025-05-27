import SwiftUI
struct DiaSequencia: Identifiable {
    let id = UUID()
    var letra: String
    var treinoInfo: String? = nil
    var estaDestacado: Bool = false
}

struct TelaPerfil: View {
    @State private var nomeUsuario: String = "Jota Pe"
    @State private var idade: Int = 19
    @State private var alturaCm: Int = 190
    @State private var pesoKg: Double = 88.8
    @State private var sequenciaDias: [DiaSequencia] = [
        DiaSequencia(letra: "Q"),
        DiaSequencia(letra: "Q"),
        DiaSequencia(letra: "S", treinoInfo: "Treino A", estaDestacado: true),
        DiaSequencia(letra: "S"),
        DiaSequencia(letra: "D")
    ]
    let corDeFundoPrincipal = Color("BackgroundColor")
    let corTextoSecundario = Color.gray
    let corDestaque = Color(red: 233/255, green: 9/255, blue: 22/255)
    let corCardResumo = Color("ColorCard")

    var body: some View {
        ZStack {
            corDeFundoPrincipal.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    HStack {
                        Spacer()
                        Button(action: {
                            print("Botão de Configurações pressionado!")
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    HStack(spacing: 20) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(corTextoSecundario)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(nomeUsuario)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Button(action: {
                                    print("Botão Editar pressionado!")
                                }) {
                                    Image(systemName: "pencil")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.white)
                                        .padding(.leading)
                                }
                            }
                            Text("\(idade) anos")
                                .font(.subheadline)
                                .foregroundColor(corTextoSecundario)
                            Text("\(String(format: "%.2f", Double(alturaCm)/100.0))m de altura")
                            Text("\(String(format: "%.1f", pesoKg))kgs")
                                .font(.subheadline)
                                .foregroundColor(corTextoSecundario)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Sua sequência está")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal)

                        HStack(spacing: 12) {
                            ForEach(sequenciaDias) { dia in
                                DiaView(dia: dia, corDestaque: corDestaque, corTextoPrincipal: .white)
                            }
                        }
                        .padding(.horizontal)
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Seu resumo")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal)

                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(corCardResumo)
                            Text("No data yet")
                                .font(.title3)
                                .foregroundColor(corTextoSecundario)
                                .padding(50)
                        }
                        .frame(height: 200)
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct DiaView: View {
    let dia: DiaSequencia
    let corDestaque: Color
    let corTextoPrincipal: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(dia.letra)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(dia.estaDestacado ? corDestaque : corTextoPrincipal)
            
            if let treinoInfo = dia.treinoInfo, dia.estaDestacado {
                Text(treinoInfo)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(corDestaque)
            }
        }
        .frame(width: 60, height: 80)
        .background(
            Capsule()
                // --- ALTERAÇÃO APLICADA AQUI ---
                .fill(dia.estaDestacado ? corDestaque.opacity(0.25) : Color("ColorCard"))
                // --- FIM DA ALTERAÇÃO ---
        )
    }
}

#Preview {
    TelaPerfil()
        .preferredColorScheme(.dark) // Adicionado para melhor visualização no tema escuro
}
