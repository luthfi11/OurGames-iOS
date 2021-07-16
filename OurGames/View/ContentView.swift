//
//  ContentView.swift
//  OurGames
//
//  Created by Dans Multipro on 10/07/21.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      ListGameView()
        .tabItem {
          Label("Home", systemImage: "house.fill")
        }
      SearchGameView()
        .tabItem {
          Label("Search", systemImage: "magnifyingglass")
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
    ContentView()
  }
}
