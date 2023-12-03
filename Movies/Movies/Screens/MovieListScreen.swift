//
//  MovieListScreen.swift
//  Movies
//
//  Created by koala panda on 2023/12/02.
//

import SwiftUI

struct MovieListScreen: View {
    
    //ビューモデルを作成
    //オブジェクトと公開されたプロパティに変更が発生すると、ビューがレンダリング
    @ObservedObject private var movieListVM: MovieListViewModel
    @State private var movieName: String = ""
    
    init() {
        self.movieListVM = MovieListViewModel()
    }
    
    var body: some View {
        VStack {
            
            TextField("Search", text: $movieName, onEditingChanged: { _ in }, onCommit: {
                //Returnキーを押すと検索を実行
                self.movieListVM.searchByName(self.movieName)
            }).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Spacer()

                .navigationBarTitle("Movies")
            
            if self.movieListVM.loadingState == .success {
                MovieListView(movies: self.movieListVM.movies)
            } else if self.movieListVM.loadingState == .failed {
                FailedView()
            } else if self.movieListVM.loadingState == .loading {
                LoadingView()
            }
        }
            .embedNavigationView()
    }
}

struct MovieListScreen_Previews: PreviewProvider {
    static var previews: some View {
        MovieListScreen()
    }
}
