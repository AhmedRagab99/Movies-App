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


struct ContentView: View {
    @StateObject var viewModel = MoviesViewModelFactory.getMoviesViewModel()
    var body: some View{
        NavigationView{
            RefreshableScrollView(title: "Pull Down", tintColor: .purple, content: {
                ScrollView(.vertical, showsIndicators: false){
                    
                    
                    ForEach(viewModel.sections) { item in
                        
                        
                        MovieSectionView(section: item)
                            .padding()
                    }
                    
                }
                
                
            }, onRefresh: {
                loadTask(invalidateCache: true)
            })
            .task {
                loadTask(invalidateCache: false)
            }
            
            .navigationTitle("News APP")
            .overlay{DataFetcherOverlayView(phase: viewModel.phaseState) {
                
                    loadTask(invalidateCache: true)
                
            }}
           
        }
    }
    @Sendable
    private func loadTask(invalidateCache:Bool)  {
        Task{
            await viewModel.loadMoviesFromAllEndpoints(invalidateCache: invalidateCache)
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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                
                
                ForEach(MovieSection.stubs) { item in
                    
                    
                    MovieSectionView(section: item)
                        .padding()
                }
            }
            .navigationTitle("News APP")
        }
    }
}
