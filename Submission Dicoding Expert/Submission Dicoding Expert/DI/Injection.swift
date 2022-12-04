//
//  Injection.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    private func provideRepository() -> GameRepositoryProtocol {
        let realm = try? Realm()
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return GameRepository.sharedInstance(locale,remote)
    }
    
    private func provideDetailRepository() -> GameDetailRepositoryProtocol {
        let realm = try? Realm()
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return GameDetailRepository.sharedInstance(locale, remote)
        
    }
    
    private func profideProfileRepository() -> ProfileRepositoryProtocol {
        let realm = try? Realm()
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        return ProfileRepository.sharedInstance(locale)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
    
    func provideDetail() -> DetailUseCase {
        let repository = provideDetailRepository()
        return DetailInteractor(repository: repository)
    }
    
    func provideProfile() -> ProfileUseCase {
        let repository = profideProfileRepository()
        return ProfileInteractor(repository: repository)
    }
    
    
}
