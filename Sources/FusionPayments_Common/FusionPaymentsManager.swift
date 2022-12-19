//
//  FusionPaymentsManager.swift
//  
//
//  Created by VJ on 15/12/22.
//

import Foundation

public protocol FusionPaymentsManagerProtocol  {
    init()
    
    func initiatePayment( paymentRequest: PaymentRequest, paymentStatus: @escaping (PaymentStatus) -> Void )
}

public enum PaymentStatus {
    case SUCCESS
    
    case FAILED
}



