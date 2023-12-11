//
//  TransferFundsAccountSelectionView.swift
//  BankApp
//
//  Created by koala panda on 2023/12/11.
//

import SwiftUI

struct TransferFundsAccountSelectionView: View {
    
    @ObservedObject var transferFundsVM: TransferFundsViewModel
    @Binding var showSheet: Bool
    @Binding var isFromAccount: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Button {
                self.isFromAccount = true
                self.showSheet = true
            } label: {
                Text("From \(self.transferFundsVM.fromAccount?.name ?? "") \(self.transferFundsVM.fromAccountType)")
                    .padding().frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(Color.white)
            }
            
            Button {
                self.isFromAccount = false
                self.showSheet = true
            } label: {
                Text("To \(self.transferFundsVM.toAccount?.name ?? "") \(self.transferFundsVM.toAccountType)")
                    .padding().frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .opacity(self.transferFundsVM.fromAccount != nil ? 1.0 : 0.5)
            }
            .disabled(self.transferFundsVM.fromAccount == nil)

            
            TextField("Amount", text: self.$transferFundsVM.amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
        }.padding()
    }
}


//struct TransferFundsAccountSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransferFundsAccountSelectionView()
//    }
//}
