//
//  DetailPresenter.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//
import Foundation
import RxSwift

class DetailPresenter: ObservableObject {
    private let detailUseCase: DetailUseCase

    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getDetailGames(id: String) -> Observable<GameDetailModel> {
        return detailUseCase.getDetailGame(id: id)
    }
    
    
    
    func addGameToFavorite(game: GameModel) -> Observable<Bool> {
        return detailUseCase.addGameToFavorite(game: game)
    }
    
    func checkFavorite(id: String) -> Observable<Bool> {
        return detailUseCase.checkFavorite(id: id)
    }
    
    func removeGameFromFavorite(id: String) -> Observable<Bool> {
        return detailUseCase.removeGameFromFavorite(id: id)
    }
    
    
}
