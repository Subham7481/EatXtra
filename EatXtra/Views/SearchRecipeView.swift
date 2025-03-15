import SwiftUI

struct SearchRecipeView: View {
    @State private var count = 0
    var body: some View {
        VStack{
            Button("Increment"){
                count += 1
            }
            .frame(width: 200, height: 60)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .padding()
            Text("Count is \(count)")
        }
    }
}

#Preview {
    SearchRecipeView()
}
