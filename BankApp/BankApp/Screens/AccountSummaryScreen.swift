//
//  AccountSummaryScreen.swift
//  BankApp
//
//  Created by koala panda on 2023/12/08.
//

import SwiftUI


///シートを切り替える用のenum
enum ActiveSheet {
    case addAccount
    case transferFunds
}


struct AccountSummaryScreen: View {
    
    @ObservedObject private var accountSummaryVM = AccountSummaryViewModel()
    
    @State private var isPresented: Bool = false
    
    ///表示するシートを格納した変数
    @State private var activeSheet: ActiveSheet = .addAccount
    
    var body: some View {
        
        VStack {
            GeometryReader { g in
                VStack {
                    AccountListView(accounts: self.accountSummaryVM.accounts)
                        .frame(height: g.size.height/2)
                    Text("\(self.accountSummaryVM.total.formatAsCurrency())")
                    Spacer()
                    
                    Button("Transfer Funds"){
                        self.activeSheet = .transferFunds
                        self.isPresented = true
                    }
                    .padding()
                }
            }
            
        }
        .onAppear {
            self.accountSummaryVM.getAllAccounts()
        }
        //アカウント追加、       資金追加用のスクリーンのスクリーン
        .sheet(isPresented: $isPresented, onDismiss: {
            // シートが閉じられた時に実行する処理（リストの更新）
            self.accountSummaryVM.getAllAccounts()
        }) {
            
            switch self.activeSheet{
            case .transferFunds:
                TransferFundsScreen()
            case .addAccount:
                AddAccountScreen()
            }
        }
        
        .navigationBarItems(trailing: Button("Add Account") {
            self.activeSheet = .addAccount
            self.isPresented = true
        })
        .navigationBarTitle("Account Summary")
        .embedInNavigationView()
    }
}



struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}

