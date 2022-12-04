//
//  DetailGameResponse.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//

import Foundation
struct GameDetailResponse: Decodable {
    let id: Int
    let name: String
    let description: String
    let genres: [Genre]
    let platforms: [Platforms]
    let developers: [Developer]
    let publishers: [Publisher]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case genres
        case platforms
        case developers
        case publishers
    }
}

struct Platforms: Decodable {
    let platform: Platform
}

struct Platform: Decodable {
    let name: String
    
}

struct Genre: Decodable {
    let name: String
}

struct Developer: Decodable {
    let name: String
}

struct Publisher: Decodable {
    let name: String
}

