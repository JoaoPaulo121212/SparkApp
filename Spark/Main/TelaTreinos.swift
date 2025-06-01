import SwiftUI

struct TelaTreinos: View {
    @State private var streakPresented = false
    @EnvironmentObject var gerenciadorSessoes: GerenciadorSessoesViewModel
    struct TreinoDisplayItem: Identifiable {
        let id: UUID
        let nome: String
        let exercicios: [String]
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
                VStack(alignment: .leading, spacing: 20) { // Espaçamento entre título principal e ScrollView
                    HStack {
                        Text("Treino de hoje")
                            .font(.title).bold().foregroundColor(.white)
                        Spacer()
                        Button { streakPresented = true } label: {
                            Image(systemName: "flame")
                                .foregroundColor(Color("CorBotao")).font(.title2)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 25) { // Espaçamento entre as seções dentro da ScrollView
                            treinoAtualSectionView()
                                .padding(.horizontal)
                            
                            if treinosParaExibir.count > 1 {
                                Text("Próximos treinos") // Título da nova seção
                                    .font(.title2).bold().foregroundColor(.white)
                                    .padding(.horizontal)
                                
                                proximosTreinosSectionView()
                                     .padding(.horizontal)
                             }
                        }
                        .padding(.bottom, 20) // Padding ao final do conteúdo da ScrollView
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
            NavigationLink(destination: treinoAtual.viewDestinationFactory()) {
                VStack(alignment: .leading, spacing: 10) {
                    CardTreino(titulo: treinoAtual.nome)
                    if !treinoAtual.exercicios.isEmpty {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Exercícios:")
                                .font(.headline)
                                .foregroundColor(Color.white.opacity(0.9))
                                .padding(.top, 5)
                            ForEach(treinoAtual.exercicios, id: \.self) { nomeExercicio in
                                HStack {
                                    Image(systemName: "figure.walk")
                                        .foregroundColor(Color("CorBotao"))
                                        .font(.caption)
                                    Text(nomeExercicio)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(12)
            }
            .buttonStyle(PlainButtonStyle())
            if !podeTreinarProximaSessaoDoCiclo && gerenciadorSessoes.dataUltimaSessaoIndividualConcluidaTS != nil {
                 Text("Você já concluiu um treino hoje. Próxima conclusão disponível amanhã!")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
            }
        } else {
            VStack(spacing: 8) {
                Text("Nenhuma Sessão de Treino")
                    .font(.title2).bold().foregroundColor(.white)
                    .padding(.bottom, 5)
                Text("Crie suas sessões de treino para começar a acompanhar seu progresso.")
                    .font(.subheadline).foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding().frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.15)).cornerRadius(12)
        }
    }
    @ViewBuilder
    private func proximosTreinosSectionView() -> some View {
        let proximos = Array(treinosParaExibir.dropFirst())

        ForEach(proximos) { treinoItem in
            NavigationLink(destination: treinoItem.viewDestinationFactory()) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(treinoItem.nome)
                        .font(.title3).bold()
                        .foregroundColor(.white)
                    
                    if !treinoItem.exercicios.isEmpty {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Exercícios:")
                                .font(.callout).bold()
                                .foregroundColor(Color.white.opacity(0.8))
                                .padding(.top, 3)
                            ForEach(treinoItem.exercicios, id: \.self) { nomeExercicio in
                                HStack {
                                    Image(systemName: "list.bullet")
                                        .foregroundColor(Color.gray.opacity(0.8))
                                        .font(.caption)
                                    Text(nomeExercicio)
                                        .font(.caption)
                                        .foregroundColor(Color.gray)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.10))
                .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    func carregarTreinosParaExibicao() {
        let todasAsSessoes = gerenciadorSessoes.sessoesDeTreinoSalvas
        let concluidasNesteCiclo = gerenciadorSessoes.sessoesConcluidasNesteCicloSet
        
        guard !todasAsSessoes.isEmpty else {
            self.treinosParaExibir = []
            return
        }
        var proximasSessoesDoCiclo: [SessaoDeTreino] = []
        var jaFeitasNesteCiclo: [SessaoDeTreino] = []
        
        for sessao in todasAsSessoes {
            if concluidasNesteCiclo.contains(sessao.id) {
                jaFeitasNesteCiclo.append(sessao)
            } else {
                proximasSessoesDoCiclo.append(sessao)
            }
        }
        let sessoesOrdenadasParaDisplay = proximasSessoesDoCiclo + jaFeitasNesteCiclo
        let podeConcluirQualquerSessaoHoje = self.podeTreinarProximaSessaoDoCiclo
        self.treinosParaExibir = sessoesOrdenadasParaDisplay.map { sessaoMapeada in
            let nomesDosExercicios = sessaoMapeada.exercicios.map { $0.exercicioBase.nome }
            let acaoConcluirParaEstaSessao: () -> Void = {
                if self.podeTreinarProximaSessaoDoCiclo {
                    self.gerenciadorSessoes.registrarSessaoIndividualConcluida(
                        idSessaoConcluida: sessaoMapeada.id,
                        dataConclusao: Date()
                    )
                    self.carregarTreinosParaExibicao()
                } else {
                    print("TelaTreinos: Tentativa de concluir sessão via callback, mas não é permitido neste momento.")
                }
            }
            return TreinoDisplayItem(
                id: sessaoMapeada.id,
                nome: sessaoMapeada.nomeSessao,
                exercicios: nomesDosExercicios,
                viewDestinationFactory: {
                    AnyView(ExecucaoSessaoView(
                        sessao: sessaoMapeada,
                        concluirAcao: acaoConcluirParaEstaSessao,
                        
                        mostrarBotaoConcluir: podeConcluirQualquerSessaoHoje
                    ))
                }
            )
        }
        print("TelaTreinos: Treinos para exibir atualizados. Pode concluir algum hoje: \(podeConcluirQualquerSessaoHoje)")
    }
}

#Preview {
    TelaTreinos()
        .environmentObject(GerenciadorSessoesViewModel())
        .preferredColorScheme(.dark)
}
