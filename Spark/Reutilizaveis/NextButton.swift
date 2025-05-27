import SwiftUI

struct NextButton : View {
    var text: String
    var body: some View {
        Button(action: {
            
        }) {
            Text(text)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 200, height: 50)
                .background(Color(red : 233/255, green: 9/255, blue: 22/255))
                .cornerRadius(15)
        }
    }
}
    #Preview {
        NextButton(text: "Altere me")
        }
