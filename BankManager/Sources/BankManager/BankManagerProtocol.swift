import Foundation

public protocol BankManagerProtocol {
    associatedtype T: CustomerProtocol
    
    func giveWaitingTicket(customerNumber: Int, customerLine: CustomerQueue<T>)
}
