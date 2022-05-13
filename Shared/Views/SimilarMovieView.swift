//
//  SimilarMovieView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 13/05/2022.
//

import SwiftUI

struct SimilarMovieView:View{
    let movies:[Movie]
    
    var body: some View{
        LazyVGrid(columns:
                    UIDevice.current.userInterfaceIdiom != .pad ?
                  [GridItem(.adaptive(minimum: 120, maximum: 260))]: [GridItem(.adaptive(minimum: 200, maximum: 360))]
                  ,spacing: 20){
            ForEach(movies) { item in
                CustomCardView(movie: item)
            }
            
        }.padding()
    }
}

struct SimilarMovieView_Previews: PreviewProvider {
    static var previews: some View {
        SimilarMovieView(movies: Movie.stubbedMovies)
    }
}
