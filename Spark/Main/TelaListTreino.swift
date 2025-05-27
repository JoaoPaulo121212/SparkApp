import SwiftUI

struct TelaListTreino: View {
    @State var AddModelPresented = false
    @State private var deveAdicionarTreino = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    HStack{
                        Text("Seu plano de treino")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.top, 20)
                        Spacer()
                        Button(action: {
                            AddModelPresented = true
                            print("Botão plus.circle apertado para apresentar AddModel")
                        }) {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                        .padding(.top, 20)
                    }
                    ScrollView {
                        VStack{
                            CardTreino()
                            Button(action: {
                                
                            }) {
                                Image(systemName: "pencil")
                                    .resizable().frame(width: 20, height: 20)
                                    .foregroundStyle(.white)
                                    .padding()
//
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    }
                
                Spacer()
            }
            .sheet(isPresented: $AddModelPresented){
                AddModel()
            }
            NavigationLink(destination: AdicionarSessao(), isActive: $deveAdicionarTreino) {
                EmptyView()
            }
            .hidden()
        }
        .navigationBarBackButtonHidden(true)
    }
    
}

#Preview {
    TelaListTreino()
        .preferredColorScheme(.dark)
}
