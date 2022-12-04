//
//  DetailInteractor.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    
    func getDetailGame(id: String) -> Observable<GameDetailModel>
    
    func addGameToFavorite(game: GameModel) -> Observable<Bool>

    func checkFavorite(id: String) -> Observable<Bool>
    
    func removeGameFromFavorite(id: String) -> Observable<Bool>


    
}

class DetailInteractor: DetailUseCase {
    
    private let repository: GameDetailRepositoryProtocol
    
    required init(repository: GameDetailRepositoryProtocol) {
        self.repository = repository
    }
    

    func addGameToFavorite(game: GameModel) -> Observable<Bool> {
        return repository.addGameToFavorite(game: game)
    }
    
    func getDetailGame(id: String) -> Observable<GameDetailModel> {
        return repository.getDetailGame(id: id)
    }
    
    func checkFavorite(id: String) -> Observable<Bool> {
        return repository.checkFavorite(id: id)
    }
    
    func removeGameFromFavorite(id: String) -> Observable<Bool> {
        return repository.removeGameFromFavorite(id: id)
    }
}
