//
//  TabsContentView.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import SwiftUI

struct TabsContentView:View{
    var body: some View{
        TabView {
            NavigationView{
                HomeMoviesView()
                    .navigationTitle("Movies APP")
            }
            .tabItem {
                VStack {
                    Image(systemName: "tv")
                    Text("Movies")
                }
            }
            .tag(0)
            
            
            NavigationView{
                MovieSearchView()
                    .navigationTitle("Search Movies")
            }
            .tabItem {
                VStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            }
            .tag(1)
            
            
            NavigationView{
                Text("Book Mark tab")
            }
            .tabItem {
                VStack {
                    Image(systemName: "magnifyingglass")
                    Text("BookMark")
                }
                
                .tag(1)
            }
        }
    }
}

struct TabsContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabsContentView()
    }
}
