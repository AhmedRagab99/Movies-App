//
//  MovieReviewsView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 13/05/2022.
//

import SwiftUI

struct MovieReviewsView: View {
    let reviews:[ReviewsModelResult]
    var body: some View {
        ForEach(reviews) { item in
            HStack(alignment:.center,spacing: 0){
                AsyncImageView(imageUrl: item.authorDetails?.avatarPathURL ?? URL(string: "https://www.pexels.com/photo/man-wearing-blue-crew-neck-shirt-2287252/")!)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(maxHeight: 80, alignment: .leading)
                    .padding()
                VStack(alignment: .leading,spacing:0){
                    HStack {
                        Text(item.authorDetails?.name ?? item.author ?? "")
                        Text(item.yearText)
                            .foregroundColor(Color.secondary)
                        
                    }
                    Text(item.content ?? "")
                        .lineLimit(4)
                        .foregroundColor(Color.secondary)
                        .padding(4)
                }
                Spacer()
            }
            .padding()
        }
    }
}


//struct MovieReviewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieReviewsView()
//    }
//}
