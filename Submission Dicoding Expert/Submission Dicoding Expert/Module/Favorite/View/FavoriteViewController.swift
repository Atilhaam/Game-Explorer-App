//
//  FavortieViewController.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 22/10/22.
//

import UIKit
import RxSwift
import SDWebImage

class FavoriteViewController: UIViewController {
    
    var favGames: [GameFavoriteModel] = []
    private let disposeBag = DisposeBag()
    let presenter: FavoritePresenter
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        return tableView
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.layer.cornerRadius = 30
        let image = UIImage(systemName: "heart",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let router = FavoriteRouter()
    
    init(presenter: FavoritePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Favorite"
        self.presenter.getFavoritGames()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.favGames = result
            } onError: {  error in
                print(error.localizedDescription)
            } onCompleted: {
                self.tableView.reloadData()
            }.disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.rowHeight = 150
        tableView.dataSource = self
        tableView.delegate = self
    }

}
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as? FavoriteTableViewCell {
            let game = self.favGames[indexPath.row]
            let dateFormatter = DateFormatter()
            let ratingText = "\(game.rating) / 5"
            dateFormatter.dateFormat = "YYY"
            cell.imagePoster.sd_setImage(with: URL(string: game.backgroundImage))
            cell.gameTitle.text = game.name
            cell.releaseDateContent.text = game.released
            cell.ratingContent.text = ratingText
            return cell
        } else {
            print("Data empty")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.favGames.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let gameFavModel = self.favGames[indexPath.row]
        let id = self.favGames[indexPath.row].id
        router.moveToDetail(navigationController: navigationController, id: id, gameFavModel: gameFavModel)
    }
}
