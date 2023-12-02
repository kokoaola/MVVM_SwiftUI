//
//  View+Extension.swift
//  Movies
//
//  Created by koala panda on 2023/12/02.
//

import Foundation
import SwiftUI

//現在のビューをナビゲーションビューで囲んで返す
extension View {
    
    func embedNavigationView() -> some View {
        return NavigationView { self }
    }
    
}
