import SwiftUI
struct TelaTreinos: View {
    @State var StreakPresented = false
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    Text("Treino de hoje")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.trailing, 150)
                    Button(action:{
                        StreakPresented = true
                    }){
                        Image(systemName: "flame")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                            .padding(.leading, 10)
                        
                        
                    }
                    .padding()
                }
                
                ScrollView{
                    CardTreino()
                    CardTreino()
                    CardTreino()
                    
                }
                
            }
        }
        .sheet(isPresented: $StreakPresented){
            StreakModel()
        }
    
    }
}

#Preview {
    TelaTreinos()
}
