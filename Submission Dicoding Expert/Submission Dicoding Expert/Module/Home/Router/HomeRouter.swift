//
//  HomeRouter.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//

import Foundation
import UIKit

class HomeRouter {
    func moveToDetail(navigationController: UINavigationController?, id: String, gameModel: GameModel) {
        let detailUseCase = Injection.init().provideDetail()
        let detailPresenter = DetailPresenter(detailUseCase: detailUseCase)
        let detailVC = DetailGameViewController(presenter: detailPresenter)
        detailVC.id = id
        detailVC.game = gameModel
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

