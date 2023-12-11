//
//  TransferFundsScreen.swift
//  BankApp
//
//  Created by koala panda on 2023/12/11.
//

import SwiftUI

struct TransferFundsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var transferFundsVM = TransferFundsViewModel()
    @State private var showSheet = false
    @State private var isFromAccount = false
    
    
    ///アクションシートのボタンを格納する変数
    var actionSheetButtons: [Alert.Button] {
        // filteredAccountsを元にボタンを生成
        var actionButtons = self.transferFundsVM.filteredAccounts.map { account in
            // 各アカウントに対応するボタンを作成
            // ボタンのテキストにはアカウントの名前と種類を表示
            Alert.Button.default(Text("\(account.name) (\(account.accountType))")) {
                // ボタンがタップされたときのアクション
                // isFromAccountの値に応じてfromAccountかtoAccountを設定
                if self.isFromAccount {
                    self.transferFundsVM.fromAccount = account
                } else {
                    self.transferFundsVM.toAccount = account
                }
            }
        }
        // キャンセルボタンをボタンのリストに追加
        actionButtons.append(.cancel())
        // 作成したボタンのリストを返す
        return actionButtons
    }

    
    
    
    var body: some View {
        //ビューが途切れてしまうのでスクロールビューに格納
        ScrollView {
            VStack {
                //AccountSummaryScreenでも使用しているAccountListViewを再利用
                AccountListView(accounts: self.transferFundsVM.accounts)
                    .frame(height: 200)
                
                
                //送信元と送信先を選択するビュー
                TransferFundsAccountSelectionView(transferFundsVM: self.transferFundsVM, showSheet: $showSheet, isFromAccount: $isFromAccount)
                
                Spacer()
                
                Text(self.transferFundsVM.message ?? "")
                
                Button("Submit Transfer") {
                    //リクエストを送信し、モーダルを閉じる
                    self.transferFundsVM.submitTransfer {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }.padding()
                
                //アクションシートを表示
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Transfer Funds"), message: Text("Choose an account"), buttons: self.actionSheetButtons)
                }
            }
        }
        
        //全てのデータを取得する
        .onAppear {
            self.transferFundsVM.populateAccounts()
        }
        .navigationBarTitle("Transfer Funds").embedInNavigationView()
    }
}

struct TransferFundsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransferFundsScreen()
    }
}
