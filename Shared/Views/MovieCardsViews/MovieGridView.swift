//
//  MovieGridView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import SwiftUI

enum UIUserInterfaceIdiom : Int {
    case unspecified
    case phone // iPhone and iPod touch style UI
    case pad   // iPad style UI (also includes macOS Catalyst)
}

struct MovieGridView: View {
   
    let movies:[Movie]
    @EnvironmentObject private var movieBookmarkViewModel:MovieBookmarkViewModel
    
    var body: some View {
      
        ScrollView(.vertical, showsIndicators: false) {
            
                VStack {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 8)]) {
                    ForEach(movies) { item in
                        GeometryReader { proxy in
                            
                        VStack(spacing:8) {
                            
                                BackDropCardView(movie:item)
                                .frame(height:proxy.frame(in: CoordinateSpace.local).height * 0.4)
    

                            Text(item.title ?? "")
                                .font(.headline)
                                .fontWeight(.bold)
                            HStack {
                                Spacer()
                                Text(item.overview)
                                    .font(.subheadline)
                                    .lineLimit(nil)
                                    
                                Spacer()
                                
                            }
                            Spacer()
                            HStack{
                                VStack(alignment:.leading) {
                                    Text("\(item.releaseDate ?? "")")
                                        .foregroundColor(.gray)
                                    Text(item.ratingText)
                                        .foregroundColor(Color.yellow)
                                }
                                .padding()
                                Spacer()
                                Image(systemName: movieBookmarkViewModel.isBookmarked(for: item) ? "bookmark.fill":"bookmark")
                                    .onTapGesture{
                                        withAnimation {
                                            movieBookmarkViewModel.toggleBookmark(for: item)
                                        }
                                    }
                                    .padding()
                            }
                            
                            
                        }

                      }
                        
                        .frame(minHeight:
                                UIDevice.current.userInterfaceIdiom == .pad ?
                               360:250,maxHeight:UIScreen.main.bounds.height)
                    .background(Color(uiColor: .tertiarySystemBackground))
                    .mask(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 4)
                      
                    }
                }
            }

          }
        
    }
    
}



struct MovieGridView_Previews: PreviewProvider {
    @StateObject static var movieBookmarkViewModel = MovieBookmarkViewModel()
    static var previews: some View {
        MovieGridView(movies: Movie.stubbedMovies)
            .environmentObject(movieBookmarkViewModel)
      
    }
}
