//  attelierelite.swift
//  vestoAi for design
//
//  Created by Kanan on 24.03.26.
//

import SwiftUI

extension Color {
    static let atelierBlack = Color(red: 3/255, green: 3/255, blue: 3/255)
    static let atelierGold = Color(red: 230/255, green: 190/255, blue: 100/255)
    static let platinumWhite = Color(white: 0.95)
    
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
            
            Circle()
                .fill(Color.atelierGold.opacity(0.03))
                .blur(radius: 100)
                .offset(x: -100, y: -200)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 35) {
                    
                    // MARK: - THE ATELIER HEADER
                    HStack(spacing: 20) {
                        ZStack {
                            Circle()
                                .stroke(Color.liquidGold, lineWidth: 0.5)
                                .frame(width: 80, height: 80)
                            Text("JV")
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
                    .padding(.top, 20)
                    
                    // MARK: - THE LIQUID GAUGE
                    ZStack {
                        Circle()
                            .stroke(Color.white.opacity(0.03), lineWidth: 1)
                            .frame(width: 210, height: 210)
                        
                        Circle()
                            .trim(from: 0, to: 0.94)
                            .stroke(Color.liquidGold, style: StrokeStyle(lineWidth: 1.5, lineCap: .round))
                            .frame(width: 210, height: 210)
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
                    
                    // MARK: - THE ATELIER GRID (Unified with Pro/Free)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        
                        AtelierVaultCard(icon: "paintpalette.fill", title: "MATERIAL DNA", status: "LIVE") {
                            HStack(spacing: 6) {
                                Circle().fill(Color.black).frame(width: 14, height: 14)
                                Circle().fill(Color.gray).frame(width: 14, height: 14)
                                Circle().fill(Color.atelierGold).frame(width: 14, height: 14)
                                Circle().fill(Color.white).frame(width: 14, height: 14)
                            }
                        }
                        
                        AtelierVaultCard(icon: "tshirt.fill", title: "SIGNATURE", status: "VERIFIED") {
                            Text("OLD MONEY LUXE")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        AtelierVaultCard(icon: "bolt.shield.fill", title: "SYNERGY ENGINE", status: "DEEP MATCH") {
                            Text("REAL-TIME")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundColor(Color.green.opacity(0.9))
                        }
                        
                        AtelierVaultCard(icon: "infinity", title: "DIGITAL VAULT", status: "ACTIVE") {
                            Text("UNLIMITED")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // MARK: - CONCIERGE QUICK ACCESS
                    Button(action: {}) {
                        HStack(spacing: 10) {
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
                    .padding(.top, 10)
                    
                    Spacer(minLength: 50)
                }
            }
        }
    }
}

// MARK: - Atelier Unified Card Component
struct AtelierVaultCard<Content: View>: View {
    let icon: String
    let title: String
    let status: String
    let content: Content
    
    init(icon: String, title: String, status: String, @ViewBuilder content: () -> Content) {
        self.icon = icon
        self.title = title
        self.status = status
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 12))
                    .foregroundColor(.atelierGold)
                Text(title)
                    .font(.system(size: 9, weight: .bold))
                    .tracking(1)
                    .foregroundColor(.white.opacity(0.4))
                
                Spacer()
                
                // Atelier xüsusi "Canlı Status" indikatoru
                Text(status)
                    .font(.system(size: 7, weight: .heavy))
                    .foregroundColor(.atelierGold)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(Color.atelierGold.opacity(0.1))
                    .cornerRadius(2)
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
                .stroke(Color.liquidGold, lineWidth: 0.3)
        )
    }
}

#Preview {
    VestoAtelierView()
}
