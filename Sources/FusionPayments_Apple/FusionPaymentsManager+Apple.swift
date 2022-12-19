//
//  FusionPaymentsManager.swift
//  
//
//  Created by VJ on 15/12/22.
//

import Foundation
import PassKit
import FusionPayments_Common

@available(macOS 11.0, *)
public class FusionPaymentsManager: NSObject, FusionPaymentsManagerProtocol {
    
    required public override init(){
        
    }
    
    var completionHandler: ((PaymentStatus, PaymentError?) -> Void)?
    
    
    
    public func initiatePayment( paymentRequest: PaymentRequest, paymentStatus: @escaping (PaymentStatus, PaymentError?) -> Void ) {
        
        
        let paymentItem = PKPaymentSummaryItem.init(
            label: "lable", amount: NSDecimalNumber(value: 33))
        
        let paymentNetworks = [PKPaymentNetwork.amex, .discover, .masterCard, .visa]
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
            let request = PKPaymentRequest()
            request.currencyCode = "USD"  // 1
            request.countryCode = "US"  // 2
            request.merchantIdentifier = "merchant.com.vedant.fusionpayments"  // 3
            request.merchantCapabilities = PKMerchantCapability.capability3DS  // 4
            request.supportedNetworks = paymentNetworks  // 5
            request.paymentSummaryItems = [paymentItem]  // 6
            
            guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) else {
                //   displayDefaultAlert(title: "Error", message: "Unable to present Apple Pay authorization.")
                print("unable to present apple pay authorization: error")
                return
            }
            paymentVC.delegate = self
#if os(iOS)
            UIApplication.shared.delegate?.window??.rootViewController?.present(
                paymentVC, animated: true, completion: nil)
#endif
            
        } else {
            // displayDefaultAlert(title: "Error", message: "Unable to make Apple Pay transaction.")
            print("error: unable to make apple pay transaction")
            completionHandler?(.SUCCESS, .UNKNOWN_ERROR)
        }
        
        completionHandler = paymentStatus
        
    }
    
    
}

@available(macOS 11.0, *)
extension FusionPaymentsManager:   PKPaymentAuthorizationViewControllerDelegate {
    public func paymentAuthorizationViewControllerDidFinish(
        _ controller: PKPaymentAuthorizationViewController
    ) {
        //controller.dismiss(animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
        print("payment finished")
#if os(iOS)
        UIApplication.shared.delegate?.window??.rootViewController?.dismiss(
            animated: true, completion: nil)
        
        completionHandler?(.FAILED, nil)
        
#endif
    }
    
    public func paymentAuthorizationViewController(
        _ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment,
        handler completion: @escaping (PKPaymentAuthorizationResult) -> Void
    ) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        print(payment)
        
        print("payment done")
        completionHandler?(.SUCCESS, nil)
        
    }
    
}
