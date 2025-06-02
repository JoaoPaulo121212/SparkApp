import SwiftUI

struct TelaListTreino: View {
    @State var addModelPresented = false
    @EnvironmentObject private var gerenciadorSessoes: GerenciadorSessoesViewModel
    let corDeFundoPrincipal = Color("BackgroundColor")
    let corTextoPrincipal = Color.white
    private var headerView: some View {
        HStack {
            Text("Seu plano de treino")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(corTextoPrincipal)
            Spacer()

            Button(action: {
                addModelPresented = true
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundColor(Color("CorBotao"))
                    .padding(8)
            }
        }
        .padding(.horizontal)
        .padding(.top, UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first?.safeAreaInsets.top ?? 0 > 20 ? 15 : 30)
        .padding(.bottom, 10)
    }
    private var listaDeTreinosView: some View {
        ScrollView {
            VStack(spacing: 12) {
                if gerenciadorSessoes.sessoesParaExibir.isEmpty {
                    Text("Nenhum treino personalizado salvo.")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 50)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ForEach(gerenciadorSessoes.sessoesParaExibir) { sessao in
                        NavigationLink(destination:
                            AddModel(idSessaoEditando: sessao.id)
                                .environmentObject(gerenciadorSessoes)
                        ) {
                            CardTreinoEditavel(
                                titulo: sessao.nomeSessao,
                                exercicios: sessao.exercicios.map { $0.exercicioBase.nome }
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
    var body: some View {
        NavigationStack {
            ZStack {
                corDeFundoPrincipal.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 0) {
                    headerView
                    listaDeTreinosView
                }
            }
            .sheet(isPresented: $addModelPresented) {
                AddModel() 
                    .environmentObject(gerenciadorSessoes)
                    .interactiveDismissDisabled(true)
            }
            .onAppear {
                gerenciadorSessoes.atualizarSessoesParaExibir()
            }
        }
    }
}

#Preview {
    let viewModel = GerenciadorSessoesViewModel()
    if viewModel.objetivoUsuarioSalvo.isEmpty {
        viewModel.objetivoUsuarioSalvo = "Emagrecimento"
    }
    if !viewModel.treinosIniciaisCriados {
         viewModel.configurarTreinosIniciaisParaUsuario(objetivoDoUsuario: viewModel.objetivoUsuarioSalvo)
    } else {
        viewModel.atualizarSessoesParaExibir()
    }


    return TelaListTreino()
        .preferredColorScheme(.dark)
        .environmentObject(viewModel)
}
