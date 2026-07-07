//
//  RepoList.swift
//  GithubClient
//
//  Created by Usuario invitado on 7/7/26.
//

import SwiftUI

struct RepoList:View {
    var body: some View {
        NavigationStack {
            VStack {
                RepoItem()
                RepoItem()
                RepoItem()
                RepoItem()
                RepoItem()
            }
            .navigationTitle("Repositorios")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}
#Preview {
    RepoList()
}
