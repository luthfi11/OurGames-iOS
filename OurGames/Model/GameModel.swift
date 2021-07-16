//
//  GameModel.swift
//  OurGames
//
//  Created by Dans Multipro on 10/07/21.
//

import Foundation

struct Game: Codable {
  var id: Int
  var name: String
  var released: String?
  var background_image: String?
  var rating: Double?
  var ratings_count: Int?
  var website: String?
  var description_raw: String?
}

struct GameList: Codable {
  var results: [Game]
}
