//
//  ContentView.swift
//  Shared
//
//  Created by Ahmed Ragab on 08/05/2022.
//

import SwiftUI

enum MoviesViewModelFactory{
    @MainActor static func getMoviesViewModel() -> MoviesViewModel{
        let movieRepo:MoviesRepoProtocol = MoviesRepo()
        let moviesUseCase = MoviesUseCase(movieRepo: movieRepo)
        let moviesViewModel = MoviesViewModel(movieUseCase:moviesUseCase)
        return moviesViewModel
    }
}
struct ContentView:View{
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    var body: some View {
        switch horizontalSizeClass {
        case .regular:
            SidebarContentView()
        default:
            TabsContentView()
        }
    }
}
