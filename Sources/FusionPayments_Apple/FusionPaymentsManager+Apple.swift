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
    
    public required init(paymentRequest: PaymentRequest){
        self.paymentRequest = paymentRequest
    }
    
    private var completionHandler: ((PaymentStatus, PaymentError?) -> Void)?
    
    private var paymentSheetViewState: ((PaymentSheetViewState) -> Void)?
    private var paymentVC: PKPaymentAuthorizationViewController!
    
    public func initiatePayment( paymentRequest: PaymentRequest, paymentStatus: @escaping (PaymentStatus, PaymentError?) -> Void, paymentSheetViewState: @escaping (PaymentSheetViewState) -> Void ) {
        
        let paymentLabel:String = paymentRequest.paymentSummaryItem.label!
        let paymentAmount:NSDecimalNumber = paymentRequest.paymentSummaryItem.amount
        
        let paymentItem = PKPaymentSummaryItem(
            label: paymentLabel, amount: paymentAmount)
        
        // cast here PaymentNetworks -> PKPaymentNetworks
        let paymentNetworks = getPaymentNetworks(paymentNetworks: paymentRequest.supportedNetworks)
        
        // Using PassKit methods to intiate the Apple Pay transaction
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
            let request = PKPaymentRequest()
            request.currencyCode = paymentRequest.currencyCode  // 1
            request.countryCode = paymentRequest.countryCode  // 2
            request.merchantIdentifier = paymentRequest.merchantIdentifier//"merchant.com.vedant.fusionpayments"  // 3
            request.merchantCapabilities = PKMerchantCapability.capability3DS  // 4
            request.supportedNetworks = paymentNetworks  // 5
            request.paymentSummaryItems = [paymentItem]  // 6
            
            guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) else {
                print("Unable to present Apple Pay authorization dialog")
                completionHandler?(.FAILED, .AUTHORIZATION_ERROR)
                return
            }
            paymentVC.delegate = self
            self.paymentVC = paymentVC
#if os(iOS)
            UIApplication.shared.delegate?.window??.rootViewController?.present(
                paymentVC, animated: true, completion: nil)
            paymentSheetViewState(.PAYMENT_SHEET_OPENED)
#endif
            
        } else {
            // displayDefaultAlert(title: "Error", message: "Unable to make Apple Pay transaction.")
            print("Unable to make Apple Pay transaction!")
            completionHandler?(.FAILED, .UNSUPPORTED_PAYMENT_NETWORK)
        }
        
        completionHandler = paymentStatus
        self.paymentSheetViewState = paymentSheetViewState
        
    }
    
    public func getPaymentNetworks(paymentNetworks: [PaymentNetwork]) -> [PKPaymentNetwork] {
        var pkPaymentNetworks:[PKPaymentNetwork] = []
        for paymentNetwork in paymentNetworks {
            let pkPaymentNetwork = getPKPaymentNetwork(paymentNetwork: paymentNetwork)
            if pkPaymentNetwork != nil {
                pkPaymentNetworks.append(pkPaymentNetwork!)
            }
        }
        return pkPaymentNetworks
    }
    
    
    public func getPKPaymentNetwork(paymentNetwork: PaymentNetwork) -> PKPaymentNetwork? {
        var iOSPaymentNetwork: PKPaymentNetwork?
        switch(paymentNetwork) {
        case .amex:
            iOSPaymentNetwork =  .amex
            
        case .bancomat:
            if #available(iOS 16.0, macOS 12.0, *) {
                iOSPaymentNetwork =  .bancomat
            } else {
                // Fallback on earlier versions
                return nil
            }
            
        case .bancontact:
            if #available(iOS 16.0, macOS 12.0, *) {
                iOSPaymentNetwork =  .bancontact
            } else {
                // Fallback on earlier versions
                return nil
            }
            
        case .cartesBancaires:
            iOSPaymentNetwork =  .cartesBancaires
            
        case .chinaUnionPay:
            iOSPaymentNetwork = .chinaUnionPay
            
        case .dankort:
            if #available(iOS 15.1, macOS 12.1, *) {
                iOSPaymentNetwork = .dankort
            } else {
                // Fallback on earlier versions
                return nil
            }
            
        case .discover:
            iOSPaymentNetwork = .discover
            
        case .eftpos:
            iOSPaymentNetwork = .eftpos
            
        case .electron:
            iOSPaymentNetwork = .electron
            
        case .elo:
            if #available(iOS 12.1.1, *) {
                iOSPaymentNetwork = .elo
            } else {
                // Fallback on earlier versions
                return nil
            }
            
        case .idCredit:
            iOSPaymentNetwork = .idCredit
            
        case .interac:
            iOSPaymentNetwork = .interac
            
        case .JCB:
            iOSPaymentNetwork = .JCB
            
        case .mada:
            if #available(iOS 12.1.1, *) {
                iOSPaymentNetwork = .mada
            } else {
                // Fallback on earlier versions
                return nil
            }
            
        case .maestro:
            iOSPaymentNetwork = .maestro
            
        case  .masterCard:
            iOSPaymentNetwork = .masterCard
            
        case .mir:
            if #available(iOS 14.5, macOS 11.5, *) {
                iOSPaymentNetwork = .mir
            } else {
                // Fallback on earlier versions
                return nil
            }
            
        case .privateLabel:
            iOSPaymentNetwork = .privateLabel
            
        case .quicPay:
            iOSPaymentNetwork = .quicPay
            
        case .suica:
            iOSPaymentNetwork = .suica
            
        case .visa:
            iOSPaymentNetwork = .visa
            
        case .vPay:
            iOSPaymentNetwork = .vPay
            
        case .barcode:
            if #available(iOS 14.0, *) {
                iOSPaymentNetwork = .barcode
            } else {
                // Fallback on earlier versions
                return nil
            }
            
        case .girocard:
            if #available(iOS 14.0, *) {
                iOSPaymentNetwork = .girocard
            } else {
                // Fallback on earlier versions
                return nil
            }
            
        case .waon:
            if #available(iOS 15.0, macOS 12.0, *) {
                iOSPaymentNetwork = .waon
            } else {
                // Fallback on earlier versions
                return nil
            }
            
        case .nanaco:
            if #available(iOS 15.0, macOS 12.0, *) {
                iOSPaymentNetwork = .nanaco
            } else {
                // Fallback on earlier versions
                return nil
            }
        }
        return iOSPaymentNetwork
        
    }
    
    
}

@available(macOS 11.0, *)
extension FusionPaymentsManager:   PKPaymentAuthorizationViewControllerDelegate {
    public func paymentAuthorizationViewControllerDidFinish(
        _ controller: PKPaymentAuthorizationViewController
    ) {
        //controller.dismiss(animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
#if os(iOS)
        controller.dismiss(
            animated: true, completion: nil)
        paymentSheetViewState!(.PAYMENT_SHEET_CLOSED)
        
#endif
    }
    
    public func paymentAuthorizationViewController(
        _ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment,
        handler completion: @escaping (PKPaymentAuthorizationResult) -> Void
    ) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        print(payment)
        completionHandler?(.SUCCESS, nil)
        
    }
    
}
