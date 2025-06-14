//
//  LoginView.swift
//  EatXtra
//
//  Created by Subham Patel on 14/01/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    @StateObject var vm = ProfileViewViewModel()
    @State private var navigateToHome = false
    @State private var isLoading: Bool = false
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Welcome Texts
                HStack {
                    Text("Hello,")
                        .font(.system(size: 30, design: .default))
                        .bold()
                        .padding(.leading, 16)
                    Spacer()
                }
                HStack {
                    Text("Welcome Back!")
                        .font(.system(size: 24, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                .padding(.horizontal)
                
                // Email Field
                VStack(alignment: .leading, spacing: 16) {
                    Text("Email")
                        .font(.subheadline)
                    
                    TextField("Enter Email", text: $viewModel.email)
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
                .padding(.top, 20)
                
                // Password Field
                
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
                .padding(.top, 20)
                
                // Error Message
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                // Forgot Password
                HStack {
                    NavigationLink(destination: ForgotPassword()) {
                        Text("Forgot Password?")
                            .font(.subheadline)
                            .foregroundColor(Color.yellow.opacity(0.9))
                    }
                    Spacer()
                }
                .padding()
                
                //Sign In
                Button(action: {
                    isLoading = true // Show loading indicator
                    viewModel.signIn { success in
                        isLoading = false // Hide loading indicator
                        if success {
                            print("Sign-in successful!")
                            navigateToHome = true
                        } else {
                            print("Sign-in failed.")
                        }
                    }
                }) {
                    if isLoading {
                        ProgressView() // Display a spinner while loading
                            .frame(width: 340, height: 70)
                            .background(Color.green)
                            .cornerRadius(15)
                    } else {
                        HStack {
                            Text("Sign In")
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
                .background(
                    NavigationLink("", destination: HomeView(viewModel: vm), isActive: $navigateToHome)
                )

                
                // Divider
                Text("---Or Sign In With---")
                    .padding()
                    .foregroundColor(Color.black.opacity(0.4))
                
                // Social Media Buttons
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
                
                // Sign Up Navigation
                HStack {
                    Text("Don't have an account?")
                    
                    NavigationLink(destination: RegisterView()) {
                        Text("Sign up")
                            .foregroundColor(Color.yellow.opacity(0.9))
                    }
                }
                .padding()
            }
            .ignoresSafeArea()
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView()
}
