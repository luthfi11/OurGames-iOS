//
//  NetworkManager.swift
//  OurGames
//
//  Created by Dans Multipro on 10/07/21.
//

import Combine
import SwiftUI
import Foundation

class GamesViewModel: ObservableObject {
  @Published var gameList = GameList(results: [])
  @Published var gameDetail: Game?
  @Published var isLoading = false
  
  private let baseUrl = "https://api.rawg.io/api/games"
  private let apiKey = "6a1e290af01a45ad940d0798912f7cd5"
  private let pageSize = "20"
  
  func getGames(query: String) {
    self.isLoading = true
    var components = URLComponents(string: baseUrl)!
    components.queryItems = [
      URLQueryItem(name: "key", value: apiKey),
      URLQueryItem(name: "page_size", value: pageSize),
      URLQueryItem(name: "search", value: query)
    ]
    
    let request = URLRequest(url: components.url!)
    let task = URLSession.shared.dataTask(with: request) { (data, _, _) in
      guard let data = data else { return }
      let games = try! JSONDecoder().decode(GameList.self, from: data)
      DispatchQueue.main.async {
        self.gameList = games
        self.isLoading = false
      }
    }
    task.resume()
  }
  
  func getGameDetail(id: Int) {
    self.isLoading = true
    let idPath = "/\(id)"
    var components = URLComponents(string: baseUrl + idPath)!
    components.queryItems = [
      URLQueryItem(name: "key", value: apiKey)
    ]
    
    let request = URLRequest(url: components.url!)
    let task = URLSession.shared.dataTask(with: request) { (data, _, _) in
      guard let data = data else { return }
      let game = try! JSONDecoder().decode(Game.self, from: data)
      DispatchQueue.main.async {
        self.gameDetail = game
        self.isLoading = false
      }
    }
    task.resume()
  }
}
