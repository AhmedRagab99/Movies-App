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
        
        
        CacheAsyncImage(url: imageUrl, scale: 0.5, transaction: Transaction(animation: .easeInOut)) { phase in
            switch phase{
            case .empty:
                ProgressView()

            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    
            case .success(let image):
                image
                    .resizable()
                    
                    .transition(.scale(scale: 0.5, anchor: .center))
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
