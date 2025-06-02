import SwiftUI

struct ExecucaoSessaoView: View {
    let sessao: SessaoDeTreino
    var concluirAcao: () -> Void
    let mostrarBotaoConcluir: Bool
    @Environment(\.dismiss) var dismiss

    let corBotaoPrincipal = Color("CorBotao")
    let corTextoPrincipal = Color.white
    let corTextoSecundario = Color.gray
    let corCardExercicio = Color.gray.opacity(0.15)

    @State private var seriesCompletasStatus: [UUID: [UUID: Bool]] = [:]
    @State private var mostrarAlertaSair: Bool = false
    @State private var itemSheetInstrucoes: ExercicioLocal? = nil
    
    private var progressoAtualFeito: Bool {
        for (_, seriesStatusParaExercicio) in seriesCompletasStatus {
            for (_, isCompleta) in seriesStatusParaExercicio {
                if isCompleta {
                    return true
                }
            }
        }
        return false
    }

    private var todosExerciciosDaSessaoCompletos: Bool {
        if sessao.exercicios.isEmpty {
            return false
        }
        for exercicio in sessao.exercicios {
            if !todasSeriesCompletas(para: exercicio.id) {
                return false
            }
        }
        return true
    }

    init(sessao: SessaoDeTreino, concluirAcao: @escaping () -> Void, mostrarBotaoConcluir: Bool) {
        self.sessao = sessao
        self.concluirAcao = concluirAcao
        self.mostrarBotaoConcluir = mostrarBotaoConcluir
        
        var initialStatus: [UUID: [UUID: Bool]] = [:]
        for exercicio in sessao.exercicios {
            var seriesStatusParaExercicio: [UUID: Bool] = [:]
            for serie in exercicio.series {
                seriesStatusParaExercicio[serie.id] = false
            }
            initialStatus[exercicio.id] = seriesStatusParaExercicio
        }
        self._seriesCompletasStatus = State(initialValue: initialStatus)
    }

    private func todasSeriesCompletas(para exercicioId: UUID) -> Bool {
        guard let seriesDoExercicio = seriesCompletasStatus[exercicioId] else { return false }
        return !seriesDoExercicio.contains(where: { !$0.value })
    }

    private func contarSeriesCompletas(para exercicioId: UUID) -> Int {
        guard let seriesDoExercicio = seriesCompletasStatus[exercicioId] else { return 0 }
        return seriesDoExercicio.filter { $0.value }.count
    }

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                List {
                    ForEach(sessao.exercicios) { exercicioNaSessao in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                if todasSeriesCompletas(para: exercicioNaSessao.id) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(corBotaoPrincipal)
                                        .font(.title2)
                                }
                                Text(exercicioNaSessao.exercicioBase.nome)
                                    .font(.title2).bold()
                                    .foregroundColor(corTextoPrincipal)
                                    .strikethrough(todasSeriesCompletas(para: exercicioNaSessao.id), color: corBotaoPrincipal)
                                
                                Spacer()
                                
                                Button {
                                    self.itemSheetInstrucoes = exercicioNaSessao.exercicioBase
                                } label: {
                                    Image(systemName: "info.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(corBotaoPrincipal)
                                }
                                .padding(.leading, 5)
                                Text("\(contarSeriesCompletas(para: exercicioNaSessao.id))/\(exercicioNaSessao.series.count)")
                                    .font(.headline)
                                    .foregroundColor(todasSeriesCompletas(para: exercicioNaSessao.id) ? corBotaoPrincipal : corTextoSecundario)
                            }
                            .padding(.bottom, 10)
                            ForEach(exercicioNaSessao.series) { serie in
                                HStack(spacing: 8) {
                                    Button {
                                        seriesCompletasStatus[exercicioNaSessao.id]?[serie.id]?.toggle()
                                    } label: {
                                        Image(systemName: seriesCompletasStatus[exercicioNaSessao.id]?[serie.id] ?? false ? "checkmark.circle.fill" : "circle")
                                            .font(.title2)
                                            .foregroundColor(seriesCompletasStatus[exercicioNaSessao.id]?[serie.id] ?? false ? corBotaoPrincipal : corTextoSecundario)
                                    }
                                    .buttonStyle(PlainButtonStyle())

                                    Text("Série \(serie.numeroSerie): \(serie.reps) reps, \(serie.peso), \(serie.descanso) descanso")
                                        .font(.body)
                                        .foregroundColor(corTextoSecundario)
                                        .strikethrough(seriesCompletasStatus[exercicioNaSessao.id]?[serie.id] ?? false, color: corTextoSecundario.opacity(0.7))
                                    Spacer()
                                }
                                .padding(.vertical, 3)
                                if serie.id != exercicioNaSessao.series.last?.id {
                                    Divider().background(Color.gray.opacity(0.3))
                                }
                            }
                        }
                        .padding()
                        .background(corCardExercicio)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(todasSeriesCompletas(para: exercicioNaSessao.id) ? Color.red : Color.clear, lineWidth: 2)
                        )
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                Spacer()
                if mostrarBotaoConcluir {
                    Button("Concluir Sessão") {
                        concluirAcao()
                        dismiss()
                    }
                    .font(.headline).padding()
                    .foregroundColor(todosExerciciosDaSessaoCompletos ? corTextoPrincipal : corTextoSecundario.opacity(0.8))
                    .frame(maxWidth: .infinity)
                    .background(todosExerciciosDaSessaoCompletos ? corBotaoPrincipal : Color.gray.opacity(0.4))
                    .cornerRadius(10)
                    .padding()
                    .disabled(!todosExerciciosDaSessaoCompletos)
                    
                    if !todosExerciciosDaSessaoCompletos && mostrarBotaoConcluir {
                        Text("Conclua todas as séries de todos os exercícios para finalizar a sessão.")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                    }
                }
            }
        }
        .navigationTitle(sessao.nomeSessao)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    if progressoAtualFeito {
                        mostrarAlertaSair = true
                    } else {
                        dismiss()
                    }
                } label: {
                    Image(systemName: "chevron.left").foregroundColor(corTextoPrincipal)
                }
            }
        }
        .alert("Atenção", isPresented: $mostrarAlertaSair) {
            Button("Sair") {
                dismiss()
            }
            Button("Cancelar", role: .cancel) { }
        } message: {
            Text("Se você sair agora, o progresso das séries marcadas nesta sessão será perdido. Deseja realmente sair?")
        }
        .sheet(item: $itemSheetInstrucoes) { exercicioItem in
            InstrucoesExercicioView(exercicio: exercicioItem)
        }
    }
}
struct ExecucaoSessaoView_Previews: PreviewProvider {
    static var previews: some View {
        let exercicioMock1 = ExercicioLocal(id: UUID(), nome: "Supino Reto", grupoMuscular: "Peito", musculoPrincipal: "Peitoral", musculosSecundarios: [], equipamento: "Barra", instrucoes: ["Deite no banco", "Segure a barra", "Desça até o peito e suba"], observacoes: "Manter a lombar apoiada", gifUrlLocal: nil)
        let seriesEx1 = [
            SerieDetalhe(id: UUID(), numeroSerie: 1, reps: "10", peso: "50kg", descanso: "60s"),
            SerieDetalhe(id: UUID(), numeroSerie: 2, reps: "8", peso: "55kg", descanso: "60s"),
            SerieDetalhe(id: UUID(), numeroSerie: 3, reps: "6", peso: "60kg", descanso: "60s")
        ]
        let exercicioNaSessaoMock1 = ExercicioNaSessao(id: UUID(), exercicioBase: exercicioMock1, series: seriesEx1)
        let exercicioMock2 = ExercicioLocal(id: UUID(), nome: "Agachamento Livre", grupoMuscular: "Pernas", musculoPrincipal: "Quadríceps", musculosSecundarios: ["Glúteos", "Isquiotibiais"], equipamento: "Barra", instrucoes: ["Posicione a barra nos ombros", "Agache até 90 graus"], observacoes: nil, gifUrlLocal: nil)
        let seriesEx2 = [
            SerieDetalhe(id: UUID(), numeroSerie: 1, reps: "12", peso: "70kg", descanso: "90s"),
            SerieDetalhe(id: UUID(), numeroSerie: 2, reps: "10", peso: "75kg", descanso: "90s")
        ]
        let exercicioNaSessaoMock2 = ExercicioNaSessao(id: UUID(), exercicioBase: exercicioMock2, series: seriesEx2)
        let sessaoMock = SessaoDeTreino(id: UUID(), nomeSessao: "Treino Peito & Pernas", exercicios: [exercicioNaSessaoMock1, exercicioNaSessaoMock2], dataCriacao: Date())
        
        NavigationView {
            ExecucaoSessaoView(
                sessao: sessaoMock,
                concluirAcao: { print("Sessão Mock Concluída no Preview (Botão Visível)") },
                mostrarBotaoConcluir: true
            )
            .preferredColorScheme(.dark)
        }
    }
}
