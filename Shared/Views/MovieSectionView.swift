//
//  MovieSectionView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 09/05/2022.
//

import SwiftUI

struct MovieSectionView: View {
    let section:MovieSection
    @State var selectedText = ""
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
                    .searchable(text: $selectedText)
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
//        private let height = UIScreen.main.bounds.width
//        private let width = UIScreen.main.bounds.width * 0.6
        switch section.endpoint{
        case .popular:
            MovieCustomCardView(movie: movie)
            
        case .topRated:
            MoviePoseterView(movie: movie)

        case .upcoming:
            MoviePosterCard(movie: movie)

    
        case .nowPlaying:
            MoviePoseterView(movie: movie)

         
        }
    }
}

struct MovieSectionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSectionView(section: .stubs[0])
    }
}
