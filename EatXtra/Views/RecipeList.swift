import SwiftUI

struct RecipeList: View {
    @AppStorage("isDark") var isDark: Bool = false
    var body: some View {
        VStack{
            Text("Animated Gradient Card App")
                .padding()
            
            HStack{
                Toggle("", isOn: $isDark)
                    .preferredColorScheme(isDark ? .dark : .light)
            }.padding()
            
            
        }
    }
}

#Preview {
    RecipeList()
}
