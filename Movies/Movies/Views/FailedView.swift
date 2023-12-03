//
//  FailedView.swift
//  Movies
//
//  Created by koala panda on 2023/12/02.
//

import SwiftUI

struct FailedView: View {
    var body: some View {
        Image("oops")
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .cornerRadius(6)

    }
}

struct FailedView_Previews: PreviewProvider {
    static var previews: some View {
        FailedView()
    }
}

