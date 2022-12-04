//
//  FavoriteInteractor.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 05/11/22.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    
    func getFavoriteGames() -> Observable<[GameFavoriteModel]>
    
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoriteGames() -> Observable<[GameFavoriteModel]> {
        return repository.getFavoriteGames()
    }
}
