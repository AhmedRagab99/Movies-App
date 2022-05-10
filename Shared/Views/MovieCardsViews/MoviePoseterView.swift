//
//  MoviePoseterView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 09/05/2022.
//

import SwiftUI

struct MoviePoseterView: View {
    let movie:Movie
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.width * 0.6
    var body: some View {
        
        VStack {
            AsyncImageView(imageUrl: movie.posterURL)
                .frame(maxWidth: width, maxHeight: height, alignment: .center)
                .cornerRadius(10)
                .padding()
                .shadow(radius: 5)
                
            
            Text(movie.title ?? "")
                .foregroundColor(.primary)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(2)
            
            Text(movie.ratingText)
                .foregroundColor(Color(UIColor.systemYellow))
                .font(.headline)
            
        }
        .padding(.horizontal)
        
    }
}


struct MoviePoseterView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack {
                
                ForEach(0 ..< 20) { item in
                    MoviePoseterView(movie: .stubbedMovies[item])
                    
                    
                }
            }
        }
    }
}
