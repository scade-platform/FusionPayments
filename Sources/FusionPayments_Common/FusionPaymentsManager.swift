//
//  FusionPaymentsManager.swift
//  
//
//  Created by VJ on 15/12/22.
//

import Foundation

public protocol FusionPaymentsManagerProtocol  {
    
    func initiatePayment( paymentRequest: PaymentRequest, completion: @escaping (Int) -> Void )
}



