//
//  MyTabBarViewController.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 22/10/22.
//

import UIKit

class MyTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeUseCase = Injection.init().provideHome()
        let homePresenter = HomePresenter(homeUseCase: homeUseCase)
        let favoriteUseCase = Injection.init().provideFavorite()
        let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
        let profileUseCase = Injection.init().provideProfile()
        let profilePresenter = ProfilePresenter(profileUseCase: profileUseCase)
        
        let firstViewController = UINavigationController(rootViewController: HomeViewController(presenter: homePresenter))
        
        let secondViewController = UINavigationController(rootViewController: FavoriteViewController(presenter: favoritePresenter))
        
        let thirdViewController = UINavigationController(rootViewController: ProfileViewController(presenter: profilePresenter))
        
        firstViewController.tabBarItem = UITabBarItem(title: "Home", image: .actions, tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: "Favorite", image: .actions, tag: 2)
        thirdViewController.tabBarItem = UITabBarItem(title: "Profile", image: .actions, tag: 3)
        
        
        
        viewControllers = [firstViewController,secondViewController,thirdViewController]
        // Do any additional setup after loading the view.
    }

}
