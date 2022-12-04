//
//  ProfileViewController.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 22/10/22.
//

import UIKit
import RxSwift
import SDWebImage

class ProfileViewController: UIViewController {
    let presenter: ProfilePresenter
    var profile: ProfileModel? = nil
    private let disposeBag = DisposeBag()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(presenter: ProfilePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.getProfileInfo()
            .observe(on: MainScheduler.instance)
            .subscribe { profile in
                self.profile = profile
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                self.tableView.reloadData()
            }.disposed(by: disposeBag)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        setupView()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 700
        tableView.rowHeight = UITableView.automaticDimension
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
}
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as! ProfileTableViewCell
        guard let profile = self.profile else {
            return cell
        }
        if indexPath.row == 0 {
            cell.selectionStyle = .none
            cell.imagePoster.image = UIImage(named: "profileImage")
            cell.creatorLabel.text = profile.name
            cell.aboutContent.text = profile.about
            cell.emailContent.text = profile.email
            cell.phoneNumberContent.text = profile.phoneNumber
            return cell
        }
        return cell
    }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 650
    }
     
     
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
