//  attellierPro.swift
//  vestoAi for design
//
//  Created by Kanan on 24.03.26.
//

import SwiftUI

extension Color {
    static let vObsidian = Color(red: 5/255, green: 5/255, blue: 5/255)
    static let vGold = Color(red: 212/255, green: 175/255, blue: 55/255)
    static let vSoftWhite = Color.white.opacity(0.9)
    
    static let vGoldGradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 212/255, green: 175/255, blue: 55/255), Color(red: 249/255, green: 241/255, blue: 176/255)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

struct VestoProProfileView: View {
    var body: some View {
        ZStack {
            Color.vObsidian.ignoresSafeArea()
            
            RadialGradient(gradient: Gradient(colors: [Color.vGold.opacity(0.05), Color.clear]), center: .top, startRadius: 0, endRadius: 500)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 35) {
                    
                    // MARK: - 1. THE PRO HEADER
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .stroke(Color.vGold.opacity(0.3), lineWidth: 1)
                                .frame(width: 72, height: 72)
                            Text("JV")
                                .font(.system(size: 22, weight: .light, design: .serif))
                                .foregroundColor(.vGold)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Julian Vane")
                                .font(.system(size: 20, weight: .medium, design: .serif))
                                .foregroundColor(.white)
                            
                            Text("PRO MEMBER")
                                .font(.system(size: 9, weight: .bold))
                                .tracking(2)
                                .foregroundColor(.vGold)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "crown.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.vGold)
                            .padding(.top, -20)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    
                    // MARK: - 2. THE MASTER GAUGE
                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .stroke(Color.vGold.opacity(0.1), lineWidth: 1)
                                .frame(width: 210, height: 210)
                            
                            Circle()
                                .trim(from: 0, to: 0.84)
                                .stroke(Color.vGoldGradient, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                .frame(width: 210, height: 210)
                                .rotationEffect(.degrees(-90))
                                .shadow(color: Color.vGold.opacity(0.3), radius: 10)
                            
                            VStack(spacing: -5) {
                                Text("84")
                                    .font(.system(size: 84, weight: .ultraLight, design: .serif))
                                    .foregroundColor(.white)
                                
                                Text("ELITE INDEX")
                                    .font(.system(size: 10, weight: .bold))
                                    .tracking(4)
                                    .foregroundColor(.vGold)
                            }
                        }
                    }
                    
                    // MARK: - 3. THE UNLOCKED GRID
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ProVaultCard(icon: "paintpalette.fill", title: "COLOR DNA") {
                            HStack(spacing: 6) {
                                Circle().fill(Color.black).frame(width: 14, height: 14)
                                Circle().fill(Color.gray).frame(width: 14, height: 14)
                                Circle().fill(Color.vGold).frame(width: 14, height: 14)
                                Circle().fill(Color.white).frame(width: 14, height: 14)
                            }
                        }
                        
                        ProVaultCard(icon: "tshirt.fill", title: "SIGNATURE") {
                            Text("OLD MONEY LUXE")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        ProVaultCard(icon: "bolt.shield.fill", title: "SYNERGY") {
                            Text("OPTIMIZED")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundColor(Color.green.opacity(0.8))
                        }
                        
                        ProVaultCard(icon: "calendar.badge.checkmark", title: "READY") {
                            Text("92% MATCH")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // MARK: - 4. INSIGHTS PREVIEW
                    VStack(alignment: .leading, spacing: 15) {
                        Text("WEEKLY ANALYSIS")
                            .font(.system(size: 10, weight: .bold))
                            .tracking(2)
                            .foregroundColor(.vGold)
                        
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.03))
                            .frame(height: 100)
                            .overlay(
                                Text("Your aesthetic consistency has improved by 12% this week.")
                                    .font(.system(size: 12, weight: .light, design: .serif))
                                    .foregroundColor(.white.opacity(0.7))
                                    .padding()
                            )
                    }
                    .padding(.horizontal, 24)
                    
                    // MARK: - 5. UPGRADE TO ATELIER (NEW)
                    Button(action: {}) {
                        HStack(spacing: 8) {
                            Image(systemName: "sparkles")
                                .foregroundColor(.vGold)
                            Text("UPGRADE TO VESTO ATELIER")
                                .font(.system(size: 10, weight: .bold))
                                .tracking(1.5)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.white.opacity(0.02))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.vGold.opacity(0.4), lineWidth: 1)
                        )
                        .cornerRadius(4)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 10)
                    
                    Spacer(minLength: 50)
                }
            }
        }
    }
}

// Pro Card Component
struct ProVaultCard<Content: View>: View {
    let icon: String
    let title: String
    let content: Content
    
    init(icon: String, title: String, @ViewBuilder content: () -> Content) {
        self.icon = icon
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 12))
                    .foregroundColor(.vGold)
                Text(title)
                    .font(.system(size: 9, weight: .bold))
                    .tracking(1)
                    .foregroundColor(.white.opacity(0.4))
            }
            
            content
                .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(height: 100)
        .background(Color.white.opacity(0.02))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.vGold.opacity(0.15), lineWidth: 0.5)
        )
    }
}

#Preview {
    VestoProProfileView()
}
