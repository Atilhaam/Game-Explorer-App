//
//  GameMapper.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//

import Foundation

final class GameMapper {
    
    static func mapGameDetailResponseToDomains(input gameDetailResponses: GameDetailResponse) -> GameDetailModel {
        let platform = gameDetailResponses.platforms.map({ $0.platform}).map({ $0.name }).joined(separator: ", ")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return GameDetailModel(
            id: String(gameDetailResponses.id),
            name: gameDetailResponses.name,
            desc: gameDetailResponses.description,
            genres: gameDetailResponses.genres.map({ $0.name }).joined(separator: ", "),
            platforms: platform,
            developers: gameDetailResponses.developers.map({ $0.name }).joined(separator: ", "),
            publisher: gameDetailResponses.publishers.map({$0.name}).joined(separator: ", ")
        )
    }
    
    
    static func mapGameResponsesToEntities(input gameResponse: [GameResponse]) -> [GameEntity] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return gameResponse.map { result in
            let newGame = GameEntity()
            newGame.id = String(result.id)
            newGame.name = result.name
            newGame.backgroundImage = result.backgroundImage
            newGame.rating = String(result.rating)
            newGame.ratingTop = String(result.ratingTop)
            newGame.metacritic = String(result.metacritic)
            newGame.released = dateFormatter.string(from: result.released)
            return newGame
        }
    }
    
    static func mapGameResponseToFavoriteEntites(input gameResponse: GameResponse) -> GameFavoriteEntity {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newFavGame = GameFavoriteEntity()
        newFavGame.id = String(gameResponse.id)
        newFavGame.name = gameResponse.name
        newFavGame.backgroundImage = gameResponse.backgroundImage
        newFavGame.rating = String(gameResponse.rating)
        newFavGame.ratingTop = String(gameResponse.ratingTop)
        newFavGame.metacritic = String(gameResponse.metacritic)
        newFavGame.released = dateFormatter.string(from: gameResponse.released)
        return newFavGame
    }
    
    static func mapGameEntitiesToDomains(input gameEntities: [GameEntity]) -> [GameModel] {
        return gameEntities.map { result in
            return GameModel(
                id: result.id,
                name: result.name,
                backgroundImage: result.backgroundImage,
                rating: result.rating,
                ratingTop: result.ratingTop,
                metacritic: result.metacritic,
                released: result.released
            )
        }
    }
    
    static func mapGameFavoriteEntitiesToDomains(input gameFavoriteEntities: [GameFavoriteEntity]) -> [GameFavoriteModel] {
        return gameFavoriteEntities.map { result in
            return GameFavoriteModel(
                id: result.id,
                name: result.name,
                backgroundImage: result.backgroundImage,
                rating: result.rating,
                ratingTop: result.ratingTop,
                metacritic: result.metacritic,
                released: result.released
            )
        }
    }
}
