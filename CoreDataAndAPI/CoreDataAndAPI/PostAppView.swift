//
//  PostAppView.swift
//  CoreDataAndAPI
//
//  Created by Erick Ribeiro on 25/08/23.
//

import SwiftUI
import PhotosUI

struct PostAppView: View {
    
    @ObservedObject var viewModel = ProjectViewModel()
    
    // Intância projeto que será enviada para API
    @State private var project: ProjectPost = ProjectPost(id: UUID(), name: "", turma: "", description: "", bigIdea: "", challenge: "", essentialQuestion: "", link: "")
    
    @State private var selectedIcon: PhotosPickerItem?
    @State private var selectedIconData: Data?
    
    @State private var selectedScreenshot: PhotosPickerItem?
    @State private var selectedScreenshotData: Data?
    
    @State private var alertMessage = AlertMessage()
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("General")) {
                    TextField("Name", text: $project.name)
                    TextField("Turma", text: $project.turma)
                    TextField("Link", text: $project.link)
                }
                Section(header: Text("CBL")) {
                    TextField("Big Idea", text: $project.bigIdea)
                    TextField("Essential Question", text: $project.essentialQuestion)
                    TextField("Challenge", text: $project.challenge)
                }
                Section(header: Text("Description")) {
                    ZStack{
                        if project.description.isEmpty  {
                            Text("The app covers about...")
                                .foregroundColor(Color(.placeholderText))
                                .padding(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4))
                        }
                        
                        TextEditor(text: $project.description)
                            .frame (height: 180)
                        
                    }
                }
                
                Section() {
                    // Selecionar ícone da galeria
                    PhotosPicker(selection: $selectedIcon, matching: .any(of:[.images, .not(.livePhotos)])) {
                        
                        if let selectedPhotoData = selectedIconData,
                           let image = UIImage(data: selectedPhotoData) {
                            HStack {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 24, height: 24)                                     .padding(.trailing, 5)
                                Text("Select icon")
                            }
                        } else {
                            Label("Select icon", systemImage: "photo")
                                .tint(.purple)
                                .controlSize(.large)
                                .buttonStyle(.borderedProminent)
                        }
                    }
                    
                    // Selecionar screenshot da galeria
                    PhotosPicker(selection: $selectedScreenshot, matching: .any(of:[.images, .not(.livePhotos)])) {
                        
                        if let selectedPhotoData = selectedScreenshotData,
                           let image = UIImage(data: selectedPhotoData) {
                            HStack {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .padding(.trailing, 5)
                                Text("Select screenshot")
                            }
                        } else {
                            Label("Select screenshot", systemImage: "photo")
                                .tint(.purple)
                                .controlSize(.large)
                                .buttonStyle(.borderedProminent)
                        }
                    }
                    
                }.onChange(of: selectedIcon) { newIconItem in
                    // Este bloco é executado quando a propriedade `selectedIcon` é alterada.
                    Task {
                        // Tenta carregar dados do `newIconItem` de forma assíncrona, convertendo-os para o tipo `Data`.
                        if let data = try? await newIconItem?.loadTransferable(type: Data.self) {
                            selectedIconData = data
                            project.imgIcon = data
                        }
                    }
                }
                .onChange(of: selectedScreenshot) { newScreenshotItem in
                    // Este bloco é executado quando a propriedade `selectedScreenshot` é alterada.
                    Task {
                        // Tenta carregar dados do `newScreenshotItem` de forma assíncrona, convertendo-os para o tipo `Data`.
                        if let data = try? await newScreenshotItem?.loadTransferable(type: Data.self) {
                            selectedScreenshotData = data
                            project.imgScreenshot = data
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        // publica projeto
                        viewModel.postProjects(app: project) { result in
                            switch result {
                            case .success:
                                showAlert(title: "Success", message: "Project published successfully.")
                            case .failure:
                                showAlert(title: "Error", message: "There was an error, please check all fields and try again.")
                            }
                        }
                    }) {
                        Text("Publish now")
                    }
                }
                // popup exibido após clicar no botão publicar
            }.alert(alertMessage.title, isPresented: $alertMessage.show) {
                Button("OK", role: .cancel, action: {})
            } message: {
                Text(alertMessage.message)
                
            }
            .navigationTitle("Publish app")
        }
    }
    
    // passa as informações de exibição do alerta
    func showAlert(title: String, message: String) {
        alertMessage.title = title
        alertMessage.message = message
        alertMessage.show = true
    }
}

struct PostAppView_Previews: PreviewProvider {
    static var previews: some View {
        PostAppView()
    }
}

// estrutura do Popup após envio do projeto
struct AlertMessage {
    var show:Bool = false
    var title:String = ""
    var message:String = ""
}
