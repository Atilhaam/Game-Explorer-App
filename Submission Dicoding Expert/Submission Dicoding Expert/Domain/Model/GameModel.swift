//
//  GameModel.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//

import Foundation

struct GameModel: Equatable, Identifiable {
    let id: String
    let name: String
    let backgroundImage: String
    let rating: String
    let ratingTop: String
    let metacritic: String
    let released: String
}
