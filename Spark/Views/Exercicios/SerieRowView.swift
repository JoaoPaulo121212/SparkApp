import SwiftUI

struct SerieRowView: View {
    @Binding var serie: SerieDetalhe 
    let placeholderColor = Color.gray.opacity(0.6)
    let corTextoPrincipal = Color.white

    var body: some View {
        HStack(spacing: 8) {
            Text("\(serie.numeroSerie)")
                .foregroundColor(corTextoPrincipal.opacity(0.9))
                .modifier(CabecalhoSerieStyle(alignment: .center)) // CabecalhoSerieStyle.swift

            TextField("", text: $serie.peso,
                      prompt: Text(serie.peso.isEmpty || serie.peso == "--" ? "-- kg" : serie.peso)
                                .foregroundColor(placeholderColor)
            )
            .modifier(TextFieldEditorSerieStyle())
            .onTapGesture { if serie.peso == "--" { serie.peso = "" } }

            TextField("", text: $serie.reps,
                      prompt: Text(serie.reps.isEmpty || serie.reps == "8-12" ? "8-12 reps" : serie.reps)
                                .foregroundColor(placeholderColor)
            )
            .modifier(TextFieldEditorSerieStyle())
            .onTapGesture { if serie.reps == "8-12" { serie.reps = "" } }

            TextField("", text: $serie.descanso,
                      prompt: Text(serie.descanso.isEmpty || serie.descanso == "2min" ? "2min" : serie.descanso)
                                .foregroundColor(placeholderColor)
            )
            .modifier(TextFieldEditorSerieStyle())
            .onTapGesture { if serie.descanso == "2min" { serie.descanso = "" } }
        }
        .padding(.vertical, 2)
    }
}
