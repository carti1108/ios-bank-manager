//
//  Customer.swift
//  BankManagerConsoleApp
//
//  Created by Kiseok on 11/16/23.
//

import Foundation
import BankManager

struct Customer: CustomerProtocol {
    let waitingTicket: Int
    
    init(watingTicket: Int) {
        self.waitingTicket = watingTicket
    }
}
