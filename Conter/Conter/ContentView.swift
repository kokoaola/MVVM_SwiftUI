//
//  ContentView.swift
//  Conter
//
//  Created by koala panda on 2023/11/30.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var counterVM: CounterViewModel
    
    //init 内でモデルまたはビューモデルを何度も再初期化すると、毎回それが再初期化される可能性がある
    init() {
        counterVM = CounterViewModel()
    }
    
    
    var body: some View {
        VStack {
            
            Text(counterVM.premium ? "PREMIUM" : "")
                .foregroundColor(.green)
                .frame(width: 200,height: 100)
                .font(.largeTitle)
            
            Text("\(counterVM.value)")
                .font(.title)
            
            Button("Increment"){
                self.counterVM.increment()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
