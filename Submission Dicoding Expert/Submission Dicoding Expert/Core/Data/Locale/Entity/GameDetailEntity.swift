//
//  GameDetailEntity.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//

import Foundation
import RealmSwift

class GameDetailEntity: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var genres: String = ""
    @objc dynamic var platforms: String = ""
    @objc dynamic var developers: String = ""
    @objc dynamic var publisher: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
