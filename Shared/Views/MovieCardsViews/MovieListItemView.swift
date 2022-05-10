//
//  MovieListItemView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 09/05/2022.
//

import SwiftUI

struct MovieListItemView: View {
    let movie:Movie
    
    var body: some View {
        HStack(spacing:16){
            AsyncImageView(imageUrl: movie.posterURL)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
                .frame(width: 80, height: 80)
                .cornerRadius(5)
            VStack(alignment:.leading,spacing:8){
                Text(movie.title ?? "")
                    .font(.headline)
                HStack {
                    Text(movie.ratingText)
                        .foregroundColor(Color(UIColor.systemYellow))
                        .font(.caption2)
                        .lineSpacing(4)
                    Text(movie.scoreText)
                        
                }
            }
            Spacer()
            Button {
                print("test here")
            } label: {
                Image(systemName: "bookmark")
                
                
            }.padding(.horizontal)
            
        }
        //        .padding()
        .background(Color(UIColor.clear))
        .cornerRadius(20)
        .shadow(radius: 3)
        
        
        
    }
}

struct MovieListItemView_Previews: PreviewProvider {
    static var previews: some View {
        List(0 ..< 12) { item in
            MovieListItemView(movie: .stubbedMovies[item])
                .frame(width:.infinity)
        }
        .listStyle(.plain)
    }
}
