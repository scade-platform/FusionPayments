//
//  FusionPaymentsRequest.swift
//  
//
//  Created by VJ on 16/12/22.
//

import Foundation

open class PaymentRequest : NSObject {
 
    // The payment networks and platforms supported for in-app payment
    @available(iOS 10.0, *)
    open class func availableNetworks() -> [PaymentNetwork]

    // Identifies the merchant, as previously agreed with Apple.  Must match one of the merchant
    // identifiers in the application's entitlement.
    open var merchantIdentifier: String

    
    // The merchant's ISO country code.
    open var countryCode: String

    
    // The payment networks supported by the merchant, for example @[ PKPaymentNetworkVisa,
    // PKPaymentNetworkMasterCard ].  This property constrains payment cards that may fund the payment.
    open var supportedNetworks: [PaymentNetwork]

    // Indicates whether the merchant supports coupon code entry and validation. Defaults to NO.
    @available(iOS 15.0, *)
    open var supportsCouponCode: Bool

    
    // An optional coupon code that is valid and has been applied to the payment request already.
    @available(iOS 15.0, *)
    open var couponCode: String?

    
    // Array of PKPaymentSummaryItem objects which should be presented to the user.
    // The last item should be the total you wish to charge, and should not be pending
    open var paymentSummaryItems: [PaymentSummaryItem]

    
    // Currency code for this payment.
    open var currencyCode: String

    // Set of two-letter ISO 3166 country codes. When provided will filter the selectable payment passes to those
    // issued in the supported countries.
    @available(iOS 11.0, *)
    open var supportedCountries: Set<String>?
    
}
