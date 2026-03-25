//
//  PremiumUpgradeView.swift
//  vestoAi for design
//
//  Created by Kenan on 25.03.26.
//


import SwiftUI

struct PremiumUpgradeView: View {
    @Environment(\.dismiss) var dismiss
    let goldColor = Color(hex: "#D4AF37")
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // MARK: - Icon & Title
                VStack(spacing: 15) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 60))
                        .foregroundColor(goldColor)
                    
                    Text("Vault Limit Reached")
                        .font(.system(size: 26, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                    
                    Text("Free plan includes 10 digital items. Upgrade to unlock your full style potential.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 40)
                }
                .padding(.top, 40)
                
                // MARK: - Comparison Cards
                VStack(spacing: 12) {
                    SubscriptionCard(title: "VESTO PRO", price: "$9.99/mo", features: ["Unlimited Vault", "10 Daily Analyses", "Synergy Match"], isPro: true)
                    
                    SubscriptionCard(title: "ATELIER", price: "$24.99/mo", features: ["All Pro Features", "VIP Concierge", "Trend Data Live"], isPro: false, isAtelier: true)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // MARK: - Action Buttons
                VStack(spacing: 15) {
                    Button(action: {
                        // Ödəniş məntiqi bura gələcək
                    }) {
                        Text("START 7-DAY FREE TRIAL")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(goldColor)
                            .cornerRadius(12)
                    }
                    
                    Button("Maybe Later") {
                        dismiss()
                    }
                    .foregroundColor(.gray)
                    .font(.footnote)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
    }
}

struct SubscriptionCard: View {
    let title: String
    let price: String
    let features: [String]
    var isPro: Bool
    var isAtelier: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(isAtelier ? .black : .white)
                Spacer()
                Text(price)
                    .font(.subheadline)
                    .foregroundColor(isAtelier ? .black : .gray)
            }
            
            ForEach(features, id: \.self) { feature in
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(isAtelier ? .black : Color(hex: "#D4AF37"))
                    Text(feature)
                        .font(.caption)
                        .foregroundColor(isAtelier ? .black : .white.opacity(0.8))
                }
            }
        }
        .padding()
        .background(isAtelier ? Color(hex: "#D4AF37") : Color.white.opacity(0.05))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(isPro ? Color(hex: "#D4AF37").opacity(0.5) : Color.clear, lineWidth: 1)
        )
    }
}

#Preview {
    PremiumUpgradeView()
}
