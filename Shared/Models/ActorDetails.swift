//
//  ActorDetails.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 13/05/2022.
//

import Foundation

struct ActorDetail: Codable,Identifiable {
   
       let birthday, knownForDepartment: String?
       let id: Int?
       let name: String?
       let gender: Int?
       let biography: String?
       let popularity: Double?
       let placeOfBirth, profilePath: String?

       
       public var ProfilePathUrl: URL {
           return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")") ?? URL(string: "https://www.pexels.com/photo/person-holding-photo-of-single-tree-at-daytime-1252983/")!
       }
       
//       enum CodingKeys: String, CodingKey {
//           case birthday
//           case knownForDepartment = "known_for_department"
//           case id, name, gender, biography, popularity
//           case placeOfBirth = "place_of_birth"
//           case profilePath = "profile_path"
//       }
   }
