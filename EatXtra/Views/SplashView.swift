import SwiftUI

struct SplashView: View {
    var body: some View {
        NavigationView{
        VStack{
            ZStack{
                Image("Recipee")
                    .resizable()
                    .ignoresSafeArea()
                
                Text("SIMPLE WAY TO FIND TASTY RECIPE")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 430)
                
                HStack {
                    NavigationLink(destination: LoginView()) {
                        HStack {
                            Text("Start Cooking")
                                .font(.headline)
                                .foregroundColor(Color.white)
                            
                            Image(systemName: "arrow.right")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .padding()
                        }
                        .frame(width: 280, height: 60)
                        .background(Color.green)
                        .cornerRadius(20)
                        .padding(.top, 650)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
