//
//  GameDetailView.swift
//  OurGames
//
//  Created by Dans Multipro on 11/07/21.
//

import SwiftUI
import URLImage

struct GameDetailView: View {
  @ObservedObject var gameViewModel = GamesViewModel()
  var id: Int
  
  var body: some View {
    ScrollView {
      if gameViewModel.isLoading {
        ProgressView()
          .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      } else {
        if ((gameViewModel.gameDetail?.background_image) != nil) {
          URLImage(URL(string: gameViewModel.gameDetail?.background_image ?? "")!) {
            EmptyView()
          } inProgress: { _ in
            Color.gray
            .frame(maxWidth: .infinity)
            .frame(height: 200)
          } failure: { _, _ in
            Color.gray
            .frame(maxWidth: .infinity)
            .frame(height: 200)
          } content: { image in
            image
              .resizable()
              .frame(maxWidth: .infinity)
              .frame(height: 200)
              .aspectRatio(contentMode: .fit)
          }
        }
        Text(gameViewModel.gameDetail?.name ?? "-")
          .font(.title)
          .padding(5)
        
        VStack(alignment: .leading) {
          Text("Release Date")
            .font(.system(size: 14))
            .foregroundColor(.gray)
            .padding(.bottom, 1)
          Text(gameViewModel.gameDetail?.released ?? "-")
            .padding(.bottom, 15)
          
          Text("Rating")
            .font(.system(size: 14))
            .foregroundColor(.gray)
            .padding(.bottom, 1)
          Text("\(String(gameViewModel.gameDetail?.rating ?? 0)) (\(gameViewModel.gameDetail?.ratings_count ?? 0))")
            .padding(.bottom, 15)
          
          Text("Website")
            .font(.system(size: 14))
            .foregroundColor(.gray)
            .padding(.bottom, 1)
          Text(gameViewModel.gameDetail?.website ?? "-")
            .foregroundColor(.blue)
            .padding(.bottom, 15)
          
          Text("Description")
            .font(.system(size: 14))
            .foregroundColor(.gray)
            .padding(.bottom, 1)
          Text(gameViewModel.gameDetail?.description_raw ?? "-")
            .padding(.bottom, 15)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
      }
    }
    .navigationBarTitle("Game Detail", displayMode: .inline)
    .onAppear {
      self.gameViewModel.getGameDetail(id: id)
    }
  }
}
