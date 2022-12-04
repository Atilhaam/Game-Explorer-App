//
//  DetailViewController.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//

import UIKit
import SDWebImage
import RxSwift

class DetailGameViewController: UIViewController {
    let presenter: DetailPresenter
    private let disposeBag = DisposeBag()
    var detailGame: GameDetailModel? = nil
    var game: GameModel? = nil
    var id: String = ""
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DetailGameTableViewCell.self, forCellReuseIdentifier: DetailGameTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
    
    init(presenter: DetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkFavorite()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.backgroundColor = .white
        favoriteButton.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
        self.presenter.getDetailGames(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.detailGame = result
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                self.tableView.reloadData()
            }.disposed(by: disposeBag)
        
        
    }
    
    func checkFavorite() {
        self.presenter.checkFavorite(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { favorite in
                if favorite {
                    DispatchQueue.main.async {
                        self.favoriteButton.backgroundColor = .red
                    }
                } else {
                    DispatchQueue.main.async {
                        self.favoriteButton.backgroundColor = .white

                    }
                }
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                print("tidak ada error")
            }.disposed(by: disposeBag)
    }
    
    @objc func addFavorite(sender: UIButton) {
        guard let game = self.game else {
            print("game kosong")
            return
        }
        if self.favoriteButton.backgroundColor == .white {
            self.presenter.addGameToFavorite(game: game)
                .observe(on: MainScheduler.instance)
                .subscribe { success in
                    if success {
                        DispatchQueue.main.async {
                            self.favoriteButton.backgroundColor = .red
                        }
                    } else {
                        print("Gagal")
                    }
                } onError: { error in
                    print(error.localizedDescription)
                } onCompleted: {
                    print("tidak ada error")
                }.disposed(by: disposeBag)

        } else {
            self.presenter.removeGameFromFavorite(id: String(id))
                .observe(on: MainScheduler.instance)
                .subscribe { success in
                    if success {
                        DispatchQueue.main.async {
                            self.favoriteButton.backgroundColor = .white
                        }
                    } else {
                        print("gagal")
                    }
                } onError: { error in
                    print(error.localizedDescription)
                } onCompleted: {
                    print("tidak ada error")
                }.disposed(by: disposeBag)
        }
        
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        view.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            favoriteButton.widthAnchor.constraint(equalToConstant: 60),
            favoriteButton.heightAnchor.constraint(equalToConstant: 60),
            favoriteButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension DetailGameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailGameTableViewCell.identifier) as! DetailGameTableViewCell
        guard let game = self.game, let detailGame = self.detailGame else {
            return cell
        }
        cell.titleLabel.text = detailGame.name
        cell.imagePoster.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imagePoster.sd_setImage(with: URL(string: game.backgroundImage))
        cell.aboutContent.text = detailGame.desc.html2String
        cell.platformsContent.text = detailGame.platforms
        cell.genreContent.text = detailGame.genres
        cell.publisherContent.text = detailGame.publisher
        cell.developerContent.text = detailGame.developers
        cell.metaCriticScoreContent.text = game.metacritic
        cell.releaseDateContent.text = game.released
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1700
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
