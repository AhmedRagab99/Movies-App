//
//  MovieBookmarkViewModel.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 11/05/2022.
//

import Foundation


class MovieBookmarkViewModel:ObservableObject{
     @Published private(set) var bookmarks: [Movie] = []
    private let bookmarkStore = PlistDataStore<[Movie]>(filename: "bookmarks")
    
    
     init() {
        Task {
            await load()
        }
    }
    
    @MainActor private func load() async {
        bookmarks = await bookmarkStore.load() ?? []
    }
    
    func isBookmarked(for movie: Movie) -> Bool {
        bookmarks.first { movie.id == $0.id } != nil
    }
    
    @MainActor func addBookmark(for movie: Movie) {
        guard !isBookmarked(for: movie) else {
            return
        }
        print("added movie")
        bookmarks.insert(movie, at: 0)
        bookmarkUpdated()
        
    }
    
    @MainActor func toggleBookmark(for movie: Movie) {
        if isBookmarked(for: movie) {
            removeBookmark(for: movie)
        } else {
            addBookmark(for: movie)
        }
    }
    @MainActor func removeBookmark(for movie: Movie) {
        
        guard let index = bookmarks.firstIndex(where: { $0.id == movie.id }) else {
            return
        }
        print("removed movie")
        bookmarks.remove(at: index)
        bookmarkUpdated()

    }
    
    private func bookmarkUpdated() {
        let bookmarks = self.bookmarks
        Task {
            await bookmarkStore.save(bookmarks)
        }
    }
    
    @MainActor func removeBookmark(with indexSet:IndexSet){
        bookmarks.remove(atOffsets: indexSet)
        bookmarkUpdated()
    }
}
