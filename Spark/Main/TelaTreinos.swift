import SwiftUI

struct TelaTreinos: View {
    @State private var streakPresented = false
    @EnvironmentObject var gerenciadorSessoes: GerenciadorSessoesViewModel
    
    struct TreinoDisplayItem: Identifiable {
        let id: UUID
        let nome: String
        let exercicios: [String] // Nomes dos exercícios para exibição no card
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

    let corTextoPrincipal = Color.white
    let corTextoSecundario = Color.gray

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Treino de hoje")
                            .font(.title).bold().foregroundColor(corTextoPrincipal)
                        Spacer()
                        Button { streakPresented = true } label: {
                            Image(systemName: "flame")
                                .foregroundColor(Color("CorBotao")).font(.title2)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)
                    .padding(.bottom, 20)

                    ScrollView {
                        VStack(alignment: .leading, spacing: 25) {
                            treinoAtualSectionView()
                                .padding(.horizontal)
                            
                            if treinosParaExibir.count > 1 {
                                Text("Próximos treinos")
                                    .font(.title2).bold().foregroundColor(corTextoPrincipal)
                                    .padding(.horizontal)
                                
                                proximosTreinosSectionView()
                                     .padding(.horizontal)
                             }
                        }
                        .padding(.bottom, 20)
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
                    // CardTreino(titulo: treinoAtual.nome) // Se você tem um CardTreino customizado
                    // Se não, um Text simples para o título:
                    Text(treinoAtual.nome)
                        .font(.title2.bold())
                        .foregroundColor(corTextoPrincipal)
                        .padding(.bottom, 5)

                    if !treinoAtual.exercicios.isEmpty {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Exercícios:")
                                .font(.headline)
                                .foregroundColor(corTextoPrincipal.opacity(0.9))
                            ForEach(treinoAtual.exercicios, id: \.self) { nomeExercicio in
                                HStack {
                                    Image(systemName: "figure.walk")
                                        .foregroundColor(Color("CorBotao"))
                                        .font(.caption)
                                    Text(nomeExercicio)
                                        .font(.subheadline)
                                        .foregroundColor(corTextoSecundario)
                                }
                            }
                        }
                        .padding(.bottom, 5)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(12)
            }
            .buttonStyle(PlainButtonStyle())
            if !podeTreinarProximaSessaoDoCiclo && gerenciadorSessoes.dataUltimaSessaoIndividualConcluidaTS != nil {
                 Text("Você já concluiu um treino hoje!")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
            }
        } else {
            VStack(spacing: 8) {
                Text("Nenhuma Sessão de Treino")
                    .font(.title2).bold().foregroundColor(corTextoPrincipal)
                    .padding(.bottom, 5)
                Text("Crie suas sessões de treino para começar.")
                    .font(.subheadline).foregroundColor(corTextoSecundario)
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
                        .foregroundColor(corTextoPrincipal)
                    
                    if !treinoItem.exercicios.isEmpty {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Exercícios:")
                                .font(.callout).bold()
                                .foregroundColor(corTextoPrincipal.opacity(0.8))
                            ForEach(treinoItem.exercicios, id: \.self) { nomeExercicio in
                                HStack {
                                    Image(systemName: "list.bullet")
                                        .foregroundColor(corTextoSecundario.opacity(0.8))
                                        .font(.caption)
                                    Text(nomeExercicio)
                                        .font(.caption)
                                        .foregroundColor(corTextoSecundario)
                                }
                            }
                        }
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
    }
}

#Preview {
    TelaTreinos()
        .environmentObject(GerenciadorSessoesViewModel())
        .preferredColorScheme(.dark)
}
