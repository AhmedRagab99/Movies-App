//
//  AsyncImageView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 09/05/2022.
//

import SwiftUI

struct AsyncImageView: View {
    let imageUrl:URL
    var body: some View {
        AsyncImage(url: imageUrl) { phase  in
            switch phase{
            case .empty:
                
                Rectangle()
                    
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .overlay{ProgressView()}
                    
            case .failure:
                Image(systemName: "photo")
                    
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            @unknown default:
                fatalError()
            }
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(imageUrl: Movie.stubbedMovie.posterURL)
    }
}
