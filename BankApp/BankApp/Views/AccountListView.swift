//
//  AccountListView.swift
//  BankApp
//
//  Created by koala panda on 2023/12/08.
//


import SwiftUI


///リスト全体のビュー
struct AccountListView: View {
    
    //表示するためのリストを受け取る
    let accounts: [AccountViewModel]
    
    var body: some View {
        List(accounts, id: \.accountId) { account in
            AccountCell(account: account)
        }
    }
}


///セル１行のビュー
struct AccountCell: View {
    
    let account: AccountViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading,spacing: 10) {
                Text(account.name)
                    .font(.headline)
                
                Text(account.accountType)
                    .opacity(0.5)
            }
            Spacer()
            Text("\(account.balance.formatAsCurrency())")
                .foregroundColor(Color.green)
        }
    }
}



struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        
        let account = Account(id: UUID(), name: "Koayama Koa", accountType: .checking, balance: 200)
        let accountVM = AccountViewModel(account: account)
        
        return AccountListView(accounts: [accountVM])
    }
}
