// Arquivo: CardTreino.swift
import SwiftUI

struct CardTreino: View {
    let titulo: String
    // Adicione outras propriedades se o Card precisar de mais dados do TreinoDisplayItem

    var body: some View {
        Text(titulo)
            .font(.title2).bold() // Como na sua última versão
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.secondary.opacity(0.2)) // Usando Color.secondary para tema adaptável
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}
