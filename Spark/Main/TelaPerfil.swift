import SwiftUI

struct DiaSequencia: Identifiable {
    let id = UUID()
    var letra: String
    var treinoInfo: String? = nil
    var estaDestacado: Bool = false
    var data: Date
    var idSessao: UUID?
}

struct TelaPerfil: View {
    @EnvironmentObject var gerenciadorSessoes: GerenciadorSessoesViewModel

    @AppStorage("nomeUsuario") var nomeUsuario: String = ""
    @AppStorage("idadeUsuario") var idade: Int = 0
    @AppStorage("alturaUsuario") var alturaCm: Int = 0
    @AppStorage("pesoUsuario") var pesoKg: Double = 0.0
    @AppStorage("profileImageData") private var profileImageData: Data?
    
    @State private var sequenciaDias: [DiaSequencia] = []
    
    let corDeFundoPrincipal = Color("BackgroundColor")
    let corTextoSecundario = Color.gray
    let corDestaque = Color(red: 233/255, green: 9/255, blue: 22/255)
    
    @State private var showingEditSheet = false
    
    @State private var showingDetalheTreinoSheet = false
    @State private var sessaoSelecionadaParaDetalhe: SessaoDeTreino? = nil

    var body: some View {
        ZStack {
            corDeFundoPrincipal.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    HStack(spacing: 20) {
                        if let data = profileImageData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable().aspectRatio(contentMode: .fill).frame(width: 80, height: 80).clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable().scaledToFit().frame(width: 80, height: 80).foregroundColor(corTextoSecundario).background(Color.gray.opacity(0.3)).clipShape(Circle())
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            HStack{
                                Text(nomeUsuario.isEmpty ? "Usuário" : nomeUsuario)
                                    .font(.largeTitle).fontWeight(.bold).foregroundColor(.white)
                                Button(action: { showingEditSheet = true }) {
                                    Image(systemName: "pencil").resizable().frame(width: 20, height: 20).foregroundColor(.white).padding(.leading)
                                }
                            }
                            Text(idade > 0 ? "\(idade) anos" : "Idade não informada").font(.subheadline).foregroundColor(corTextoSecundario)
                            Text(alturaCm > 0 ? "\(String(format: "%.2f", Double(alturaCm)/100.0)) m" : "Altura não informada").font(.subheadline).foregroundColor(corTextoSecundario)
                            Text(pesoKg > 0 ? "\(String(format: "%.1f", pesoKg)) kg" : "Peso não informado").font(.subheadline).foregroundColor(corTextoSecundario)
                        }
                        Spacer()
                    }
                    .padding(.horizontal).padding(.top)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Semana Atual").font(.title2).fontWeight(.semibold).foregroundColor(.white).padding(.horizontal)
                        
                        if sequenciaDias.isEmpty {
                            Text("Carregando dados da semana...").font(.caption).foregroundColor(corTextoSecundario).padding(.horizontal).padding(.top, 5)
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(sequenciaDias) { dia in
                                        DiaView(dia: dia, corDestaque: corDestaque, corTextoPrincipal: .white)
//                                            .onTapGesture {
//                                                if dia.estaDestacado, let idSessaoClicada = dia.idSessao {
//                                                    if let sessaoEncontrada = gerenciadorSessoes.sessoesDeTreinoSalvas.first(where: { $0.id == idSessaoClicada }) {
//                                                        self.sessaoSelecionadaParaDetalhe = sessaoEncontrada
//                                                        self.showingDetalheTreinoSheet = true
//                                                    } else {
//                                                        print("ERRO em TelaPerfil: Sessão com ID \(idSessaoClicada) não encontrada.")
//                                                    }
//                                                }
//                                            }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    Spacer()
                }
            }
            .sheet(isPresented: $showingEditSheet) {
                 TelaEditarPerfil(nomeUsuario: $nomeUsuario, idadeUsuario: $idade, alturaUsuarioCm: $alturaCm, pesoUsuarioKg: $pesoKg)
                .interactiveDismissDisabled(true)
            }
            .sheet(isPresented: $showingDetalheTreinoSheet) {
                if let sessao = sessaoSelecionadaParaDetalhe {
                    DetalheTreinoConcluidoView(sessao: sessao)
                        .environmentObject(gerenciadorSessoes)
                }
            }
            .onAppear {
                carregarDadosDaSequencia()
            }
        }
    }
    
    func carregarDadosDaSequencia() {
        let infosDaSemanaViewModel = gerenciadorSessoes.obterDadosSemanaAtualParaPerfil()
        
        self.sequenciaDias = infosDaSemanaViewModel.map { infoDiaVM -> DiaSequencia in
            return DiaSequencia(
                    letra: infoDiaVM.letraDia,
                    treinoInfo: infoDiaVM.nomeTreinoConcluido,
                    estaDestacado: infoDiaVM.foiConcluido,
                    data: infoDiaVM.dataRealDoDia,
                    idSessao: infoDiaVM.idSessaoConcluida
                )
        }
        print("TelaPerfil: sequenciaDias atualizada com \(self.sequenciaDias.count) dias da semana ATUAL.")
    }
}

struct DiaView: View {
    let dia: DiaSequencia
    let corDestaque: Color
    let corTextoPrincipal: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(dia.letra).font(.title3).fontWeight(.bold).foregroundColor(dia.estaDestacado ? corDestaque : corTextoPrincipal)
            if let treinoInfo = dia.treinoInfo, dia.estaDestacado {
                Text(treinoInfo).font(.caption).fontWeight(.medium).foregroundColor(corDestaque).lineLimit(1).truncationMode(.tail)
            } else if !dia.estaDestacado {
                Text(" ").font(.caption).padding(.vertical, 1)
            }
        }
        .frame(width: 60, height: 80)
        .background(Capsule().fill(dia.estaDestacado ? corDestaque.opacity(0.25) : Color("ColorCard")))
    }
}

#Preview {
    TelaPerfil()
        .environmentObject(GerenciadorSessoesViewModel())
        .preferredColorScheme(.dark)
}
