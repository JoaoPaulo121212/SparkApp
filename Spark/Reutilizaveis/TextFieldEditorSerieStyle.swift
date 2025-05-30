import SwiftUI

struct TextFieldEditorSerieStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
            .keyboardType(.default)
            .frame(maxWidth: .infinity, minHeight: 35)
            .multilineTextAlignment(.center)
            .overlay(
                VStack {
                    Spacer()
                    Rectangle().frame(height: 1).foregroundColor(Color.gray.opacity(0.4))
                }
            )
    }
}
