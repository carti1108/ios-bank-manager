//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by Kiseok on 11/16/23.
//

import Foundation
import BankManager

struct Bank: BankProtocol {
   
    typealias bankClerkType = BankClerk
    
    let bankClerk: BankClerk = BankClerk()
    let bankClerkCount: Int
    
    init(bankClerkCount: Int) {
        self.bankClerkCount = bankClerkCount
    }
}
