//
//  MovieSearchGridItem.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import SwiftUI

struct MovieSearchGridItem: View {
    let movie:Movie
    var body: some View {
        AsyncImageView(imageUrl: movie.posterURL)
    }
}

struct MovieSearchGridItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchGridItem(movie: Movie.stubbedMovie)
    }
}
