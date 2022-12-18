//
//  PaymentSummaryItem.swift
//  
//
//  Created by VJ on 18/12/22.
//

import Foundation

@available(iOS 8.0, *)
open class PaymentSummaryItem : NSObject {

    
    public convenience init(label: String, amount: NSDecimalNumber)

    
    // A short localized description of the item, e.g. "Tax" or "Gift Card".
    open var label: String

    
    // Same currency as the enclosing PaymentRequest.  Negative values are permitted, for example when
    // redeeming a coupon. An amount is always required unless the summary item's type is set to pending
    @NSCopying open var amount: NSDecimalNumber
}
