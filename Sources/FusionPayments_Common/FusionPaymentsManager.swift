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
                    return "Biometry is not available in the device."
                    
                case .SHIPPING_CONTACT_INVALID_ERROR:
                    return "Biometry is locked because there were too many failed attempts."
                    
                case .SHIPPING_CONTACT_INSERVICEABLE_ERROR:
                    return "The user has no enrolled biometric identities."
                    
                case .NETWORK_ERROR:
                    return "The device supports biometry only using a removable accessory, but the paired accessory isn’t connected."
                    
                case .UNKNOWN_ERROR:
                    return "The user tapped the cancel button in the authentication dialog."
                    
                }
            }
}





