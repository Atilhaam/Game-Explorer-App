//
//  LocaleDataSource.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocaleDataSourceProtocol: class {
    
    func getGames() -> Observable<[GameEntity]>
    func addGames(from games: [GameEntity]) -> Observable<Bool>
    func getFavoriteGames() -> Observable<[GameFavoriteEntity]>
    func getGameFavoriteInfo(from game: GameModel) -> Observable<GameFavoriteEntity>
    func checkFavorite(id: String) -> Observable<Bool>
    func addGameToFavorite(from game: GameFavoriteEntity) -> Observable<Bool>
    func removeGameFromFavorite(id: String) -> Observable<Bool>
    func getProfileInfo() -> Observable<ProfileModel> 
    
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func getGames() -> Observable<[GameEntity]> {
        return Observable<[GameEntity]>.create { observer in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                observer.onNext(games.toArray(ofType: GameEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addGames(from games: [GameEntity]) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for game in games {
                            realm.add(game, update: .all)
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getFavoriteGames() -> Observable<[GameFavoriteEntity]> {
        return Observable<[GameFavoriteEntity]>.create { observer in
            if let realm = self.realm {
                let games: Results<GameFavoriteEntity> = {
                    realm.objects(GameFavoriteEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                observer.onNext(games.toArray(ofType: GameFavoriteEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getGameFavoriteInfo(from game: GameModel) -> Observable<GameFavoriteEntity> {
        return Observable<GameFavoriteEntity>.create { observer in
            let newFavGame = GameFavoriteEntity()
            newFavGame.id = game.id
            newFavGame.name = game.name
            newFavGame.backgroundImage = game.backgroundImage
            newFavGame.rating = game.rating
            newFavGame.ratingTop = game.ratingTop
            newFavGame.metacritic = game.metacritic
            newFavGame.released = game.released
            observer.onNext(newFavGame)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func checkFavorite(id: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
               let object = realm.object(ofType: GameFavoriteEntity.self, forPrimaryKey: id)
                if object != nil {
                    observer.onNext(true)
                    observer.onCompleted()
                } else {
                    observer.onNext(false)
                    observer.onCompleted()
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addGameToFavorite(from game: GameFavoriteEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(game, update: .all)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    
    
    func removeGameFromFavorite(id: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                if let game = realm.object(ofType: GameFavoriteEntity.self, forPrimaryKey: id) {
                    do {
                        try realm.write {
                            realm.delete(game)
                            observer.onNext(true)
                            observer.onCompleted()
                        }
                    } catch {
                        observer.onError(DatabaseError.requestFailed)
                    }
                } else {
                    observer.onError(DatabaseError.requestFailed)
                }
                
            } else {
                observer.onError(DatabaseError.requestFailed)
            }
            return Disposables.create()
        }
    }
    
    func getProfileInfo() -> Observable<ProfileModel> {
        return Observable<ProfileModel>.create { observer in
            let profile = ProfileModel(image: "profileImage",
                                       name: "Ilham Akbar Taufik Kurnia Wibowo",
                                       about: "Computer Science Graduate. I Have experience in Mobile Application Development, both in native Android and iOS. Experienced in working on iOS and Android platform and frameworks and customizing it as per requirements. I also have strong experience in Agile development methodology. I love to learn new things, and always try to do better and improve as a person.",
                                       email: "ilham.wayne@gmail.com",
                                       phoneNumber: "082233804087")
            observer.onNext(profile)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0..<count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}

