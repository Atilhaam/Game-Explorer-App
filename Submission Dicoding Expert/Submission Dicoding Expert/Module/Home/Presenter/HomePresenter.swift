//
//  HomePresenter.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//

import Foundation
import RxSwift

class HomePresenter: ObservableObject {
    private let homeUseCase: HomeUseCase
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getGames() -> Observable<[GameModel]> {
        return homeUseCase.getGames()
    }
}
