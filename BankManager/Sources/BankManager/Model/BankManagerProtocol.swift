import Foundation

public protocol BankManagerProtocol {
    func giveWaitingTicket(customerNumber: Int, customerLine: CustomerQueue<Customer>)
}

extension BankManagerProtocol {
    public func giveWaitingTicket(customerNumber: Int, customerLine: CustomerQueue<Customer>) {
        for i in 1...customerNumber {
           let customer = Customer(watingTicket: i)
           customerLine.enqueue(data: customer)
       }
   }
}
