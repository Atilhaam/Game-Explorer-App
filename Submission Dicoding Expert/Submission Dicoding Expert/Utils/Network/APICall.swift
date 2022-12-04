//
//  APICall.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 22/10/22.
//

import Foundation

struct API {
    
    static let baseUrlGames = "https://api.rawg.io/api/games"
    static let baseUrlCreator = "https://api.rawg.io/api/creators"
    static var idGame = ""
    
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    enum Gets: Endpoint {
        case games
        case creator
        case detail
        
        public var url: String {
            switch self {
            case .games: return "\(API.baseUrlGames)?page_size=30&key=fec28c04ac1b4d7da35bf4d9802e4d36"
            case .creator: return "\(API.baseUrlCreator)?key=fec28c04ac1b4d7da35bf4d9802e4d36"
            case .detail: return
                "\(API.baseUrlGames)/\(API.idGame)?key=fec28c04ac1b4d7da35bf4d9802e4d36"
            }
        }
    }
    
}
