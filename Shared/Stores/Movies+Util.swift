//
//  MovieService.swift
//
//  Created by Ahmed Ragab on 08/05/2022.
//

import Foundation



enum MovieListEndPoints:String,CaseIterable,Identifiable{
    var id: String { rawValue }
    
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    case latest
    
    var description:String{
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .upcoming:
            return "Upcoming"
        case .topRated:
            return "Top Rated"
        case .popular:
            return "Popular"
        case .latest:
            return "Latest"
        }
    }
}

enum MoviesAppError:Error,CustomNSError{
    case apiError
    case invalidEndPoints
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescriptipn:String{
        switch self {
        case .apiError:
            return "Failed to fetch data"
        case .invalidEndPoints:
            return "Invalid endpoint"
        case .invalidResponse:
            return "Invalid response"
        case .noData:
            return "No data"
        case .serializationError:
            return "Failed to decode data"
        }
    }
    var errorUserInfo: [String : Any]{
        [NSLocalizedDescriptionKey:localizedDescriptipn]
    }
}
