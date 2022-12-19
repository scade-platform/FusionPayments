//
//  FusionPaymentsManager.swift
//  
//
//  Created by VJ on 15/12/22.
//

import Foundation

public protocol FusionPaymentsManagerProtocol  {
    init()
    
    func initiatePayment( paymentRequest: PaymentRequest, paymentStatus: @escaping (PaymentStatus, PaymentError?) -> Void )
}

public enum PaymentStatus {
    case SUCCESS
    
    case FAILED
}

public enum PaymentError {
    
    case BILLING_CONTACT_INVALID_ERROR
    
    case SHIPPING_CONTACT_INVALID_ERROR
    
    case SHIPPING_CONTACT_INSERVICEABLE_ERROR
    
    case NETWORK_ERROR
    
    case UNKNOWN_ERROR
    
    public var description:String {
                switch self {
                
                case .BILLING_CONTACT_INVALID_ERROR:
                    return "Billing Contact information is invalid."
                    
                case .SHIPPING_CONTACT_INVALID_ERROR:
                    return "Shipping Contact information is invalid."
                    
                case .SHIPPING_CONTACT_INSERVICEABLE_ERROR:
                    return "The shipping contact address is inserviceable."
                    
                case .NETWORK_ERROR:
                    return "Network error occurred."
                    
                case .UNKNOWN_ERROR:
                    return "Unknown error occurred."
                    
                }
            }
}





