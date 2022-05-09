//
//  Utils.swift
//  MoviesApp 
//
//  Created by Ahmed Ragab on 08/05/2022.
//

import Foundation


class Utils {
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
    
    static let BaseApiUrl = "https://api.themoviedb.org/3"
}


enum MovieThumbnailType {
    case poster(showTitle: Bool = true)
    case backdrop
}
