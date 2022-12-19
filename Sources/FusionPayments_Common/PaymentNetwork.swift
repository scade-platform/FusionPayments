//
//  PaymentNetwork.swift
//  
//
//  Created by VJ on 18/12/22.
//

import Foundation


public enum PaymentNetwork {
    case amex
    
    case bancomat
    
    @available(macOS 12.0, *)
    case bancontact
    
    @available(macOS, introduced: 10.13, deprecated: 11.0, message: "Use PKPaymentNetworkCartesBancaires instead.")
    case carteBancaire
    
    @available(macOS, introduced: 10.13, deprecated: 11.0, message: "Use PKPaymentNetworkCartesBancaires instead.")
    case carteBancaires
    
    @available(macOS 11.0, *)
    case cartesBancaires
    
    @available(macOS 11.0, *)
    case chinaUnionPay
    
    @available(macOS 12.1, *)
    case dankort
    
    @available(macOS 11.0, *)
    case discover
    
    @available(macOS 11.0, *)
    case eftpos
    
    @available(macOS 11.0, *)
    case electron
    
    @available(macOS 11.0, *)
    case elo
    
    @available(macOS 11.0, *)
    case idCredit
    
    @available(macOS 11.0, *)
    case interac
    
    @available(macOS 11.0, *)
    case JCB
    
    @available(macOS 11.0, *)
    case mada
    
    @available(macOS 11.0, *)
    case maestro
    
    @available(macOS 11.0, *)
    case  masterCard
    
    @available(macOS 11.5, *)
    case mir
    
    @available(macOS 11.0, *)
    case privateLabel
    
    @available(macOS 11.0, *)
    case quicPay
    
    @available(macOS 11.0, *)
    case suica
    
    @available(macOS 11.0, *)
    case visa
    
    @available(macOS 11.0, *)
    case vPay
    
    @available(macOS 11.0, *)
    case barcode
    
    @available(macOS 11.0, *)
    case girocard
    
    @available(macOS 12.0, *)
    case waon
    
    @available(macOS 12.0, *)
    case nanaco
}
