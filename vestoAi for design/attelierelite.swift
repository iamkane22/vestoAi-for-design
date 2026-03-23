//
//  attelierelite.swift
//  vestoAi for design
//
//  Created by Kenan on 24.03.26.
//

import SwiftUI

// 1. Atelier Səviyyəli Premium Rənglər
extension Color {
    static let atelierBlack = Color(red: 3/255, green: 3/255, blue: 3/255)
    static let atelierGold = Color(red: 230/255, green: 190/255, blue: 100/255)
    static let platinumWhite = Color(white: 0.95)
    
    // Maye Qızıl Effekti üçün Qradyan
    static let liquidGold = LinearGradient(
        gradient: Gradient(colors: [Color(hex: "E6BE64"), Color(hex: "FFF9E3"), Color(hex: "B8860B")]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

struct VestoAtelierView: View {
    var body: some View {
        ZStack {
            Color.atelierBlack.ignoresSafeArea()
            
            // Arxa fonda incə, hərəkətli "Mesh Gradient" (Atelier Hissiyatı)
            Circle()
                .fill(Color.atelierGold.opacity(0.03))
                .blur(radius: 100)
                .offset(x: -100, y: -200)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    
                    // MARK: - THE ATELIER HEADER
                    HStack(spacing: 20) {
                        ZStack {
                            Circle()
                                .stroke(Color.liquidGold, lineWidth: 0.5)
                                .frame(width: 80, height: 80)
                            Text("JV") // - Julian Vane (Kanan)
                                .font(.system(size: 24, weight: .light, design: .serif))
                                .foregroundColor(.platinumWhite)
                        }
                        .shadow(color: Color.atelierGold.opacity(0.2), radius: 10)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Julian Vane")
                                .font(.system(size: 22, weight: .medium, design: .serif))
                                .foregroundColor(.white)
                            
                            HStack {
                                Image(systemName: "laurel.leading")
                                Text("ATELIER MEMBER")
                                    .font(.system(size: 10, weight: .bold))
                                    .tracking(2)
                                Image(systemName: "laurel.trailing")
                            }
                            .foregroundColor(.atelierGold)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 30)
                    
                    // MARK: - THE LIQUID GAUGE (Top 1% Stats)
                    ZStack {
                        Circle()
                            .stroke(Color.white.opacity(0.03), lineWidth: 1)
                            .frame(width: 220, height: 220)
                        
                        // "Liquid" Progress Ring
                        Circle()
                            .trim(from: 0, to: 0.94)
                            .stroke(Color.liquidGold, style: StrokeStyle(lineWidth: 1, lineCap: .round))
                            .frame(width: 220, height: 220)
                            .rotationEffect(.degrees(-90))
                        
                        VStack(spacing: -2) {
                            Text("94")
                                .font(.system(size: 90, weight: .ultraLight, design: .serif))
                                .foregroundColor(.white)
                            
                            Text("GLOBAL PERCENTILE")
                                .font(.system(size: 9, weight: .bold))
                                .tracking(3)
                                .foregroundColor(.atelierGold)
                        }
                    }
                    
                    // MARK: - THE ATELIER VAULT (Unlimited)
                    VStack(alignment: .leading, spacing: 20) {
                        Text("ATELIER SERVICES")
                            .font(.system(size: 10, weight: .bold))
                            .tracking(3)
                            .foregroundColor(.white.opacity(0.3))
                            .padding(.horizontal, 24)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            
                            AtelierCard(icon: "sparkles", title: "PRIORITY SCANS", value: "UNLIMITED")
                            AtelierCard(icon: "brain.headset", title: "VIP CONCIERGE", value: "ACTIVE")
                            AtelierCard(icon: "chart.xyaxis.line", title: "TREND DATA", value: "LIVE")
                            AtelierCard(icon: "infinity", title: "DIGITAL VAULT", value: "NO LIMIT")
                        }
                        .padding(.horizontal, 24)
                    }
                    
                    // MARK: - CONCIERGE QUICK ACCESS
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "message.fill")
                            Text("TALK TO PERSONAL STYLIST")
                                .font(.system(size: 11, weight: .bold))
                                .tracking(1)
                        }
                        .foregroundColor(.atelierBlack)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.liquidGold)
                        .cornerRadius(2)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

// MARK: - Atelier Card Component
struct AtelierCard: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .light))
                .foregroundColor(.atelierGold)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(.white.opacity(0.4))
                
                Text(value)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white.opacity(0.02))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white.opacity(0.05), lineWidth: 0.5))
    }
}

#Preview {
    VestoAtelierView()
}
