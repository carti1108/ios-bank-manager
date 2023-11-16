//
//  BankProtocol.swift
//
//
//  Created by Kiseok on 11/15/23.
//
import Foundation

public struct Bank {
    public var bankClerk: BankClerkProtocol
    public var bankClerkCount: Int
    public var bankManager: BankManager = BankManager()
    public var customerNumber: Int = Int.random(in: 10...30)
    public var customerLine: CustomerQueue<Customer>
    
    public init(bankClerk: BankClerkProtocol, bankClerkCount: Int, customerLine: CustomerQueue<Customer>) {
        self.bankClerk = bankClerk
        self.bankClerkCount = bankClerkCount
        self.customerLine = customerLine
    }
    
    public func open() {
        bankManager.giveWaitingTicket(customerNumber: self.customerNumber,
                                      customerLine: self.customerLine
        )
        
        while customerLine.count != 0 {
            guard let ticketNumber = customerLine.dequeue()?.waitingTicket else {
                return
            }
            
            bankClerk.startTask(count: ticketNumber)
        }
    }
    
    public func close() {
        bankClerk.endTask(customerNumber: self.customerNumber)
    }
}
