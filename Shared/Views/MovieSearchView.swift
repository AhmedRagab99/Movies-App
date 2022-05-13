//
//  MovieSearchView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import SwiftUI



enum MovieSearchFactory{
    @MainActor static func getMovieSearchViewModel()-> MovieSearchViewModel{
        let repo:MovieSearchRepoProtocol = MovieSearchRepo()
        let useCase:MovieSearchUseCaseProtocol = MovieSearchUseCase(movieSearchRepo: repo)
        let viewModel = MovieSearchViewModel(movieSearchUseCase: useCase)
        return viewModel
    }
}

struct MovieSearchView: View {
    @StateObject var viewModel = MovieSearchFactory.getMovieSearchViewModel()
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {

        rootView
        .searchable(text: $viewModel.query, prompt: "Search movies")
        .onAppear { viewModel.startObserve() }
        .overlay(overlayView)
        .listStyle(.plain)
        
    }
    
    
    @ViewBuilder
    private var rootView:some View{
        switch horizontalSizeClass{
        case .regular:
            gridView
        default:
            listView
        }
    }
    
    @ViewBuilder
    private var gridView:some View{
        MovieGridView(movies: viewModel.phaseState.value ?? [])
            .padding()
            
    }
    
    @ViewBuilder
    private var listView:some View{
        List {
            ForEach(viewModel.phaseState.value ?? []) { movie in
                
                    MovieListItemView(movie: movie)
                    .padding()
                
            }
            
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch viewModel.phaseState {
        case .empty:
            if viewModel.trimmedQuery.isEmpty {
                EmptyPlaceholderView(text: "Search your favorite movie", image: Image(systemName: "magnifyingglass"))
            } else {
                ProgressView()
            }
            
        case .success(let values) where values.isEmpty:
            EmptyPlaceholderView(text: "No results", image: Image(systemName: "film"))
            
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: {
                Task {
                    await viewModel.searchMovie(query:viewModel.query)
                }
            })
        default: EmptyView()
        }
    }
}



struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
