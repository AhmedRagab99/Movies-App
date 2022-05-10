//
//  MoviePosterCard.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import SwiftUI

struct MoviePosterCard: View {
    let movie:Movie
    private let height = UIScreen.main.bounds.width
    private let width = UIScreen.main.bounds.width * 0.6
    var body: some View {
        ZStack {

            AsyncImageView(imageUrl: movie.posterURL)
                    .cornerRadius(8)
                    .shadow(radius: 4)

        }.frame(width: width, height:height)
        
    }
}


struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(movie: .stubbedMovie)
    }
}
