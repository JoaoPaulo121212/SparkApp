import SwiftUI

struct CardTreino: View {
    var titulo: String = "Treino"

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.1))
                .frame(height: 100)
            Text(titulo)
                .foregroundColor(.white)
                .font(.title3)
            
        }
    }
}

struct TreinoAView: View {
    @Binding var concluirTreino: () -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
//                "Ganho de massa muscular": [
//                    ["Supino reto Máquina","Supino inclinado máquina", "Cruxifico máquina", "Elevação frontal", "⁠Elevação lateral" , "Trícepes corda na polia", "Tríceps testa na polia barra W"]
                
                Button("Concluir Treino") {
                    concluirTreino()
                    dismiss()
                }
                .padding()
                .background(Color.green)
                .cornerRadius(10)
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
        
    }
    
}

struct TreinoBView: View {
    @Binding var concluirTreino: () -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Conteúdo do Treino B")
                    .foregroundColor(.white)
                    .font(.title)
                
                Button("Concluir Treino") {
                    concluirTreino()
                    dismiss()
                }
                .padding()
                .background(Color.green)
                .cornerRadius(10)
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

struct TreinoCView: View {
    @Binding var concluirTreino: () -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Conteúdo do Treino C")
                    .foregroundColor(.white)
                    .font(.title)
                
                Button("Concluir Treino") {
                    concluirTreino()
                    dismiss()
                }
                .padding()
                .background(Color.green)
                .cornerRadius(10)
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

struct TreinoDView: View {
    @Binding var concluirTreino: () -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Conteúdo do Treino D")
                    .foregroundColor(.white)
                    .font(.title)
                
                Button("Concluir Treino") {
                    concluirTreino()
                    dismiss()
                }
                .padding()
                .background(Color.green)
                .cornerRadius(10)
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}
