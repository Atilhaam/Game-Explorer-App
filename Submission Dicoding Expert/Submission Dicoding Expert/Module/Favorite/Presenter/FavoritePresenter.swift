//
//  FavoritePresenter.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 05/11/22.
//

import Foundation
import RxSwift

class FavoritePresenter: ObservableObject {
    private let favoriteUseCase: FavoriteUseCase
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    func getFavoritGames() -> Observable<[GameFavoriteModel]> {
        return favoriteUseCase.getFavoriteGames()
    }
}
