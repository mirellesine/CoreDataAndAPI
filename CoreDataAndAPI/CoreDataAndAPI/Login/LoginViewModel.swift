//
//  LoginViewModel.swift
//  CoreDataAndAPI
//
//  Created by Erick Ribeiro on 28/08/23.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @AppStorage("loginView") var loginView = true
    
    @AppStorage("login") var login = false
    @AppStorage("email") var email = ""
    @AppStorage("firstName") var firstName = ""
    @AppStorage("lastName") var lastName = ""
    @AppStorage("userID") var userID = ""
    @AppStorage("role") var role = ""
}
