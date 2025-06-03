import SwiftUI

struct DetalheTreinoConcluidoView: View {
    let sessao: SessaoDeTreino
    
    @Environment(\.dismiss) var dismiss

    let corDeFundoPrincipal = Color("BackgroundColor")
    let corTextoPrincipal = Color.white
    let corTextoSecundario = Color.gray
    
    init(sessao: SessaoDeTreino) {
            self.sessao = sessao
            print("DEBUG DetalheTreinoConcluidoView: INIT com Sessão: '\(sessao.nomeSessao)', Exercícios: \(sessao.exercicios.count)")
        }
    
    var body: some View {
        NavigationView {
            ZStack {
                corDeFundoPrincipal.edgesIgnoringSafeArea(.all)
                    VStack(alignment: .leading, spacing: 20) {
                        Text(sessao.nomeSessao)
                            .font(.title2)
                            .bold()
                            .foregroundColor(corTextoPrincipal)
                            .padding(.top)
                            .padding(.leading)
                            ScrollView {
                        if sessao.exercicios.isEmpty {
                            Text("Nenhum exercício nesta sessão.")
                                .foregroundColor(corTextoSecundario)
                                .padding()
                        } else {
                            ForEach(sessao.exercicios) { exercicioNaSessao in
                                ExercicioDetalheView(exercicioSessao: exercicioNaSessao)
                                Divider().background(Color.gray.opacity(0.5))
                            }
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationTitle("Treino realizado")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(corTextoPrincipal)
                    }
                }
            }
        }
        .accentColor(corTextoPrincipal)
    }
}

struct ExercicioDetalheView: View {
    let exercicioSessao: ExercicioNaSessao

    let corTextoPrincipal = Color.white
    let corTextoSecundario = Color.gray

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(exercicioSessao.exercicioBase.nome)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(corTextoPrincipal)

            if !exercicioSessao.series.isEmpty {
                HStack {
                    Text("SÉRIE").modifier(CabecalhoSerieStyleDetalhe())
                    Text("PESO").modifier(CabecalhoSerieStyleDetalhe(alignment: .center))
                    Text("REPS").modifier(CabecalhoSerieStyleDetalhe(alignment: .center))
                    Text("DESCANSO").modifier(CabecalhoSerieStyleDetalhe(alignment: .center))
                }
                .padding(.top, 5)
            }

            ForEach(exercicioSessao.series) { serie in
                HStack {
                    Text("\(serie.numeroSerie)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(corTextoSecundario)
                    
                    Text(serie.peso.isEmpty ? "-" : serie.peso)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(corTextoPrincipal)
                    
                    Text(serie.reps.isEmpty ? "-" : serie.reps)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(corTextoPrincipal)
                    
                    Text(serie.descanso.isEmpty ? "-" : serie.descanso)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(corTextoSecundario)
                }
                .font(.subheadline)
                .padding(.vertical, 2)
            }
        }
        .padding(.vertical)
    }
}

struct CabecalhoSerieStyleDetalhe: ViewModifier {
    var alignment: Alignment = .leading
    let corTextoCabecalho = Color.gray

    func body(content: Content) -> some View {
        content
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(corTextoCabecalho)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
}
#Preview {
    let exercicioExemplo1 = ExercicioLocal(nome: "Agachamento Livre com Barra", grupoMuscular: "Pernas", musculoPrincipal: "Quadríceps", musculosSecundarios: ["Glúteos", "Coxas"], equipamento: "Barra", instrucoes: [""], observacoes: "", gifUrlLocal: "")

    let seriesExemplo = [
        SerieDetalhe(numeroSerie: 1, reps: "10-12", peso: "50kg", descanso: "60s"),
        SerieDetalhe(numeroSerie: 2, reps: "10-12", peso: "50kg", descanso: "60s"),
        SerieDetalhe(numeroSerie: 3, reps: "10-12", peso: "50kg", descanso: "60s")
    ]

    let sessaoExemplo = SessaoDeTreino(
        id: UUID(),
        nomeSessao: "Pernas & Panturrilhas (GM)",
        exercicios: [
            ExercicioNaSessao(exercicioBase: exercicioExemplo1, series: seriesExemplo),

        ],
        dataCriacao: Date(),
        isModeloIntocado: false
    )
    DetalheTreinoConcluidoView(sessao: sessaoExemplo)
        .preferredColorScheme(.dark)
        .environmentObject(GerenciadorSessoesViewModel()) 
}
