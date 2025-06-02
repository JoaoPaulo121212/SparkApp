import SwiftUI
struct StreakModel: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var gerenciadorSessoes: GerenciadorSessoesViewModel
    @State private var mostrarAlertaInfoStreak = false
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 35) {
                    Spacer()

                    Image(systemName: "flame.fill")
                        .font(.system(size: 120))
                        .foregroundColor(Color("CorBotao"))

                    VStack(spacing: 8) {
                        Text("Sequência ativa há")
                            .font(.title2)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text("\(gerenciadorSessoes.calcularSequenciaAtual()) dias")
                            .font(.system(size: 52, weight: .bold))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.white)
                            .font(.title3.weight(.medium))
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Sua Sequência")
                        .font(.headline).bold().foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { mostrarAlertaInfoStreak.toggle() }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.white)
                            .font(.title3)
                    }
                }
            }
            .alert("Ativação da Sequência", isPresented: $mostrarAlertaInfoStreak) {
                Button("Entendido", role: .cancel) { mostrarAlertaInfoStreak = false }
            } message: {
                Text("Para ativar um dia na sua sequência, você deve concluir individualmente todas as diferentes sessões de treino que você criou, ao longo dos seus dias de treino.")
            }
        }
        .accentColor(Color("CorBotao"))
    }
}
struct StreakModel_PreviewWrapper_v2: View {
    @StateObject var mockGerenciador: GerenciadorSessoesViewModel
    init() {
        let manager = GerenciadorSessoesViewModel()
        let cal = Calendar.current
        let hoje = cal.startOfDay(for: Date())
        let ontem = cal.startOfDay(for: cal.date(byAdding: .day, value: -1, to: Date())!)
        let anteontem = cal.startOfDay(for: cal.date(byAdding: .day, value: -2, to: Date())!)
        _mockGerenciador = StateObject(wrappedValue: manager)
    }
    var body: some View {
        StreakModel().environmentObject(mockGerenciador)
    }
}
#Preview {
    StreakModel_PreviewWrapper_v2()
        .preferredColorScheme(.dark)
}
