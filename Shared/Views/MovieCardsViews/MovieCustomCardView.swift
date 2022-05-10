//
//  MovieCustomCardView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import SwiftUI

struct MovieCustomCardView: View {
    let movie:Movie
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                AsyncImageView(imageUrl: movie.posterURL)
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            
            Text(movie.title ?? "")
        }
        .lineLimit(1)
    }
}

struct MovieCustomCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCustomCardView(movie: .stubbedMovie)
    }
}
