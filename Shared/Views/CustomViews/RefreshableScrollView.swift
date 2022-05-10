//
//  RefreshableScrollView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import SwiftUI

struct RefreshableScrollView<Content:View>:View {
    var content:Content
    var onRefresh:()->()
    
    init(title:String,tintColor:Color,@ViewBuilder content:@escaping ()->Content,onRefresh:@escaping()->()) {
        self.content = content()
        self.onRefresh = onRefresh
        UIRefreshControl.appearance().attributedTitle = NSAttributedString(string: title)
        UIRefreshControl.appearance().tintColor = UIColor(tintColor)
        
    }
    var body: some View{
        List{
            content
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
        }
        .listStyle(.plain)
        .refreshable {
            onRefresh()
        }
    }
}
