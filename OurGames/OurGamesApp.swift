//
//  OurGamesApp.swift
//  OurGames
//
//  Created by Dans Multipro on 10/07/21.
//

import SwiftUI

@main
struct OurGamesApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(persistenceController: PersistenceController())
    }
  }
}
