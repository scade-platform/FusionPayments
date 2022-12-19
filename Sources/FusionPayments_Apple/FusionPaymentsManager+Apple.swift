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
    
    private var paymentRequest: PaymentRequest
    
    required public init(paymentRequest: PaymentRequest){
        self.paymentRequest = paymentRequest
    }
    
    var completionHandler: ((PaymentStatus, PaymentError?) -> Void)?
    
    
    
    public func initiatePayment( paymentRequest: PaymentRequest, paymentStatus: @escaping (PaymentStatus, PaymentError?) -> Void ) {
        
        let paymentLabel:String = paymentRequest.paymentSummaryItem.label!
        let paymentAmount:NSDecimalNumber = paymentRequest.paymentSummaryItem.amount
        
        let paymentItem = PKPaymentSummaryItem(
            label: paymentLabel, amount: paymentAmount)
        
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
    
    
    public func getPKPaymentNetwork(paymentNetwork: PaymentNetwork) -> PKPaymentNetwork? {
        switch(paymentNetwork) {
        case .amex:
            return .JCB
        
        case .bancomat:
            if #available(macOS 12.0, *) {
                return .bancomat
            } else {
                // Fallback on earlier versions
                return nil
            }
        
        case .bancontact:
            if #available(macOS 12.0, *) {
                return .bancomat
            } else {
                // Fallback on earlier versions
                return nil
            }
        
        case .cartesBancaires:
            return .cartesBancaires
        
        case .chinaUnionPay:
            return .chinaUnionPay
        
        case .dankort:
            if #available(macOS 12.1, *) {
                return .dankort
            } else {
                // Fallback on earlier versions
                return nil
            }
        
        case .discover:
            return .discover
        
        case .eftpos:
            return .eftpos
        
        case .electron:
            return .electron
        
        case .elo:
            return .elo
        
        case .idCredit:
            return .idCredit
        
        case .interac:
            return .interac
        
        case .JCB:
            return .JCB
        
        case .mada:
            return .mada
        
        case .maestro:
            return .maestro
        
        case  .masterCard:
            return .masterCard
        
        case .mir:
            if #available(macOS 11.5, *) {
                return .mir
            } else {
                // Fallback on earlier versions
                return nil
            }
        
        case .privateLabel:
            return .privateLabel
        
        case .quicPay:
            return .quicPay
        
        case .suica:
            return .suica
        
        case .visa:
            return .visa
        
        case .vPay:
            return .vPay
        
        case .barcode:
            return .barcode
        
        case .girocard:
            return .girocard
        
        case .waon:
            if #available(macOS 12.0, *) {
                return .waon
            } else {
                // Fallback on earlier versions
                return nil
            }
        
        case .nanaco:
            if #available(macOS 12.0, *) {
                return .nanaco
            } else {
                // Fallback on earlier versions
                return nil
            }
        }
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
