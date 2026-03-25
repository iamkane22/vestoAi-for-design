//
//  SubscriptionManager.swift
//  vestoAi for design
//
//  Created by Kenan on 25.03.26.
//

import Foundation
internal import Combine

enum UserTier: Int {
    case free = 0
    case pro = 1
    case atelier = 2
    
    var vaultLimit: Int {
        switch self {
        case .free: return 10
        case .pro,
                .atelier: return 100000         }
    }
}
class SubscriptionManager: ObservableObject {
    @Published var currentTier: UserTier = .free
    @Published var savedItemsCount: Int = 0
    
    func canSaveToVault() -> Bool {
        return savedItemsCount < currentTier.vaultLimit
    }
}
