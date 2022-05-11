//
//  MoviesAppApp.swift
//  Shared
//
//  Created by Ahmed Ragab on 08/05/2022.
//

import SwiftUI

@main
struct MoviesAppApp: App {
    @StateObject var movieBookmarkViewModel = MovieBookmarkViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(movieBookmarkViewModel)
        }
    }
}
