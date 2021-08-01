//
//  GameModel.swift
//  OurGames
//
//  Created by Dans Multipro on 10/07/21.
//
import Foundation

struct Game: Codable {
  let id: Int
  let name: String
  let released: String?
  let backgroundImage: String?
  let rating: Double?
  let ratingsCount: Int?
  let website: String?
  let description: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case released
    case backgroundImage = "background_image"
    case rating
    case ratingsCount = "ratings_count"
    case website
    case description = "description_raw"
  }
}

struct GameList: Codable {
  let results: [Game]
}
