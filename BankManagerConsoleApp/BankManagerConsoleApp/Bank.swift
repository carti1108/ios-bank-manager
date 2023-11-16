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
    typealias bankManagerType = BankManager
    
    let bankClerk: BankClerk = BankClerk()
    let bankManager: BankManager = BankManager()
    let bankClerkCount: Int
    let customerLine: CustomerQueue<Customer>
    
    init(bankClerkCount: Int, customerLine: CustomerQueue<Customer>) {
        self.bankClerkCount = bankClerkCount
        self.customerLine = customerLine
    }
}
