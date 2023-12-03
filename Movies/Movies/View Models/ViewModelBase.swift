//
//  ViewModelBase.swift
//  Movies
//
//  Created by koala panda on 2023/12/02.
//

import Foundation


enum LoadingState {
    case loading, success, failed, none
}

///ロード状態タイプを管理するビューモデル
class ViewModelBase: ObservableObject {
    //デフォルトは.none
    @Published var loadingState: LoadingState = .none
}
