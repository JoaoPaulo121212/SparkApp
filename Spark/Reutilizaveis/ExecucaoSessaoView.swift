import SwiftUI

struct ExecucaoSessaoView: View {
    let sessao: SessaoDeTreino
    var concluirAcao: () -> Void
    @Environment(\.dismiss) var dismiss

    let corBotaoPrincipal = Color("CorBotao")
    let corTextoPrincipal = Color.white
    let corTextoSecundario = Color.gray

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Exercícios: \(sessao.exercicios.count)")
                    .foregroundColor(corTextoSecundario)
                    .padding(.bottom)
                List {
                    ForEach(sessao.exercicios) { exercicioNaSessao in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(exercicioNaSessao.exercicioBase.nome)
                                .font(.headline).foregroundColor(corTextoPrincipal)
                            ForEach(exercicioNaSessao.series) { serie in
                                Text("Série \(serie.numeroSerie): \(serie.reps) reps, \(serie.peso), \(serie.descanso) descanso")
                                    .font(.subheadline).foregroundColor(corTextoSecundario)
                            }
                        }
                        .padding(.vertical, 4)
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
                .background(Color("BackgroundColor"))
                .scrollContentBackground(.hidden)

                Spacer()
                Button("Concluir Sessão") {
                    concluirAcao()
                    dismiss()
                }
                .font(.headline).padding()
                .foregroundColor(corTextoPrincipal)
                .frame(maxWidth: .infinity)
                .background(corBotaoPrincipal).cornerRadius(10)
                .padding()
            }
        }
        .navigationTitle(sessao.nomeSessao)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left").foregroundColor(.white)
                }
            }
        }
    }
}
struct ExecucaoSessaoView_Previews: PreviewProvider {
    static var previews: some View {
        let exercicioMock = ExercicioLocal(nome: "Supino Teste", grupoMuscular: "Peito", musculoPrincipal: "Peitoral", musculosSecundarios: [], equipamento: "Barra", instrucoes: ["Instrução 1"], observacoes: nil, gifUrlLocal: nil)
        let serieMock = SerieDetalhe(numeroSerie: 1, reps: "10", peso: "50kg", descanso: "60s")
        let exercicioNaSessaoMock = ExercicioNaSessao(exercicioBase: exercicioMock, series: [serieMock])
        let sessaoMock = SessaoDeTreino(nomeSessao: "Treino Mock A", exercicios: [exercicioNaSessaoMock])
        
        NavigationView { 
            ExecucaoSessaoView(sessao: sessaoMock, concluirAcao: {
                print("Sessão Mock Concluída no Preview")
            })
            .preferredColorScheme(.dark)
        }
    }
}
