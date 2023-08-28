//
//  LoginView.swift
//  CoreDataAndAPI
//
//  Created by Erick Ribeiro on 27/08/23.
//

import SwiftUI
import CloudKit                 // importe o CloudKit para o serviço iCloud
import AuthenticationServices   // importe os Serviços de Autenticação para fazer o login com a Apple funcionar

// Start a new Login View
struct LoginView: View {
    
    @StateObject private var loginViewModel = LoginModel()
    
    let roles = ["Student", "Mentor"]
    @State private var selectedRole:String = "Student"

    var body: some View {
        NavigationView {
            ZStack{
                // Content
                VStack {
                    if (!loginViewModel.login && (loginViewModel.userID == "")) {
                        Spacer()
                        
                        HStack{
                            Spacer()
                                .frame(width:400,height:400)
                                .padding(.trailing,-95)
                        }.ignoresSafeArea(.all)
                        
                        Spacer()
                        
                        SignInWithApple(login: $loginViewModel.login, email: $loginViewModel.email, firstName: $loginViewModel.firstName, lastName: $loginViewModel.lastName, userID: $loginViewModel.userID)
                        
                    }
                    
                    // Mostrar informações do usuário
                    if loginViewModel.userID != "" {
                        UserInfoView(email: $loginViewModel.email, firstName: $loginViewModel.firstName, userID: $loginViewModel.userID, role: $loginViewModel.role, loginView: $loginViewModel.loginView)
                    }
                }.padding()
            }
            .toolbar {
                if (loginViewModel.login && (loginViewModel.userID != "")) {
                    Button(action: {
                        loginViewModel.login = false
                        loginViewModel.userID = ""
                        loginViewModel.email = ""
                        loginViewModel.firstName = ""
                        loginViewModel.lastName = ""
                    }) {
                        Text("Sign out").foregroundColor(.white)
                    }
                }
            }
            .navigationTitle("Academy Apps")
            .preferredColorScheme(.dark)
        }
    }
}
