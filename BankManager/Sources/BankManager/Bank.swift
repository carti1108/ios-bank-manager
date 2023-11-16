//
//  Bank.swift
//
//
//  Created by Kiseok on 11/15/23.
//
import Foundation

public protocol BankProtocol {
    associatedtype customerType: CustomerProtocol
    associatedtype bankClerkType: BankClerkProtocol
    associatedtype bankManagerType: BankManagerProtocol
    
    var bankClerk: bankClerkType { get }
    var bankManager: bankManagerType { get }
    var customerNumber: Int { get }
    var customerLine: CustomerQueue<bankManagerType.T> { get }
    
    func open()
    func close()
}

extension BankProtocol {
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
