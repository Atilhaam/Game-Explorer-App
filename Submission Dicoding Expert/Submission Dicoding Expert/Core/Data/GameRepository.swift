//
//  GameRepository.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//

import Foundation
import RxSwift

protocol GameRepositoryProtocol {
    
    func getGames() -> Observable<[GameModel]>
    
    func getFavoriteGames() -> Observable<[GameFavoriteModel]>
    
}

final class GameRepository: NSObject {
    
    typealias GameInstance = (LocaleDataSource, RemoteDataSource) -> GameRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: GameInstance = { localeRepo, remoteRepo in
        return GameRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension GameRepository: GameRepositoryProtocol {
    func getGames() -> Observable<[GameModel]> {
        return self.locale.getGames()
            .map { GameMapper.mapGameEntitiesToDomains(input: $0)}
            .filter{ !$0.isEmpty }
            .ifEmpty(switchTo: self.remote.getGames()
                .map { GameMapper.mapGameResponsesToEntities(input: $0)}
                .flatMap { self.locale.addGames(from: $0)}
                .filter {$0}
                .flatMap { _ in self.locale.getGames()
                        .map { GameMapper.mapGameEntitiesToDomains(input: $0)}
                }
            )
    }
        
    func getFavoriteGames() -> Observable<[GameFavoriteModel]> {
        return self.locale.getFavoriteGames()
            .map { GameMapper.mapGameFavoriteEntitiesToDomains(input: $0) }
    }
    
    
    
}
