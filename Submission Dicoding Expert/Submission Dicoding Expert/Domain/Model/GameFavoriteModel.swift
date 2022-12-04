//
//  GameFavoriteModel.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 05/11/22.
//

import Foundation

struct GameFavoriteModel: Equatable, Identifiable {
    let id: String
    let name: String
    let backgroundImage: String
    let rating: String
    let ratingTop: String
    let metacritic: String
    let released: String
}
