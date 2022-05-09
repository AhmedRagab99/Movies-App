//
//  Movie.swift
//  MoviesApp (iOS)
//
//  Created by Ahmed Ragab on 08/05/2022.
//

import Foundation

struct MovieResponse:Codable{
    let results:[Movie]
}

struct Movie: Codable, Identifiable, Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int?
    let title: String?
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let releaseDate: String?

    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
   
    
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
//    var cast: [MovieCast]? {
//        credits?.cast
//    }
//
//    var crew: [MovieCrew]? {
//        credits?.crew
//    }
//
//    var directors: [MovieCrew]? {
//        crew?.filter { $0.job.lowercased() == "director" }
//    }
//
//    var producers: [MovieCrew]? {
//        crew?.filter { $0.job.lowercased() == "producer" }
//    }
//
//    var screenWriters: [MovieCrew]? {
//        crew?.filter { $0.job.lowercased() == "story" }
//    }
//
//    var youtubeTrailers: [MovieVideo]? {
//        videos?.results.filter { $0.youtubeURL != nil }
//    }
    
}




// for using data in preview

extension Movie {
    
    static var stubbedMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "Movie-list")
        return response!.results
    }
    
    static var stubbedMovie: Movie {
        stubbedMovies[0]
    }
    
}


struct MovieSection: Identifiable {
    
    let id = UUID()
    
    let movies: [Movie]
    let endpoint: MovieListEndPoints
    var title: String {
        endpoint.description
    }

}

extension MovieSection {
    
    static var stubs: [MovieSection] {
        
        let stubbedMovies = Movie.stubbedMovies
        return MovieListEndPoints.allCases.map {
            MovieSection(movies: stubbedMovies.shuffled(), endpoint: $0)
        }
    }
    
}
