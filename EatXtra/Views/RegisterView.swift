import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack {
                    HStack {
                        Text("Create an account")
                            .font(.system(size: 24, design: .default))
                            .bold()
                            .padding(.leading, 16)
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text("Let's help you set up your account,")
                            .font(.system(size: 15, design: .default))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("it won't take long.")
                            .font(.system(size: 15, design: .default))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Name")
                            .font(.subheadline)
                        
                        TextField("Enter Name", text: $viewModel.name)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .padding()
                            .frame(width: 340, height: 60)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                    .padding(.top, 5)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Email")
                            .font(.subheadline)
                        
                        TextField("Enter Email", text: $viewModel.email)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .padding()
                            .frame(width: 340, height: 60)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                    .padding(.top, 5)
                    
                    //password field
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Enter Password")
                            .font(.subheadline)
                        ZStack{
                            if isPasswordVisible{
                                TextField("Enter Password", text: $viewModel.password)
                                    .textFieldStyle(DefaultTextFieldStyle())
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                                    .padding()
                                    .frame(width: 340, height: 60)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                            }else{
                                SecureField("Enter Password", text: $viewModel.password)
                                    .textFieldStyle(DefaultTextFieldStyle())
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                                    .padding()
                                    .frame(width: 340, height: 60)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                            }
                            HStack{
                                Button(action: {
                                    isPasswordVisible.toggle()
                                }) {
                                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                        .foregroundColor(.gray)
                                }
                                .padding(.leading, 300)
                            }
                        }
                    }
                    .padding(.top, 5)

                    //confirm passwoed field
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Confirm Password")
                            .font(.subheadline)
                        ZStack{
                            if isPasswordVisible{
                                TextField("Confirm Password", text: $viewModel.confirmPassword)
                                    .textFieldStyle(DefaultTextFieldStyle())
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                                    .padding()
                                    .frame(width: 340, height: 60)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                            }else{
                                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                                    .textFieldStyle(DefaultTextFieldStyle())
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                                    .padding()
                                    .frame(width: 340, height: 60)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                            }
                            HStack{
                                Button(action: {
                                    isPasswordVisible.toggle()
                                }) {
                                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                        .foregroundColor(.gray)
                                }
                                .padding(.leading, 300)
                            }
                        }
                    }
                    .padding(.top, 10)
//
//                    HStack {
//                        NavigationLink(destination: ForgotPassword()) {
//                            Text("Forgot Password?")
//                                .font(.subheadline)
//                                .foregroundColor(Color.yellow.opacity(0.9))
//                        }
//                        Spacer()
//                    }
//                    .padding(.horizontal)
                    
                    // Sign-Up Button
                    HStack {
                        Button(action: {
                            viewModel.register { success in
                                    if success {
                                                       // Navigate back to LoginView on success
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                                }) {
                                HStack {
                                    Text("Sign Up")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                                   
                                    Image(systemName: "arrow.right")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                        .padding()
                                    }
                                        .frame(width: 340, height: 70)
                                        .background(Color.green)
                                        .cornerRadius(15)
                                    }
                                }
                                .padding(.top, 5)
                                .padding()
                    
                    Text("--- Or Sign In With ---")
                        .foregroundColor(Color.black.opacity(0.4))
                    
                    HStack {
                        Link(destination: URL(string: "https://www.google.co.in/")!){
                            Image("Gooogle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white)
                                        .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
                                )
                                .padding()
                        }
                        
                        Link(destination: URL(string: "https://www.facebook.com/")!){
                            Image("Facebook")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white)
                                        .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
                                )
                                .padding()
                        }
                    }
                    
                    HStack {
                        Text("Already a member?")
                        
                        NavigationLink(destination: LoginView()) {
                            Text("Sign in")
                                .foregroundColor(Color.yellow.opacity(0.9))
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterView()
}
