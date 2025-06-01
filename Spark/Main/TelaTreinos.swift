import SwiftUI
struct TelaTreinos: View {
    @State private var streakPresented = false
    @EnvironmentObject var gerenciadorSessoes: GerenciadorSessoesViewModel
    struct TreinoDisplayItem: Identifiable {
        let id: UUID
        let nome: String
        let viewDestinationFactory: () -> AnyView
    }
    @State private var treinosParaExibir: [TreinoDisplayItem] = []
    var treinoConcluidoHoje: Bool {
        if let ultimaSessaoTS = gerenciadorSessoes.dataUltimaSessaoIndividualConcluidaTS {
            return Calendar.current.isDateInToday(Date(timeIntervalSinceReferenceDate: ultimaSessaoTS))
        }
        return false
    }
    var podeTreinarProximaSessaoDoCiclo: Bool {
        return !treinoConcluidoHoje
    }
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        
                        Text("Treino de hoje")
                            .font(.title).bold().foregroundColor(.white)
                        Spacer()
                        Button { streakPresented = true } label: {
                            Image(systemName: "flame")
                                .foregroundColor(Color("CorBotao")).font(.title2)
                        }
                    }
                    .padding(.horizontal).padding(.top, 30)
                    ScrollView() {
                        treinoAtualSectionView()
                            .padding(.horizontal)
                            .padding(.bottom, 15)
                        
                        Spacer()
                    }
                }
            }
                .sheet(isPresented: $streakPresented) {
                    StreakModel()
                        .environmentObject(gerenciadorSessoes)
                        .interactiveDismissDisabled(true)
                }
                .navigationBarHidden(true)
                .onAppear { carregarTreinosParaExibicao() }
            }
        
    }
    @ViewBuilder
    private func treinoAtualSectionView() -> some View {
        if let treinoAtual = treinosParaExibir.first {
            if podeTreinarProximaSessaoDoCiclo {
                NavigationLink(destination: treinoAtual.viewDestinationFactory()) {
                            CardTreino(titulo: treinoAtual.nome)
                        }
                        .buttonStyle(PlainButtonStyle())
            }
        } else {
            VStack(spacing: 8) {
                Text("Sessão de hoje já concluída!")
                    .font(.headline).foregroundColor(Color("CorBotao"))
                Text("Volte amanhã para continuar sua sequência!")
                    .font(.subheadline).foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding().frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.15)).cornerRadius(12)
        }
    }
    
    func carregarTreinosParaExibicao() {
        treinosParaExibir = []
        let todasAsSessoes = gerenciadorSessoes.sessoesDeTreinoSalvas
        let concluidasNesteCiclo = gerenciadorSessoes.sessoesConcluidasNesteCicloSet
        
        guard !todasAsSessoes.isEmpty else {
            print("TelaTreinos: Nenhuma sessão de treino salva no gerenciador para exibir.")
            self.treinosParaExibir = []
            return
        }
        var proximasSessoes: [SessaoDeTreino] = []
        var jaFeitasNesteCiclo: [SessaoDeTreino] = []
        for sessao in todasAsSessoes {
            if concluidasNesteCiclo.contains(sessao.id) {
                jaFeitasNesteCiclo.append(sessao)
            } else {
                proximasSessoes.append(sessao)
            }
        }
        let sessoesOrdenadasParaDisplay = proximasSessoes + jaFeitasNesteCiclo
        treinosParaExibir = sessoesOrdenadasParaDisplay.map { sessao in
            let acaoConcluirParaEstaSessao: () -> Void = {
                if !self.treinoConcluidoHoje {
                    gerenciadorSessoes.registrarSessaoIndividualConcluida(
                        idSessaoConcluida: sessao.id,
                        dataConclusao: Date()
                    )
                } else {
                    print("TelaTreinos: Tentativa de concluir sessão via callback, mas já treinou hoje.")
                }
            }
            return TreinoDisplayItem(
                id: sessao.id,
                nome: sessao.nomeSessao,
                viewDestinationFactory: { AnyView(ExecucaoSessaoView(sessao: sessao, concluirAcao: acaoConcluirParaEstaSessao)) }
            )
        }
        print("TelaTreinos: Treinos para exibir atualizados: \(treinosParaExibir.map { $0.nome })")
    }
}
#Preview {
    TelaTreinos()
        .environmentObject(GerenciadorSessoesViewModel())
        .preferredColorScheme(.dark)
}
