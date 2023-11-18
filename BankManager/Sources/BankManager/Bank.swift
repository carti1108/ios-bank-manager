//
//  Bank.swift
//
//
//  Created by Kiseok on 11/15/23.
//
import Foundation

public struct Bank {
    private let bankClerk: BankClerk = BankClerk()
    private let bankManager: BankManager = BankManager()
    private let bankClerkCount: Int
    private let customerNumber = Int.random(in: 10...30)
    private let customerLine: CustomerQueue<Customer>
    
    public init(bankClerkCount: Int, customerLine: CustomerQueue<Customer>) {
        self.bankClerkCount = bankClerkCount
        self.customerLine = customerLine
    }
    
    public func open() {
        bankManager.giveWaitingTicket(customerNumber: self.customerNumber,
                                      customerLine: self.customerLine
        )
        
        let taskStart = CFAbsoluteTimeGetCurrent()
        while customerLine.count != 0 {
            guard let ticketNumber = customerLine.dequeue()?.waitingTicket else {
                return
            }
            
            bankClerk.startTask(count: ticketNumber)
        }
        let taskEnd = CFAbsoluteTimeGetCurrent() - taskStart
        
        close(time: taskEnd)
    }
    
    private func close(time: CFAbsoluteTime) {
        bankClerk.endTask(customerNumber: self.customerNumber, time: time)
    }
}
