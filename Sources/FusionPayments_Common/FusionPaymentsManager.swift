//
//  FusionPaymentsManager.swift
//  
//
//  Created by VJ on 15/12/22.
//

import Foundation

public protocol FusionPaymentsManagerProtocol  {
    init(paymentRequest: PaymentRequest)
    
    /*
     * @property initiatePayment
     *
     * @discussion request payment(Apple/Google pay)
     *             paymentRequest is passed as input parameter
     *
     * @param paymentRequest: passed as input parameter
     *        paymentStatus: contains the payment result
     *        paymentSheetViewState: contains the current state of the payment-sheet
     *
     */
    func initiatePayment( paymentRequest: PaymentRequest, paymentStatus: @escaping (PaymentStatus, PaymentError?) -> Void, paymentSheetViewState: @escaping (PaymentSheetViewState) -> Void )
}

// PaymentStatus : returns the payment result
public enum PaymentStatus {
    case SUCCESS // Successful Payment
    
    case FAILED // payment failure
}

public enum PaymentSheetViewState {
    case PAYMENT_SHEET_OPENED // Apple/Google payment sheet is in the opened state
    
    case PAYMENT_SHEET_CLOSED // Apple/Google payment sheet is in the closed state
}

public enum PaymentError {
    
    /*
     * @property BILLING_CONTACT_INVALID_ERROR
     *
     * @discussion The billing contact information in the Apple/Google pay is invalid.
     */
    case BILLING_CONTACT_INVALID_ERROR
    
    /*
     * @property SHIPPING_CONTACT_INVALID_ERROR
     *
     * @discussion The Shipping contact information for the requested payment is invalid.
     */
    case SHIPPING_CONTACT_INVALID_ERROR
    
    /*
     * @property SHIPPING_CONTACT_INSERVICEABLE_ERROR
     *
     * @discussion The Shipping address for the requested payment is inserviceable.
     */
    case SHIPPING_CONTACT_INSERVICEABLE_ERROR
    
    /*
     * @property AUTHORIZATION_ERROR
     *
     * @discussion The requested payment is not authorized.
     */
    case AUTHORIZATION_ERROR
    
    /*
     * @property UNSUPPORTED_PAYMENT_NETWORK
     *
     * @discussion The Payment request for the given payment network is not supported.
     */
    case UNSUPPORTED_PAYMENT_NETWORK
    
    /*
     * @property UNKNOWN_ERROR
     *
     * @discussion The requested payment is failed due to unknown error.
     */
    case UNKNOWN_ERROR
    
    // the brief description for the payment related errors.
    public var description:String {
        switch self {
            
        case .BILLING_CONTACT_INVALID_ERROR:
            return "Billing Contact information is invalid."
            
        case .SHIPPING_CONTACT_INVALID_ERROR:
            return "Shipping Contact information is invalid."
            
        case .SHIPPING_CONTACT_INSERVICEABLE_ERROR:
            return "The shipping contact address is inserviceable."
            
        case .AUTHORIZATION_ERROR:
            return "Authorization error occurred."
            
        case .UNSUPPORTED_PAYMENT_NETWORK:
            return "The payment is not supported by the given payment networks"
            
        case .UNKNOWN_ERROR:
            return "Unknown error occurred."
            
        }
    }
}





