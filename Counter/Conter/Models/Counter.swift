//
//  Counter.swift
//  Conter
//
//  Created by koala panda on 2023/11/30.
//

import Foundation


///一定のビジネスロジックを持つカウンターの構造体
struct Counter {
    
    //カウンターの現在値
    var value: Int = 0
    //プレミアム状態かどうかを示すフラグ
    var isPremium: Bool = false
    
    //カウンターの値を増加させるメソッド
    //Swiftでは、構造体や列挙型はデフォルトで不変（immutable）だが、mutatingキーワードをつけることで変更できる
    mutating func increment() {
        //値を1増やす
        value += 1
        
        //ビジネスロジック（特定のルールやビジネスプロセス、計算方法などを実現するためのプログラムコード）：値が3の倍数の場合はプレミアムとする
        if value.isMultiple(of: 3) {
            //値が3の倍数の場合はプレミアム
            isPremium = true
        } else {
            //そうでない場合は非プレミアム
            isPremium = false
        }
    }
}
