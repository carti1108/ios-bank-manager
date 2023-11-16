//
//  BankProtocol.swift
//
//
//  Created by Kiseok on 11/15/23.
//
import Foundation

public protocol BankProtocol {
    associatedtype bankClerkType: BankClerkProtocol
    
    var bankClerk: bankClerkType { get }
    var bankClerkCount: Int { get }
    var bankManager: BankManager { get }
    var customerNumber: Int { get }
    var customerLine: CustomerQueue<Customer> { get }
    
    func open()
    func close()
}

extension BankProtocol {
    public var customerNumber: Int {
        return Int.random(in: 10...30)
    }
    
    public var bankManager: BankManager {
        return BankManager()
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
