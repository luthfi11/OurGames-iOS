//
//  ContentView.swift
//  OurGames
//
//  Created by Dans Multipro on 10/07/21.
//

import SwiftUI

struct ContentView: View {
  let persistenceController: PersistenceController

  var body: some View {
    TabView {
      ListGameView(persistenceController: persistenceController)
        .tabItem {
          Label("Home", systemImage: "house.fill")
        }
      SearchGameView(persistenceController: persistenceController)
        .tabItem {
          Label("Search", systemImage: "magnifyingglass")
        }
      FavoriteView(persistenceController: persistenceController)
        .tabItem {
          Label("Favorite", systemImage: "star")
        }
      AboutView()
        .tabItem {
          Label("About", systemImage: "person.crop.circle")
        }
    }
    .accentColor(.red)
    .onAppear {
      UITabBar.appearance().barTintColor = .white
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(persistenceController: PersistenceController())
  }
}
