//
//  MenuItem.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import Foundation
enum MenuItem: CaseIterable {
    case search
    case saved
    case category(MovieListEndPoints)
    
    var text: String {
        switch self {
        case .search:
            return "Search"
        case .saved:
            return "Saved"
        case .category(let category):
            return category.description
        }
    }
    
    var systemImage: String {
        switch self {
        case .search:
            return "magnifyingglass"
        case .saved:
            return "bookmark"
        case .category(let category):
            return category.systemImage
        }
    }
    
    static var allCases: [MenuItem] {
        return [.search, .saved] + MovieListEndPoints.menuItems
    }
    
}

extension MenuItem: Identifiable {
    
    var id: String {
        switch self {
        case .search:
            return "search"
        case .saved:
            return "saved"
        case .category(let category):
            return category.rawValue
        }
    }
    
    init?(id: MenuItem.ID?) {
        switch id {
        case MenuItem.search.id:
            self = .search
        case MenuItem.saved.id:
            self = .saved
        default:
            if let id = id, let category = MovieListEndPoints(rawValue: id) {
                self = .category(category)
            } else {
                return nil
            }
        }
    }
    
}

extension MovieListEndPoints {
    static var menuItems: [MenuItem] {
        allCases.map { .category($0) }
    }
}
