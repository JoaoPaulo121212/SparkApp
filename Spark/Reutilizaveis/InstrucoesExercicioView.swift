import SwiftUI

struct InstrucoesExercicioView: View {
    let exercicio: ExercicioLocal
    @Environment(\.dismiss) var dismiss

    let corBotaoPrincipal = Color("CorBotao")

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Instruções:")
                        .font(.title2).bold()
                        .foregroundColor(Color.primary)
                        .padding(.bottom, 5)
                    
                    ForEach(Array(exercicio.instrucoes.enumerated()), id: \.offset) { index, instrucao in
                        HStack(alignment: .top, spacing: 8) {
                            Text("\(index + 1).")
                                .foregroundColor(Color.primary)
                            Text(instrucao)
                                .foregroundColor(Color.secondary)
                        }
                        .padding(.bottom, 3)
                    }
                    
                    if let observacoes = exercicio.observacoes, !observacoes.isEmpty {
                        Divider().padding(.vertical, 10)
                        Text("Observações:")
                            .font(.title3).bold()
                            .foregroundColor(Color.primary)
                            .padding(.bottom, 3)
                        Text(observacoes)
                            .foregroundColor(Color.secondary)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationTitle(exercicio.nome)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fechar") {
                        dismiss()
                    }
                }
            }
        }
        .accentColor(corBotaoPrincipal)
    }
}
struct InstrucoesExercicioView_Previews: PreviewProvider {
    static var previews: some View {
        let exercicioDeExemplo = dadosExerciciosLocais.first ?? ExercicioLocal(id: UUID(), nome: "Exercicio Padrão", grupoMuscular: "N/A", musculoPrincipal: "N/A", musculosSecundarios: [], equipamento: "N/A", instrucoes: ["Instrução 1 de exemplo.", "Instrução 2 longa para testar quebra de linha e visualização geral do texto na modal."], observacoes: "Alguma observação importante aqui.", gifUrlLocal: nil)
        InstrucoesExercicioView(exercicio: exercicioDeExemplo)
            .preferredColorScheme(.dark)
    }
}
