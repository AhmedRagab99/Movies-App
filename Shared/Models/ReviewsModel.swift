//
//  ReviewsModel.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 13/05/2022.
//

import Foundation
// MARK: - ReviewsModel
struct ReviewsModel: Codable {
    let id, page: Int?
    let results: [ReviewsModelResult]?
}

// MARK: - Result
struct ReviewsModelResult: Codable ,Identifiable{
    let author: String?
    let authorDetails: AuthorDetails?
    let content, createdAt, id, updatedAt: String?
    let url: String?
    
    
    var yearText: String {
        guard let releaseDate = self.updatedAt else  {
            print("updated date",self.updatedAt)
            return "n/a"
        }
        return Utils.dateFormatter.date(from: releaseDate)?.description ?? ""
    }
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
   
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    let name, username: String?
    let avatarPath: String?
    let rating: Int?

    var avatarPathURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(avatarPath ?? "")")!
    }
    
    
}
