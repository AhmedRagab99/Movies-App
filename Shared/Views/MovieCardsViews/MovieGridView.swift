//
//  MovieGridView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import SwiftUI

enum UIUserInterfaceIdiom : Int {
    case unspecified
    case phone // iPhone and iPod touch style UI
    case pad   // iPad style UI (also includes macOS Catalyst)
}

struct MovieGridView: View {
   
    let movies:[Movie]
    @EnvironmentObject private var movieBookmarkViewModel:MovieBookmarkViewModel
    
    
    var body: some View {
      
        ScrollView(.vertical, showsIndicators: false) {
            
                VStack {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 8)]) {
                    ForEach(movies) { item in

                        NavigationLink {
                            MovieDetailView(movie: item)
                        } label: {
                            MovieGridItemView(item: item, movieBookmarkViewModel: movieBookmarkViewModel)
                        }
                 
                        .buttonStyle(.plain)

                      }
                        .frame(minHeight:
                                UIDevice.current.userInterfaceIdiom == .pad ?
                               360:250,maxHeight:UIScreen.main.bounds.height)
                    .background(Color(uiColor: .tertiarySystemBackground))
                    .mask(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 4)
                   
                      
                    }
                }
            }

          }
        
    }
    




struct MovieGridView_Previews: PreviewProvider {
    @StateObject static var movieBookmarkViewModel = MovieBookmarkViewModel()
    static var previews: some View {
        MovieGridView(movies: Movie.stubbedMovies)
            .environmentObject(movieBookmarkViewModel)
      
    }
}

