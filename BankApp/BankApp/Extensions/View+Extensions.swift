//
//  View+Extensions.swift
//  BankApp
//
//  Created by koala panda on 2023/12/04.
//

import Foundation
import SwiftUI


/// 拡張機能: SwiftUIのViewに対する便利なメソッドを提供
extension View {
    
    //ViewをNavigationViewに埋め込む
    func embedInNavigationView() -> some View {
        //自身をNavigationViewに埋め込む
        NavigationView { self }
    }
}
