//
//  UserInoView.swift
//  CoreDataAndAPI
//
//  Created by Erick Ribeiro on 27/08/23.
//

import SwiftUI
import CloudKit

struct UserInfoView: View {
    
    @Binding var email: String
    @Binding var firstName: String
    @Binding var userID: String
    @Binding var role: String
    
    @Binding var loginView:Bool
    
    let roles = ["Student", "Mentor"]
    @State private var selectedRole = "Student"
    
    var body: some View {
        VStack(alignment: .center, spacing: 80) {
            VStack(alignment: .center, spacing: 10){
                Text("Welcome Academigo! \(firstName)")
                    .font(.title)
                
                HStack {
                    Label("Email Account:", systemImage: "envelope.circle")
                    Text(email)
                }.font(.footnote)
            }
            
            HStack {
                Label("Selecione seu cargo: ", systemImage: "person.crop.circle")
                Picker("Select your role", selection: $selectedRole) {
                    ForEach(roles, id: \.self) { role in
                        Text(role)
                    }
                }
            }
            Button(action: {
                updateUser()
                loginView = false
            }, label: {
                Text("Continuar")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            })
        }
        .padding()
        .cornerRadius(25)
    }
    
    func updateUser(){
        // Para um usuário que está voltando para fazer o login, recupere os registros salvos do CloudKit
        CKContainer.init(identifier: "iCloud.app-nano").publicCloudDatabase.fetch(withRecordID: CKRecord.ID(recordName: userID)) { (record, error) in
            
            if let fetchedInfo = record {
                fetchedInfo["role"] = selectedRole.lowercased()
                
                CKContainer.init(identifier: "iCloud.app-nano").publicCloudDatabase.save(fetchedInfo) { _, error in
                    if let saveError = error {
                        print("Erro ao salvar o registro:", saveError.localizedDescription)
                    } else {
                        print("Registro atualizado com sucesso")
                        role = selectedRole.lowercased()
                    }
                }
            }
        }
    }
}
