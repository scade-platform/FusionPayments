//
//  FusionPaymentsManager.swift
//  
//
//  Created by VJ on 15/12/22.
//

import Foundation
import PassKit

public class FusionPaymentsManager: FusionPaymentsManagerProtocol {
    
    var completionHandler: ((Int) -> Void)?
    
    public func intiatePayment( completion: @escaping (Int) -> Void ) {
       
        
        let paymentItem = PKPaymentSummaryItem.init(
              label: shoe.name, amount: NSDecimalNumber(value: shoe.price))

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
              UIApplication.shared.delegate?.window??.rootViewController?.present(
                paymentVC, animated: true, completion: nil)

            } else {
              // displayDefaultAlert(title: "Error", message: "Unable to make Apple Pay transaction.")
              print("error: unable to make apple pay transaction")
            }
        
        completionHandler = completion
        
    }
    

}

extension FusionPaymentsManager: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(
        _ controller: PKPaymentAuthorizationViewController
      ) {
        //controller.dismiss(animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
        print("payment finished")
        UIApplication.shared.delegate?.window??.rootViewController?.dismiss(
          animated: true, completion: nil)

          completionHandler?(0)
      }
    
      func paymentAuthorizationViewController(
        _ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment,
        handler completion: @escaping (PKPaymentAuthorizationResult) -> Void
      ) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        // displayDefaultAlert(title: "Success!", message: "The Apple Pay transaction was complete.")
        print(payment)
        print(Unmanaged.passUnretained(payment).toOpaque())
        print(Unmanaged.passUnretained(payment.token).toOpaque())

        // print(completion)
        print("payment done")
          completionHandler?(1)

      }

}
