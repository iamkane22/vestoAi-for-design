//
//  SubWall.swift
//  vestoAi for design
//
//  Created by Kenan on 13.03.26.
//

import SwiftUI

struct SubscriptionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedTier: VestoTier = .elite
    
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)
    
    var body: some View {
        ZStack {
            // Dark Obsidian Background
            Color.black.edgesIgnoringSafeArea(.all)
            
            // Background Glow
            Circle()
                .fill(vestoGold.opacity(0.1))
                .blur(radius: 100)
                .offset(y: -300)
            
            VStack(spacing: 25) {
                // Close Button
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white.opacity(0.5))
                            .padding(10)
                            .background(Circle().fill(Color.white.opacity(0.1)))
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                // Header
                VStack(spacing: 8) {
                    Text("CHOOSE YOUR STATUS")
                        .font(.system(size: 12, weight: .bold))
                        .tracking(3)
                        .foregroundColor(vestoGold)
                    
                    Text("Elevate your style with AI")
                        .font(.system(size: 24, weight: .thin, design: .serif))
                        .foregroundColor(.white)
                }
                
                // Tiers (3 Paket)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        TierCard(tier: .standard, isSelected: selectedTier == .standard)
                            .onTapGesture { selectedTier = .standard }
                        
                        TierCard(tier: .elite, isSelected: selectedTier == .elite)
                            .onTapGesture { selectedTier = .elite }
                        
                        TierCard(tier: .imperial, isSelected: selectedTier == .imperial)
                            .onTapGesture { selectedTier = .imperial }
                    }
                    .padding(.horizontal, 30)
                }
                
                // Features List based on Selection
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(selectedTier.features, id: \.self) { feature in
                        HStack(spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(vestoGold)
                                .font(.system(size: 14))
                            Text(feature)
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
                
                Spacer()
                
                // Subscribe Button
                Button(action: {
                    // Purchase Logic
                }) {
                    VStack(spacing: 4) {
                        Text("START WITH \(selectedTier.rawValue.uppercased())")
                            .font(.system(size: 14, weight: .bold))
                            .tracking(1)
                        Text(selectedTier.price)
                            .font(.system(size: 12, weight: .light))
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(vestoGold)
                    .cornerRadius(15)
                    .padding(.horizontal, 40)
                }
                
                Text("Restore Purchases")
                    .font(.system(size: 10))
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.bottom, 20)
            }
        }
    }
}

// MARK: - Components & Data Models

enum VestoTier: String {
    case standard = "Standard"
    case elite = "Elite"
    case imperial = "Imperial"
    
    var price: String {
        switch self {
        case .standard: return "Free Forever"
        case .elite: return "$9.99 / month"
        case .imperial: return "$29.99 / month"
        }
    }
    
    var features: [String] {
        switch self {
        case .standard:
            return ["3 Daily Style Scans", "Basic Verdict Insights", "Standard Share Cards"]
        case .elite:
            return ["Unlimited Scans", "The Vault (Digital Wardrobe)", "Smart Occasion Matching", "No Ads & Priority AI"]
        case .imperial:
            return ["AI Photoshoot (Studio Look)", "Investment Analysis", "Personal AI Twin", "Imperial Status Badge"]
        }
    }
}

struct TierCard: View {
    let tier: VestoTier
    let isSelected: Bool
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)
    
    var body: some View {
        VStack(spacing: 15) {
            Text(tier.rawValue)
                .font(.system(size: 18, weight: .medium, design: .serif))
                .foregroundColor(isSelected ? .black : .white)
            
            Text(tier.price)
                .font(.system(size: 12, weight: .light))
                .foregroundColor(isSelected ? .black.opacity(0.7) : .white.opacity(0.5))
        }
        .frame(width: 140, height: 180)
        .background(isSelected ? vestoGold : Color.white.opacity(0.05))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(vestoGold.opacity(isSelected ? 0 : 0.3), lineWidth: 1)
        )
        .scaleEffect(isSelected ? 1.05 : 0.95)
        .animation(.spring(), value: isSelected)
    }
}

#Preview {
    SubscriptionView()
}
