//
//  ContentView.swift
//  Shared
//
//  Created by Ahmed Ragab on 08/05/2022.
//

import SwiftUI


struct ContentView: View {
    @StateObject var viewModel = MoviesViewModel()
    var body: some View{
        NavigationView{
        ScrollView(.horizontal, showsIndicators: false){
        
//        List{
            HStack{
                ForEach(movies){ movie in
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
        .overlay{overlayView}
    }
    }
    
    
    @ViewBuilder
    private var overlayView:some View {
        switch viewModel.phaseState{
        case .empty:
            ProgressView()
        case .failure(let error):
            RetryView(text: error.localizedDescription){
                Task{
                await retryAction()
                }
            }
        case .success(let movies) where movies.isEmpty:
            EmptyPlaceholderView(text: "No Movies", image: Image("test.png"))
        
        default: EmptyView()
        }
    }
    
    private var movies: [Movie] {
        if case let .success(movies) = viewModel.phaseState {
            return movies
        } else {
            return []
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
