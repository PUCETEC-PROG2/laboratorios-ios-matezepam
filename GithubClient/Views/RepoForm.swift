import SwiftUI

struct RepoForm: View {
    @ObservedObject var controller: RepoListViewController

    @State private var repoName: String = ""
    @State private var repoDescription: String = ""
    @State private var selectedLanguage: String = "Swift"
    @State private var showSavedAlert = false

    private let languages: [String] = [
        "Swift", "Python", "JavaScript", "Java", "Go", "Ruby", "C++", "Objective-C"
    ]

    var body: some View {
        NavigationStack {
            Form {
                Section("Nombre") {
                    TextField(
                        "",
                        text: $repoName,
                        prompt: Text("Nombre del repositorio")
                    )
                }

                Section("Descripción") {
                    TextEditor(text: $repoDescription)
                        .frame(minHeight: 120)
                }

                Section("Lenguaje") {
                    Picker("Lenguaje", selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language).tag(language)
                        }
                    }
                }

                if controller.isLoading {
                    ProgressView("Guardando...")
                }

                if let errorMsg = controller.errorMsg {
                    Text(errorMsg)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Section {
                    HStack {
                        Button(action: {
                            repoName = ""
                            repoDescription = ""
                        }) {
                            Label("Cancelar", systemImage: "xmark.circle")
                                .padding(.all, 4)
                                .foregroundStyle(Color.red)
                        }
                        .buttonStyle(.bordered)

                        Spacer()

                        Button(action: {
                            Task {
                                let success = await controller.createRepo(
                                    name: repoName,
                                    description: repoDescription,
                                    language: selectedLanguage
                                )
                                if success {
                                    repoName = ""
                                    repoDescription = ""
                                    showSavedAlert = true
                                }
                            }
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.down")
                                Text("Guardar")
                            }
                            .padding(.all, 4)
                            .foregroundStyle(.white)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(repoName.isEmpty || controller.isLoading)
                    }
                }
            }
            .navigationTitle("Formulario de Repositorio")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Repositorio creado", isPresented: $showSavedAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Se creó con .gitignore de \(selectedLanguage). El lenguaje del repo se verá reflejado en GitHub solo cuando subas código.")
            }
        }
    }
}

#Preview {
    RepoForm(controller: RepoListViewController())
}
