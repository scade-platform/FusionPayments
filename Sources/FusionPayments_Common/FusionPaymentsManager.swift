//
//  FusionPaymentsManager.swift
//  
//
//  Created by VJ on 15/12/22.
//

import Foundation
import PassKit

public protocol FusionPaymentsManagerProtocol  {
    
    
    func intiatePayment( completion: @escaping (Int) -> Void )
}



