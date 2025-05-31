// Arquivo: TreinoAView.swift
import SwiftUI

struct TreinoAView: View {
    var concluirAcao: () -> Void // Ação recebida para marcar como concluído
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all) // Sua cor de fundo
            VStack {
                // Conteúdo do Treino A - Liste os exercícios aqui
                Text("Exercícios do Treino A")
                    .font(.title).foregroundColor(.white)
                    .padding()
                
                // Exemplo de como listar exercícios (o senhor precisará de dados reais aqui)
                List {
                    Text("Supino reto Máquina").foregroundColor(.white)
                    Text("Supino inclinado máquina").foregroundColor(.white)
                    Text("Cruxifico máquina").foregroundColor(.white)
                    // Adicione mais exercícios
                }
                .listStyle(.plain)
                .background(Color("BackgroundColor"))
                .scrollContentBackground(.hidden) // Para iOS 16+

                Spacer()

                Button("Concluir Treino A") {
                    concluirAcao() // Chama a ação passada pela TelaTreinos
                    dismiss()      // Fecha esta view de treino
                }
                .font(.headline).padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .background(Color("CorBotao")) // Sua cor de botão
                .cornerRadius(10)
                .padding()
            }
        }
        .navigationTitle("Treino A")
        .navigationBarTitleDisplayMode(.inline) // Para um título menor
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left").foregroundColor(Color("CorBotao"))
                }
            }
        }
    }
}
