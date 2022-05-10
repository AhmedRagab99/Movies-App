//
//  MoviePoseterView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 09/05/2022.
//

import SwiftUI

struct PosterCardView: View {
    let movie:Movie
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.width * 0.6
    var body: some View {
        
        VStack {
            AsyncImageView(imageUrl: movie.posterURL)
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth:200,maxHeight: 180)
                .cornerRadius(10)
                .padding()
                .shadow(radius: 5)
                
            
            Text(movie.title ?? "")
                .foregroundColor(.primary)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                
            
                
            
            Text(movie.ratingText)
                .foregroundColor(Color(UIColor.systemYellow))
                .font(.headline)
            
        }
        
        
    }
}


struct MoviePoseterView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack {
                
                ForEach(0 ..< 20) { item in
                    PosterCardView(movie: .stubbedMovies[item])
                    
                    
                }
            }
        }
    }
}
