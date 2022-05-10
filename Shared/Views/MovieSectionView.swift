//
//  MovieSectionView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 09/05/2022.
//

import SwiftUI

struct MovieSectionView: View {
    let section:MovieSection
    
    var body: some View {
        VStack(spacing:1){
            HStack{
                Text(section.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
                
                NavigationLink {
                    List{
                        ForEach(section.movies) { item in
                            
                            MovieListItemView(movie: item)
                                .padding()
                        }
                        
                    }
                    .listStyle(.plain)
                    
                } label: {
                    Text("See More")
                        .font(.headline)
                        .padding()
                }
            }
            ScrollView(.horizontal,showsIndicators: false){
                HStack {
                    ForEach(0..<section.movies.count) { item in
                        createSectionView(section: section, movie: section.movies[item])
//                            .padding()
                            .onTapGesture {
                                
                            }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func createSectionView(section:MovieSection,movie:Movie)-> some View{

        switch section.endpoint{
        case .popular:
            CustomCardView(movie: movie)
            
        case .topRated:
            BackDropCardView(movie: movie)
                .aspectRatio(16/9, contentMode: .fit)
                .frame(height: 160)
           

        case .upcoming:
            CustomCardView(movie: movie)
                .frame(height: 180)

        case .nowPlaying:
            PosterCardView(movie: movie)

            
                

         
        }
    }
}

struct MovieSectionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSectionView(section: .stubs[0])
    }
}
