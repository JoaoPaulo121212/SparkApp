import SwiftUI
struct NavigationModifier: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .onAppear {
                let apparecence = UINavigationBarAppearance()
                apparecence.titleTextAttributes = [.foregroundColor: UIColor(color)]
                apparecence.largeTitleTextAttributes = [.foregroundColor: UIColor(color)]
                UINavigationBar.appearance().standardAppearance = apparecence
        }
    }
}
extension View {
    public func navigationColor(_ color: Color) -> some View {
        
        return self.modifier(NavigationModifier(color: color))
    }
}
