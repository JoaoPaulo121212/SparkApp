import SwiftUI
// import PhotosUI // Não é mais necessário aqui se apenas TelaEditarPerfil usa

struct DiaSequencia: Identifiable {
    let id = UUID()
    var letra: String
    var treinoInfo: String? = nil
    var estaDestacado: Bool = false
}

struct TelaPerfil: View {
    // Recupera os dados do usuário armazenados usando @AppStorage
    @AppStorage("nomeUsuario") var nomeUsuario: String = ""
    @AppStorage("idadeUsuario") var idade: Int = 0
    @AppStorage("alturaUsuario") var alturaCm: Int = 0
    @AppStorage("pesoUsuario") var pesoKg: Double = 0.0
    @AppStorage("profileImageData") private var profileImageData: Data?

    
    
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
    
    // Removido @State para selectedItem e profileImage
    @State private var showingEditSheet = false
    
    var body: some View {
        ZStack {
            corDeFundoPrincipal.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    HStack {
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    HStack(spacing: 20) {
                        // Imagem de placeholder estática
                        if let data = profileImageData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(corTextoSecundario)
                                .background(Color.gray.opacity(0.3))
                                .clipShape(Circle())
                        }

                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(nomeUsuario)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Button(action: {
                                    print("Botão Editar pressionado!")
                                    showingEditSheet = true
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
                            Text("\(String(format: "%.2f", Double(alturaCm)/100.0)) m")
                                .font(.subheadline)
                                .foregroundColor(corTextoSecundario)
                            Text("\(String(format: "%.1f", pesoKg)) kgs")
                                .font(.subheadline)
                                .foregroundColor(corTextoSecundario)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    // ... (resto do VStack da TelaPerfil)
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
            .sheet(isPresented: $showingEditSheet) {
                TelaEditarPerfil( // Chamada SEM o parâmetro profileImage
                    nomeUsuario: $nomeUsuario,
                    idadeUsuario: $idade,
                    alturaUsuarioCm: $alturaCm,
                    pesoUsuarioKg: $pesoKg
                )
                .interactiveDismissDisabled(true)
            }
        }
    }
}

// DiaView e Preview permanecem os mesmos
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
                .fill(dia.estaDestacado ? corDestaque.opacity(0.25) : Color("ColorCard"))
        )
    }
}

#Preview {
    TelaPerfil()
        .preferredColorScheme(.dark)
}
