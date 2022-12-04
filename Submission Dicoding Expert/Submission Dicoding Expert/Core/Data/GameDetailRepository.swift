//
//  GameDetailRepository.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//

import Foundation
import RxSwift

protocol GameDetailRepositoryProtocol {
    
    func getDetailGame(id: String) -> Observable<GameDetailModel>
    
    func addGameToFavorite(game: GameModel) -> Observable<Bool>
    
    func checkFavorite(id: String) -> Observable<Bool>
    
    func removeGameFromFavorite(id: String) -> Observable<Bool>

    
}

final class GameDetailRepository: NSObject {
    typealias GameInstance = (LocaleDataSource, RemoteDataSource) -> GameDetailRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: GameInstance = { localeRepo, remoteRepo in
        return GameDetailRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension GameDetailRepository: GameDetailRepositoryProtocol {
    
    func getDetailGame(id: String) -> Observable<GameDetailModel> {
        return self.remote.getGameDetailInfo(id: id)
            .map { GameMapper.mapGameDetailResponseToDomains(input: $0)}
    }
    
    func addGameToFavorite(game: GameModel) -> Observable<Bool> {
        return self.locale.getGameFavoriteInfo(from: game)
            .flatMap { self.locale.addGameToFavorite(from: $0)}
    }
    
    func checkFavorite(id: String) -> Observable<Bool> {
        return self.locale.checkFavorite(id: id)
    }
    
    func removeGameFromFavorite(id: String) -> Observable<Bool> {
        return self.locale.removeGameFromFavorite(id: id)
    }
    
}
