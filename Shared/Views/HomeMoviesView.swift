//
//  HomeMoviesView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import SwiftUI

struct HomeMoviesView: View {
    @StateObject var viewModel = MoviesViewModelFactory.getMoviesViewModel()
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State var endPoint:MovieListEndPoints = .topRated

    var body: some View{
        rootView
            
        }
    
    @ViewBuilder
    private var rootView:some View{
        switch horizontalSizeClass {
        case .regular:
            homeGridView
                .padding()
                .shadow(radius: 5)
        default:
            homeListView
        }
    }
    
    private var homeGridView:some View{
        RefreshableScrollView(title: "Pull Down", tintColor: .purple) {
            if let section = viewModel.sections.first {
                MovieGridView(movies: section.movies)
            }
        } onRefresh: {
            print("refresh")
            ImageCache.emptyCache()
            loadTask(invalidateCache: true, with: endPoint)
        }.task {
            loadTask(invalidateCache: false, with: endPoint)
        }
        .overlay{DataFetcherOverlayView(phase: viewModel.phaseState) {
            loadTask(invalidateCache: true, with: endPoint)
        }}

    }
    
    private var homeListView:some View{
        RefreshableScrollView(title: "Pull Down", tintColor: .purple, content: {
            ScrollView(.vertical, showsIndicators: false){
                
                
                ForEach(viewModel.sections) { item in
                    
                    
                    MovieSectionView(section: item)
                        .padding()
                }
                
            }
            
            
        }, onRefresh: {
            ImageCache.emptyCache()
            loadAllTasks(invalidateCache: true)
        })
        .task {
            loadAllTasks(invalidateCache: false)
        }
        .overlay{DataFetcherOverlayView(phase: viewModel.phaseState) {
            loadAllTasks(invalidateCache: true)
        }}
    }
    
    
    @Sendable
    private func loadTask(invalidateCache: Bool,with endpoint:MovieListEndPoints){
        Task{
            await viewModel.fetchMovies(invalidateCache: invalidateCache, endPoint:endpoint)
        }
    }
    
    @Sendable
    private func loadAllTasks(invalidateCache:Bool)  {
        Task{
            await viewModel.loadMoviesFromAllEndpoints(invalidateCache: invalidateCache)
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
