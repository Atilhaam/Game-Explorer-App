//
//  GameDetailModel.swift
//  Submission Dicoding Expert
//
//  Created by Ilham Wibowo on 23/10/22.
//

import Foundation

struct GameDetailModel: Equatable, Identifiable {
    let id: String
    let name: String
    let desc: String
    let genres: String
    let platforms: String
    let developers: String
    let publisher: String
}
