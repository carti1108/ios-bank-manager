//
//  BankManager.swift
//  BankManagerConsoleApp
//
//  Created by Kiseok on 11/16/23.
//

import Foundation
import BankManager

struct BankManager: BankManagerProtocol {
     func giveWaitingTicket(customerNumber: Int, customerLine: CustomerQueue<Customer>) {
         for i in 1...customerNumber {
            let customer = Customer(watingTicket: i)
            customerLine.enqueue(data: customer)
        }
    }
}
