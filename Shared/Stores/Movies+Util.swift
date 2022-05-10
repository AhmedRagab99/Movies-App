//
//  MovieService.swift
//
//  Created by Ahmed Ragab on 08/05/2022.
//

import Foundation


enum MoviesAppError:Error,CustomNSError{
    case apiError
    case invalidEndPoints
    case invalidResponse
    case noData
    case serializationError
    case geniricError
    
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
        case .geniricError:
            return "some thing went wrong"
        }
    }
    var errorUserInfo: [String : Any]{
        [NSLocalizedDescriptionKey:localizedDescriptipn]
    }
}
