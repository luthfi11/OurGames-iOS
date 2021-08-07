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
  let persistenceController: PersistenceController
  var id: Int
  @State private var isDataExist = false
  @State private var showSuccessAlert = false
  @State private var successMessage = ""
  
  private func checkData() {
    isDataExist = persistenceController.checkGameExist(self.id)
  }
  
  var body: some View {
    ScrollView {
      if gameViewModel.isLoading {
        ProgressView()
          .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      } else {
        if gameViewModel.gameDetail?.backgroundImage != nil {
          URLImage(URL(string: gameViewModel.gameDetail?.backgroundImage ?? "")!) {
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
          Text("\(String(gameViewModel.gameDetail?.rating ?? 0)) (\(gameViewModel.gameDetail?.ratingsCount ?? 0))")
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
          Text(gameViewModel.gameDetail?.description ?? "-")
            .padding(.bottom, 15)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
      }
    }
    .navigationBarTitle("Game Detail", displayMode: .inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(isDataExist ? "Delete" : "Save") {
          if gameViewModel.gameDetail != nil {
            if isDataExist {
              persistenceController.deleteGame(id) { message in
                successMessage = message
                showSuccessAlert.toggle()
              }
            } else {
              persistenceController.saveGame(gameViewModel.gameDetail!) { message in
                successMessage = message
                showSuccessAlert.toggle()
              }
            }
            checkData()
          }
        }
      }
    }
    .alert(isPresented: $showSuccessAlert) {
      Alert(
        title: Text("Success"),
        message: Text(successMessage),
        dismissButton: .default(Text("Got it!"))
      )
    }
    .onAppear {
      self.gameViewModel.getGameDetail(id: id)
      checkData()
    }
  }
}
