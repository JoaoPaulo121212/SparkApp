import SwiftUI

struct ExercicioSessaoRowView: View {
    @Binding var itemSessao: ExercicioNaSessao
    let corBotaoPrincipal: Color
    let excluirSerieAction: (UUID, IndexSet) -> Void
    let adicionarSerieAction: (UUID) -> Void
    
    var body: some View {
        Section(header:
            Text(itemSessao.exercicioBase.nome)
                .font(.title3).bold().foregroundColor(corBotaoPrincipal)
                .padding(.vertical, 8).frame(maxWidth: .infinity, alignment: .leading)
                .textCase(nil)
        ) {
            ForEach($itemSessao.series) { $serieDetalheBinding in
                SerieRowView(serie: $serieDetalheBinding)
            }
            .onDelete { offsets in
                excluirSerieAction(itemSessao.id, offsets)
            }
            Button(action: {
                adicionarSerieAction(itemSessao.id)
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Adicionar Série")
                }
                .font(.caption.bold())
                .foregroundColor(corBotaoPrincipal)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 6)
        }
        .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}
