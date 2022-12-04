//
//  GameFavoriteEntity.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 24/10/22.
//

import Foundation
import RealmSwift

class GameFavoriteEntity: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var rating: String = ""
    @objc dynamic var ratingTop: String = ""
    @objc dynamic var metacritic: String = ""
    @objc dynamic var released: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
