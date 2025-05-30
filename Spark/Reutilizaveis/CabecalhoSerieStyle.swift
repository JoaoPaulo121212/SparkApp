import SwiftUI

struct CabecalhoSerieStyle: ViewModifier {
    var alignment: Alignment = .leading
    func body(content: Content) -> some View {
        content
            .font(.caption.weight(.semibold))
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
}
