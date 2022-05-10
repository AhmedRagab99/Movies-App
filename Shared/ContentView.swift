//
//  ContentView.swift
//  Shared
//
//  Created by Ahmed Ragab on 08/05/2022.
//

import SwiftUI

enum MoviesViewModelFactory{
    static func getMoviesViewModel() -> MoviesViewModel{
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

struct MovieItem:View{
    let section:MovieSection
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack {
                ForEach(section.movies){ item in
                    VStack(){
                        AsyncImageView(imageUrl: item.posterURL)
                            .frame(maxWidth:200,maxHeight: 200)
                            .padding()
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                }
            }
        }
    }
}
