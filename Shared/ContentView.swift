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
    
#if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    var body: some View {

        #if os(iOS)
        switch horizontalSizeClass {
        case .regular:
            
            SidebarContentView()
        default:
            TabsContentView()
        }
        #else
        Text("news app from mac")
            .padding()
        #endif
    }
}
