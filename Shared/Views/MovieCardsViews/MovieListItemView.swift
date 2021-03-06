//
//  MovieListItemView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 09/05/2022.
//

import SwiftUI

struct MovieListItemView: View {
    let movie:Movie
    @EnvironmentObject private var movieBookmarkViewModel:MovieBookmarkViewModel
    
    var body: some View {
        
    
        HStack(spacing:16){

            NavigationLink {
                MovieDetailView(movie: movie)
            } label: {
                AsyncImageView(imageUrl: movie.posterURL)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(5)
                    .frame(width: 80, height: 80)
                    .cornerRadius(5)
                VStack(alignment:.leading,spacing:8){
                    Text(movie.title ?? "")
                        .font(.headline)
                        .lineLimit(3)
                    HStack {
                        Text(movie.ratingText)
                            .foregroundColor(Color(UIColor.systemYellow))
                            .font(.caption2)
                            .lineSpacing(4)
                        Text(movie.scoreText)
                            
                    }
                }
                Spacer()

                    Image(systemName: movieBookmarkViewModel.isBookmarked(for: movie) ? "bookmark.fill":"bookmark")
                    .onTapGesture {
                        withAnimation{
                        movieBookmarkViewModel.toggleBookmark(for: movie)
                        }
                    }
                    .padding()
            }
            .buttonStyle(.plain)

            
            
        }
        .background(Color(UIColor.clear))
        .cornerRadius(20)
        .shadow(radius: 3)

    }
}

struct MovieListItemView_Previews: PreviewProvider {
    @StateObject static var movieBookmarkViewModel = MovieBookmarkViewModel()
    static var previews: some View {
        List(0 ..< 12) { item in
            MovieListItemView(movie: .stubbedMovies[item])
                .frame(width:.infinity)
        }
        .listStyle(.plain)
        .environmentObject(movieBookmarkViewModel)
        
    }
}
