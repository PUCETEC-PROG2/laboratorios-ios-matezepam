//
//  RepoForm.swift
//  GithubClient
//
//  Created by Usuario invitado on 7/7/26.
//

import SwiftUI

struct RepoForm: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Formulario de Repositorio")
            }
            .navigationTitle("Formulario de Repositorio")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RepoList()
}
