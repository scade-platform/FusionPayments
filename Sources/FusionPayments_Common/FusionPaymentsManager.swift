//
//  FusionPaymentsManager.swift
//  
//
//  Created by VJ on 15/12/22.
//

import Foundation
import PassKit

public protocol FusionPaymentsManagerProtocol  {
    
    init(paymentRequest: PaymentRequest)
    
    func intiatePayment( completion: @escaping (Int) -> Void )
}



