//
//  LoadingView.swift
//  Movies
//
//  Created by koala panda on 2023/12/03.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack{
            ProgressView()
                .scaleEffect(2.0)
                .padding()
            Text("Loading...")
                .font(.largeTitle)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
