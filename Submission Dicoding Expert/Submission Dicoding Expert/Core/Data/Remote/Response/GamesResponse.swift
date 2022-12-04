//
//  GamesResponse.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 22/10/22.
//

import Foundation

struct GamesResponse: Decodable {
    let games: [GameResponse]
    
    enum CodingKeys: String, CodingKey {
        case games = "results"
    }
}

struct GameResponse: Decodable {
    let id: Int
    let name: String
    let backgroundImage: String
    let rating: Double
    let ratingTop: Double
    let metacritic: Int
    let released: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case metacritic
        case released
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try container.decode(String.self, forKey: .released)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)!
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        backgroundImage = try container.decode(String.self, forKey: .backgroundImage)
        rating = try container.decode(Double.self, forKey: .rating)
        ratingTop = try container.decode(Double.self, forKey: .ratingTop)
        metacritic = try container.decode(Int.self, forKey: .metacritic)
        released = date
    }
}
