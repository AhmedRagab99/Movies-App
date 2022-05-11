//
//  MoviePosterCard.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import SwiftUI

struct BackDropCardView: View {
    let movie:Movie
    @Environment (\.horizontalSizeClass) private var horizontalClass

    var body: some View {
        

        VStack(alignment: .leading, spacing: 8) {
            AsyncImageView(imageUrl: movie.posterURL)

                    .cornerRadius(8)
                    .shadow(radius: 4)
            if horizontalClass != .regular{
            Text(movie.title ?? "")
                .font(.headline)
                .lineLimit(1)
            }
        }
    }
}


struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        BackDropCardView(movie: .stubbedMovie)
    }
}
