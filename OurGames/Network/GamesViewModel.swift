//
//  NetworkManager.swift
//  OurGames
//
//  Created by Dans Multipro on 10/07/21.
//

import Combine
import SwiftUI
import Foundation

class NetworkManager: ObservableObject {
  @Published var games = GameList(games: [])

  private let baseUrl = "https://api.rawg.io/api/games"
  private let apiKey = "6a1e290af01a45ad940d0798912f7cd5"
  private let pageSize = "20"

  func getGames() {
    var components = URLComponents(string: baseUrl)!
    components.queryItems = [
        URLQueryItem(name: "api_key", value: apiKey),
        URLQueryItem(name: "page_size", value: pageSize)
    ]

    let request = URLRequest(url: components.url!)
    let task = URLSession.shared.dataTask(with: request) { (data, _, _) in
      guard let data = data else { return }
      let games = try! JSONDecoder().decode(GameList.self, from: data)
      DispatchQueue.main.async {
        self.games = games
      }
    }
    task.resume()
  }
}
