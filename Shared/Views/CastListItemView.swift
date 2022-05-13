//
//  CastListItemView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 14/05/2022.
//

import SwiftUI

struct CastListItemView: View {

    let cast:[Cast]
    var body: some View {
        
        
        LazyVGrid(columns: UIDevice.current.userInterfaceIdiom != .pad ?
                  [GridItem(.adaptive(minimum: 120, maximum: 260))]: [GridItem(.adaptive(minimum: 200, maximum: 360))],spacing: 10){
            ForEach(cast) { item in
                VStack(alignment:.center){
                AsyncImageView(imageUrl: item.ProfilePathUrl)
                        .scaledToFill()
                    .clipShape(Circle())
                    
                    
                    Text(item.name ?? item.originalName ?? "")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                }
                
            }
        }
        
    }
}


//struct CastListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        CastListItemView()
//    }
//}
