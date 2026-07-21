import SwiftUI

struct RepoItem: View {
    let repo: Repo

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: repo.owner.avatarUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image("githubLogo")
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(repo.name)
                    .font(.title3.bold())

                if let description = repo.description {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                if let language = repo.language {
                    HStack {
                        Text("Lenguaje")
                            .font(.caption.bold())
                        Text(language)
                            .font(.caption)
                    }
                    .padding(.top, 2)
                }
            }
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    RepoItem(
        repo: Repo(
            id: 1,
            name: "laboratorios-ios",
            description: "Cliente de GitHub para iOS",
            language: "Swift",
            owner: UserInfo(
                login: "matezepam",
                name: "Mateo Salazar",
                avatarUrl: "",
                bio: nil
            )
        )
    )
}
