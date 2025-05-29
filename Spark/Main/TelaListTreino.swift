import SwiftUI

struct TelaListTreino: View {
    @State var AddModelPresented = false
    @State private var deveAdicionarTreino = false
    @AppStorage("objetivoSelecionado") private var objetivoSalvo: String = ""
    @StateObject private var gerenciadorSessoes = GerenciadorSessoesViewModel()
    
    var treinosPorObjetivo: [String: [[String]]] = [
        "Emagrecimento": [
            ["Supino reto Máquina","Supino inclinado máquina", "Cruxifico máquina", "Elevação frontal", "⁠Elevação lateral" , "Trícepes corda na polia", "Tríceps testa na polia barra W"],
            ["Corrida", "Agachamento", "Bicicleta"],
            ["Burpees", "Mountain Climbers", "Jumping Jacks"]
        ],
        "Ganho de massa muscular": [
            ["Supino reto Máquina","Supino inclinado máquina", "Cruxifico máquina", "Elevação frontal", "⁠Elevação lateral" , "Trícepes corda na polia", "Tríceps testa na polia barra W"],
            ["Agachamento livre","Leg Press 45°", "cadeira extensora","mesa flexora", "cadeira flexora","panturrilha máquina em pé","panturrilha sentado"],
            ["puxada na barra reta", "remada baixa no triângulo","Pulldown", "remada aberta na maquina", "rosca direta com halteres", "rosca 45°"]
        ]
    ]
    
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Seu plano de treino")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                        Button(action: {
                            AddModelPresented = true
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                        .padding(.top, 20)
                    }
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            if let treinos = treinosPorObjetivo[objetivoSalvo] {
                                ForEach(Array(treinos.enumerated()), id: \.offset) { index, exercicios in
                                    CardTreinoEditavel(
                                        titulo: "Treino \(Character(UnicodeScalar(65 + index)!))",
                                        exercicios: exercicios
                                    )
                                    .frame(maxWidth: .infinity)
                                }
                            } else {
                                Text("Nenhum treino disponível")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                    }
                    
                }
                
                Spacer()
            }
            .sheet(isPresented: $AddModelPresented) {
                AddModel()
                    .environmentObject(gerenciadorSessoes)
                    .interactiveDismissDisabled(true)
            }
            .navigationDestination(isPresented: $deveAdicionarTreino) {
                AdicionarSessao()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    TelaListTreino()
        .preferredColorScheme(.dark)
}
