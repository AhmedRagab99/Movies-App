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
        let moviesViewModel = MoviesViewModel(movieRepo: movieRepo)
        return moviesViewModel
    }
}
struct ContentView: View {
    @StateObject var viewModel = MoviesViewModelFactory.getMoviesViewModel()
    var body: some View{
        NavigationView{
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(viewModel.sections.first?.movies ?? []){ movie in
                        
                        MovieItem(movie: movie)
                            .frame(maxWidth:200,maxHeight: 250)
                            .cornerRadius(20)
                            .padding()
                        
                    }
                }
            }
            .task {
                await loadTask()
            }
            .overlay{DataFetcherOverlayView(phase: viewModel.phaseState) {
                Task{
                    await retryAction()
                }
            }}
        }
    }
    
    private func retryAction() async{
        print("retry one")
        await viewModel.fetchMovies(endPoint: .latest)
    }
    
    @Sendable
    private func loadTask() async {
        await viewModel.fetchMovies(endPoint: .nowPlaying)
    }
    
}



struct MovieItem:View{
    
    let movie:Movie
    var body: some View {
        
        VStack(){
            AsyncImage(url: movie.posterURL) { phase  in
                switch phase{
                case .empty:
                    ProgressView()
                case .failure:
                    Image(systemName: "photo")
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                @unknown default:
                    fatalError()
                }
            }
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        List{
            MovieItem(movie: .stubbedMovie)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listStyle(.plain)
        }
    }
}
