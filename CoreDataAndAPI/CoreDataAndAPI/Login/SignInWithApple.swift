//
//  SignInWithApple.swift
//  CoreDataAndAPI
//
//  Created by Erick Ribeiro on 27/08/23.
//

import SwiftUI
import CloudKit                 // importe o CloudKit para o serviço iCloud
import AuthenticationServices   // importe os Serviços de Autenticação para fazer o login com a Apple funcionar

struct SignInWithApple: View {
    // Dê um estado de login, por padrão, ele é falso => não logado.
    @Binding var login: Bool
    @Binding var email: String
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var userID: String
    
    
    var body: some View {
        SignInWithAppleButton(
            // Solicitar o nome completo do usuário e o email
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]   // Você pode alterá-los se necessário.
            },
            // Uma vez que o usuário completa o login, obtenha o resultado
            onCompletion: { result in
                // Switch result
                switch result {
                    // Autenticação bem-sucedida
                case .success(let authResults):
                    switch authResults.credential {
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        let uID = appleIDCredential.user
                        
                        if let emailAddress = appleIDCredential.email,
                           let givenName = appleIDCredential.fullName?.givenName,
                           let familyName = appleIDCredential.fullName?.familyName {
                            
                            // Para um novo usuário se cadastrar e salvar os 3 registros no CloudKit
                            
                            let record = CKRecord(recordType: "UsersData", recordID: CKRecord.ID(recordName: uID))
                            record["email"] = emailAddress
                            record["firstName"] = givenName
                            record["lastName"] = familyName
                            CKContainer.init(identifier: "iCloud.app-nano").publicCloudDatabase.save(record) { (_, _) in
                                DispatchQueue.main.async {
                                    userID = record.recordID.recordName
                                }
                            }
                            
                            // Salve localmente
                            email = emailAddress
                            firstName = givenName
                            lastName = familyName
                            
                            // Altere o estado de login
                            self.login = true
                            
                        } else {
                            // Para um usuário que está voltando para fazer o login, recupere os registros salvos do CloudKit
                            CKContainer.init(identifier: "iCloud.app-nano").publicCloudDatabase.fetch(withRecordID: CKRecord.ID(recordName: uID)) { (record, error) in
                                
                                if let fetchedInfo = record {
                                    DispatchQueue.main.async {
                                        // Salve localmente
                                        userID = uID
                                        email = fetchedInfo["email"] as! String
                                        firstName = fetchedInfo["firstName"] as! String
                                        lastName = fetchedInfo["lastName"] as! String
                                        
                                        // Altere o estado de login
                                        self.login = true
                                    }
                                }
                            }
                        }
                        
                        // default break (don't remove)
                    default:
                        break
                    }
                case .failure(let error):
                    print("failure", error)
                }
            }
        )
        .signInWithAppleButtonStyle(.white)
        .frame(width:350,height:50)
    }
}
