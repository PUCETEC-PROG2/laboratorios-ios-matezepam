import SwiftUI

struct RepoItem: View {
    var body: some View {
        HStack {
            Image (uiImage: .githubLogo)
                .resizable()
                .frame(width: 80, height: 80)
                Spacer()
            VStack (alignment: .leading) {
                Text("Nombre del Repositorio")
                    .font(.title2)
                    Text("Lorem Inpsun dolor descripción del repositorio")
                HStack {
                    Text("Lenguaje:")
                        .font(.caption)
                    Spacer()
                    Text("Swift")
                        .font(.caption)
                }
                
            }
        }
        .padding()
    }
}
    
#Preview {
    RepoItem()
}
