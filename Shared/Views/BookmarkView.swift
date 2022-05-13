//
//  BookmarkView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 11/05/2022.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject private var movieBookMarkViewModel:MovieBookmarkViewModel
    @State var searchText: String = ""
    
    var body: some View {
        List{
            ForEach(movies) { item in
                MovieListItemView(movie: item)
                
                    .padding()
                    
            }
            .onDelete{ indexSet in
                movieBookMarkViewModel.removeBookmark(with: indexSet)
            }
        }
        
        .listStyle(.plain)
        .overlay(overlayView(isEmpty: movies.isEmpty))
        .searchable(text: $searchText)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }

    private var movies: [Movie] {
        if searchText.isEmpty {
            return movieBookMarkViewModel.bookmarks
        }
        return movieBookMarkViewModel.bookmarks
            .filter {
                $0.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholderView(text: "No saved Movies", image: Image(systemName: "bookmark"))
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    @StateObject static var movieBookmarkViewModel = MovieBookmarkViewModel()
    static var previews: some View {
        BookmarkView()
            .environmentObject(movieBookmarkViewModel)
    }
}
