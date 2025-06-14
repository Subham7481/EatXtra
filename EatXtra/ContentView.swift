import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ProfileViewViewModel() 

    var body: some View {
        Group {
            if viewModel.isLoggedIn{
                HomeView(viewModel: viewModel)
            } else {
                LoginView()
            }
        }
        .onAppear {
            viewModel.checkAuthentication()
        }
    }
}

#Preview {
    ContentView()
}
