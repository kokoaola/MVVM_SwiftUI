//
//  CounterViewModel.swift
//  Conter
//
//  Created by koala panda on 2023/11/30.
//

import Foundation
import SwiftUI

///カウンターの状態を管理するObservableObjectを継承したViewModelクラス
class CounterViewModel: ObservableObject {
    
    //@Publishedプロパティラッパーを使ってCounterインスタンスを監視可能にする
    //値が増加したことがビューに通知され、再レンダリングされる
    @Published private var counter: Counter = Counter()
    
    //カウンターの現在値を取得するプロパティ
    var value: Int {
        counter.value
    }
    
    //カウンターがプレミアム状態かどうかを取得するプロパティ
    var premium: Bool {
        counter.isPremium
    }
    
    //カウンターの値を増加させるメソッド
    func increment() {
        counter.increment()
    }
}
