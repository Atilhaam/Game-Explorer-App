//
//  FavoriteRouter.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 06/11/22.
//

import Foundation
import UIKit

class FavoriteRouter {
    func moveToDetail(navigationController: UINavigationController?, id: String, gameFavModel: GameFavoriteModel) {
        let detailUseCase = Injection.init().provideDetail()
        let detailPresenter = DetailPresenter(detailUseCase: detailUseCase)
        let detailVC = DetailGameViewController(presenter: detailPresenter)
        detailVC.id = id
        detailVC.game = GameModel(id: gameFavModel.id,
                                  name: gameFavModel.name,
                                  backgroundImage: gameFavModel.backgroundImage,
                                  rating: gameFavModel.rating,
                                  ratingTop: gameFavModel.ratingTop,
                                  metacritic: gameFavModel.metacritic,
                                  released: gameFavModel.released)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
