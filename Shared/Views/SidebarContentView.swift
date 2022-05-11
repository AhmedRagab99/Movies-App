//
//  SidebarContentView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import SwiftUI

struct SidebarContentView: View {
    var body: some View {
        NavigationView {

                List {
                    ForEach([MenuItem.saved, MenuItem.search]) {
                        navigationLinkForMenuItem(item: $0)
                    }
                    
                    Section {
                        ForEach(MovieListEndPoints.menuItems) {
                            navigationLinkForMenuItem(item: $0)
                        }
                    } header: {
                        Text("Categories")
                    }
                    .navigationTitle("Movies App")
                }
                .listStyle(.sidebar)
            
            HomeMoviesView()
            }
        }
    
    
    
    private func navigationLinkForMenuItem(item:MenuItem)->some View{
        NavigationLink(destination: viewForMenuItem(item: item)) {
            Label(item.text, systemImage: item.systemImage)
        }
    }
    @ViewBuilder
    private func viewForMenuItem( item: MenuItem) -> some View {
        switch item {
        case .search:
            MovieSearchView()
                .padding()
        case .saved:
            BookmarkView()
                .padding()
        case .category(let category):
            HomeMoviesView(endPoint:category)
        }
    }
}

struct SidebarContentView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarContentView()
    }
}
