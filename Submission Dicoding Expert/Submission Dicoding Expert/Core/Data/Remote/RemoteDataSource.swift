//
//  RemoteDataSource.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 22/10/22.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol: class {
    func getGames() -> Observable<[GameResponse]>
    
    func getGameDetailInfo(id: String) -> Observable<GameDetailResponse> 
}

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getGames() -> Observable<[GameResponse]> {
        return Observable<[GameResponse]>.create { observer in
            if let url = URL(string: Endpoints.Gets.games.url) {
                print(url)
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            print("berhasil")
                            observer.onNext(value.games)
                            print(value.games)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                            print("error di alamofire")
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    func getGameDetailInfo(id: String) -> Observable<GameDetailResponse> {
        API.idGame = id
        return Observable<GameDetailResponse>.create { observer in
            if let url = URL(string: Endpoints.Gets.detail.url) {
                print(url)
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GameDetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            print("berhasil")
                            observer.onNext(value)
                            print(value.description)
                            print(value.genres)
                            print(value.platforms)
                            print(value.developers)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                            print("error di alamofire")
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    
}
