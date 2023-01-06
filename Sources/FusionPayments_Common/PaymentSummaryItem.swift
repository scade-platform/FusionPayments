//
//  PaymentSummaryItem.swift
//  
//
//  Created by VJ on 18/12/22.
//

import Foundation

@available(iOS 11.0, *)
public class PaymentSummaryItem : NSObject {
    // A short localized description of the item, e.g. "Tax" or "Gift Card".
    open var label: String?
    
    
    // Same currency as the enclosing PaymentRequest.  Negative values are permitted, for example when
    @NSCopying open var amount: NSDecimalNumber = 0.0
    
    public init(label: String, amount: NSDecimalNumber) {
        self.label = label
        self.amount = amount
    }
}
