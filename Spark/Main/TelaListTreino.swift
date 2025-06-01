import SwiftUI

struct TelaListTreino: View {
    @State var AddModelPresented = false
    @AppStorage("objetivoSelecionado") private var objetivoSalvo: String = "Emagrecimento"
    
    @EnvironmentObject private var gerenciadorSessoes: GerenciadorSessoesViewModel
    let treinosPorObjetivo: [String: [[String]]] = [
        "Emagrecimento": [
            ["Supino reto Máquina","Supino inclinado máquina", "Cruxifico máquina", "Elevação frontal", "Elevação lateral" , "Trícepes corda na polia", "Tríceps testa na polia barra W"],
            ["Corrida", "Agachamento", "Bicicleta"],
            ["Burpees", "Mountain Climbers", "Jumping Jacks"]
        ],
        "Ganho de massa muscular": [
            ["Supino reto Máquina","Supino inclinado máquina", "Cruxifico máquina", "Elevação frontal", "Elevação lateral" , "Trícepes corda na polia", "Tríceps testa na polia barra W"],
            ["Agachamento livre","Leg Press 45°", "cadeira extensora","mesa flexora", "cadeira flexora","panturrilha máquina em pé","panturrilha sentado"],
            ["puxada na barra reta", "remada baixa no triângulo","Pulldown", "remada aberta na maquina", "rosca direta com halteres", "rosca 45°"]
        ]
    ]
    let corDeFundoPrincipal = Color("BackgroundColor")
    let corTextoPrincipal = Color.white

    var body: some View {
        NavigationStack {
            ZStack {
                corDeFundoPrincipal.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Seu plano de treino")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(corTextoPrincipal)
                        Spacer()
                        
                        Button(action: {
                            AddModelPresented = true
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color("CorBotao"))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, UIApplication.shared.connectedScenes
                        .compactMap { $0 as? UIWindowScene }
                        .first?.windows.first?.safeAreaInsets.top ?? 0 > 20 ? 15 : 30)
                    ScrollView {
                        VStack(spacing: 16) {
                            if !gerenciadorSessoes.sessoesDeTreinoSalvas.isEmpty {
                                
                                ForEach(gerenciadorSessoes.sessoesDeTreinoSalvas) { sessao in
                                    
                                    NavigationLink(destination:
                                        
                                        Text("Destino para: \(sessao.nomeSessao)").foregroundColor(.white)
                                    ) {
                                        CardTreinoEditavel(
                                            titulo: sessao.nomeSessao,
                                            exercicios: sessao.exercicios.map { $0.exercicioBase.nome }
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .frame(maxWidth: .infinity)
                                }
                            } else if let treinosDoObjetivo = treinosPorObjetivo[objetivoSalvo], !treinosDoObjetivo.isEmpty {
                               
                                ForEach(Array(treinosDoObjetivo.enumerated()), id: \.offset) { index, exerciciosDoTreinoPreCriado in
                                    let nomeTreinoPreCriado = "Treino \(Character(UnicodeScalar(65 + index)!))"
                                    
                                    NavigationLink(destination:
                                        Text("Destino para: \(nomeTreinoPreCriado)").foregroundColor(.white)
                                    ) {
                                        CardTreinoEditavel(
                                            titulo: nomeTreinoPreCriado,
                                            exercicios: exerciciosDoTreinoPreCriado
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .frame(maxWidth: .infinity)
                                }
                            } else {
                                Text("Nenhum treino disponível.\nDefina um objetivo nas configurações ou crie um treino personalizado no botão '+' acima.")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                        .padding()
                    }
                }
            }
            .sheet(isPresented: $AddModelPresented) {
                AddModel() // AddModel.swift
                    .environmentObject(gerenciadorSessoes)
                    .interactiveDismissDisabled(true)
            }
           
        }
    }
}



#Preview {
    TelaListTreino()
        .preferredColorScheme(.dark)
        .environmentObject(GerenciadorSessoesViewModel())
}
