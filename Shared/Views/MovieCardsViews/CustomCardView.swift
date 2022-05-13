//
//  MovieCustomCardView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import SwiftUI

struct CustomCardView: View {
    let movie:Movie
    
    
    var body: some View {
        
            ZStack {
                
                AsyncImageView(imageUrl: movie.posterURL)

                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: 280)
       
            }
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding(.horizontal)

    }
}

struct MovieCustomCardView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCardView(movie: .stubbedMovie)
    }
}
