//
//  MovieGridItemView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 13/05/2022.
//

import SwiftUI

struct MovieGridItemView: View {
    let item:Movie
    @ObservedObject var movieBookmarkViewModel:MovieBookmarkViewModel
    var body: some View {
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
                    .font(.footnote)
                    
                
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
    }
}


struct MovieGridItemView_Previews: PreviewProvider {
    @StateObject static var vm = MovieBookmarkViewModel()
    static var previews: some View{
        MovieGridItemView(item: .stubbedMovie, movieBookmarkViewModel: vm)
            .environmentObject(vm)
    }
}
