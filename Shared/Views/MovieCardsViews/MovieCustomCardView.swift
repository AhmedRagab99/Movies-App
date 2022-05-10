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
        VStack(alignment: .center) {
            ZStack {
                
                AsyncImageView(imageUrl: movie.posterURL)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: 280)
                    
            }
            
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding()
            
            Text(movie.title ?? "")
                .fontWeight(.semibold)
        }
        .lineLimit(1)
    }
}

struct MovieCustomCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCustomCardView(movie: .stubbedMovie)
    }
}
