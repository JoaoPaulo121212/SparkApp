// Arquivo: TreinoBView.swift
import SwiftUI

struct TreinoBView: View {
    var concluirAcao: () -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            VStack {
                Text("Exercícios do Treino B")
                    .font(.title).foregroundColor(.white).padding()
                // Adicione a lista de exercícios do Treino B aqui
                Spacer()
                Button("Concluir Treino B") {
                    concluirAcao()
                    dismiss()
                }
                .font(.headline).padding().foregroundColor(.white)
                .frame(maxWidth: .infinity).background(Color("CorBotao")).cornerRadius(10).padding()
            }
        }
        .navigationTitle("Treino B")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: { Image(systemName: "chevron.left").foregroundColor(Color("CorBotao")) }
            }
        }
    }
}
