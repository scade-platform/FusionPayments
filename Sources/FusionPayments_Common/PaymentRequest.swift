//
//  FusionPaymentsRequest.swift
//  
//
//  Created by VJ on 16/12/22.
//

import Foundation

@available(iOS 11.0, *)
public class PaymentRequest : NSObject {
    
    public init(merchantIdentifier: String, countryCode:String, currencyCode: String, supportedNetworks: [PaymentNetwork], paymentSummaryItem: PaymentSummaryItem, supportedCountries: Set<String>){
        self.merchantIdentifier = merchantIdentifier
        self.countryCode = countryCode
        self.currencyCode = currencyCode
        self.supportedNetworks = supportedNetworks
        self.paymentSummaryItem = paymentSummaryItem
        self.supportedCountries = supportedCountries
    }
    
    // Identifies the merchant, as previously agreed with Apple.  Must match one of the merchant
    // identifiers in the application's entitlement.
    public var merchantIdentifier: String

    
    // The merchant's ISO country code.
    public var countryCode: String

    
    // The payment networks supported by the merchant, for example @[ PKPaymentNetworkVisa,
    // PKPaymentNetworkMasterCard ].  This property constrains payment cards that may fund the payment.
    public var supportedNetworks: [PaymentNetwork]
    
    // Array of PKPaymentSummaryItem objects which should be presented to the user.
    // The last item should be the total you wish to charge, and should not be pending
    public var paymentSummaryItem: PaymentSummaryItem

    
    // Currency code for this payment.
    public var currencyCode: String

    // Set of two-letter ISO 3166 country codes. When provided will filter the selectable payment passes to those
    // issued in the supported countries.
    public var supportedCountries: Set<String>?
        
    }
 

