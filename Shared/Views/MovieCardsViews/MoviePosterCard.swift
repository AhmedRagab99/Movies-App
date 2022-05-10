//
//  MoviePosterCard.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import SwiftUI

struct MoviePosterCard: View {
    let movie:Movie

    var body: some View {
        ZStack {

            AsyncImageView(imageUrl: movie.posterURL)
                .frame(maxHeight: 180)
                    .cornerRadius(8)
                    .shadow(radius: 4)
        }
        .padding(.horizontal)
//        .aspectRatio(16/9, contentMode: .fit)
        
    }
}


struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(movie: .stubbedMovie)
    }
}
