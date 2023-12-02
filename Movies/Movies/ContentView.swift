//
//  ContentView.swift
//  Movies
//
//  Created by koala panda on 2023/12/01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        
        //We will remove this code
        ///Info.plistのApp Transport Security Settingsを設定、子としてAllow Arbitrary Loadsを追加しYesで設定
        .onAppear{
            HTTPClient().getMoviesBy(search: "kubi") { result in
                switch result {
                case .success(let movies):
                    print(movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
