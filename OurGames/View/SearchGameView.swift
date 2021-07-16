//
//  SearchGameView.swift
//  OurGames
//
//  Created by Dans Multipro on 10/07/21.
//

import SwiftUI

struct SearchGameView: View {
  @State private var query = ""
  @ObservedObject var gameViewModel = GamesViewModel()
  
  var body: some View {
    NavigationView {
      ScrollView {
        TextField("Search here...", text: $query)
          .onChange(of: query) { newQuery in
            self.gameViewModel.getGames(query: newQuery)
          }
          .padding(15)
          .background(Color(.systemGray6))
          .cornerRadius(8)
          .padding(10)
        if gameViewModel.isLoading {
          ProgressView()
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        } else {
          ForEach(gameViewModel.gameList.results, id: \.id) { game in
            NavigationLink(destination: GameDetailView(id: game.id)) {
              GameRow(game: game)
            }
          }
        }
      }
      .navigationBarTitle("Search", displayMode: .inline)
    }
  }
}

struct SearchGameView_Previews: PreviewProvider {
  static var previews: some View {
    SearchGameView()
  }
}
