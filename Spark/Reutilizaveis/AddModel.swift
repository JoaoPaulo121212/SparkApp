import SwiftUI
struct AddModel: View {
    @Environment(\.dismiss) var dismiss
    @State private var sessionName: String = ""
    let textFieldBackgroundColor = Color.gray.opacity(0.2)
    let placeholderColor = Color.gray
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    TextField("", text: $sessionName)
                        .placeholder(when: sessionName.isEmpty) {
                            Text("Nome da sessão").foregroundColor(placeholderColor)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(textFieldBackgroundColor)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    Spacer()
                    Image(systemName: "figure.strengthtraining.traditional")
                        .font(.system(size: 60))
                        .foregroundColor(.white.opacity(0.3))
                        .padding(.bottom)

                    Text("Comece sua sessão adicionando seus exercícios à ela.")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.3))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Spacer()
                    NavigationLink(destination: ExerciseListView()){
                        Text("Adicionar exercícios")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("CorBotao"))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
                .padding(.top, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                ToolbarItem(placement: .principal) {
                                    Text("Criação de treinos")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .bold()
                                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: TreinosTemplates()){
                        Image(systemName: "list.bullet.clipboard")
                            .foregroundColor(.white)
                    }

                    Button(action: {
                        Alert(title: Text("Nessa tela você pode criar sessões de treino à vontade, ou se preferir pode escolher um template já criado!"))
                        print("Botão de infos pressionado")
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
#Preview {
    AddModel()
}
