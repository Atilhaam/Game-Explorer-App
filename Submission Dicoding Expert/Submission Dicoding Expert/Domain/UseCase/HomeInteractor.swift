//
//  HomeInteractor.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    
    func getGames() -> Observable<[GameModel]>
    
}

class HomeInteractor: HomeUseCase {
    
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGames() -> Observable<[GameModel]> {
        return repository.getGames()
    }
    
    
}
