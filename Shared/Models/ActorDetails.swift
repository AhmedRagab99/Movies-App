//
//  ActorDetails.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 13/05/2022.
//

import Foundation

// MARK: - ActorModel
struct ActorModel: Codable {
    let id: Int?
    let cast: [Cast]?
}

// MARK: - Cast
struct Cast: Codable,Identifiable {
    let  id: Int?
    let knownForDepartment, name, originalName: String?
    let profilePath: String?
    
    public var ProfilePathUrl: URL {
        
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")") ?? URL(string: "https://www.pexels.com/photo/person-holding-photo-of-single-tree-at-daytime-1252983/")!
    }
}
