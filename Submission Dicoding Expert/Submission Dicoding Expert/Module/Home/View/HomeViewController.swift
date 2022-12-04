//
//  HomeViewController.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 22/10/22.
//

import UIKit
import SDWebImage
import RxSwift

class HomeViewController: UIViewController {
    var games: [GameModel] = []
    private let disposeBag = DisposeBag()
    let presenter: HomePresenter
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let router = HomeRouter()
    
    init(presenter: HomePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        self.presenter.getGames()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.games = result
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                self.collectionView.reloadData()
            }.disposed(by: disposeBag)
    }
    
    private func setUpCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let gameModel = self.games[indexPath.row]
        let id = self.games[indexPath.row].id
        router.moveToDetail(navigationController: navigationController, id: id, gameModel: gameModel)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.identifier, for: indexPath) as? GameCollectionViewCell {
            let game = self.games[indexPath.row]
            let dateFormatter = DateFormatter()
            let ratingText = "\(game.rating) / 5"
            dateFormatter.dateFormat = "YYY"
            cell.coverImage.sd_imageIndicator = SDWebImageActivityIndicator.white
            cell.coverImage.sd_setImage(with: URL(string: game.backgroundImage))
            cell.gameTitle.text = game.name
            cell.releaseDateContent.text = game.released
            cell.ratingContent.text = ratingText
            return cell
        } else {
            print("kosong")
            return UICollectionViewCell()
        }
    }
     
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: 250)
    }
    
}
