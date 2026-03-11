//
//  HomeTabbar.swift
//  vestoAi for design
//
//  Created by Kenan on 11.03.26.
//

import SwiftUI

struct PostRegistrationHomeView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 35) {
                
                // 1. ELITE HEADER
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("VESTO ATELIER")
                            .font(.system(size: 10, weight: .bold)).kerning(4)
                            .foregroundColor(.vestoGold)
                        Text("Welcome, Kanan") // Bura istifadəçi adını çəkəcəyik
                            .font(.system(size: 28, weight: .light, design: .serif))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    // Profil şəkli üçün kiçik bir dairə
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 45, height: 45)
                        .overlay(Image(systemName: "person").foregroundColor(.white.opacity(0.5)))
                }
                .padding(.horizontal, 25)
                .padding(.top, 40)
                
                // 2. THE PSYCHOLOGICAL "HOOK" CARD (Stil DNT-si)
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("STYLE DNA")
                            .font(.system(size: 12, weight: .bold)).kerning(2)
                        Spacer()
                        Text("LOCKED")
                            .font(.system(size: 10, weight: .bold))
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(Color.black.opacity(0.2))
                            .cornerRadius(4)
                    }
                    
                    Text("Analyze 3 pieces of your wardrobe to unlock your personalized AI Style Identity.")
                        .font(.system(size: 15, weight: .regular))
                        .lineSpacing(4)
                        .foregroundColor(.black.opacity(0.8))
                    
                    // Progress Bar (Zeigarnik Effect)
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Discovery Progress").font(.system(size: 10, weight: .bold))
                            Spacer()
                            Text("0%").font(.system(size: 10, weight: .bold))
                        }
                        ZStack(alignment: .leading) {
                            Capsule().fill(Color.black.opacity(0.1)).frame(height: 6)
                            Capsule().fill(Color.black).frame(width: 10, height: 6) // Başlanğıc üçün 0
                        }
                    }
                }
                .padding(25)
                .background(Color.vestoGold)
                .cornerRadius(20)
                .padding(.horizontal, 25)
                .shadow(color: .vestoGold.opacity(0.2), radius: 20, x: 0, y: 10)

                // 3. HORIZONTAL QUICK ACTIONS
                VStack(alignment: .leading, spacing: 15) {
                    Text("QUICK ACCESS")
                        .font(.system(size: 10, weight: .bold)).kerning(2)
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.horizontal, 25)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            DashboardActionCard(title: "Scan Item", icon: "plus.viewfinder")
                            DashboardActionCard(title: "AI Trends", icon: "sparkles")
                            DashboardActionCard(title: "My Vault", icon: "ArchiveBox")
                        }
                        .padding(.horizontal, 25)
                    }
                }
                
                Spacer(minLength: 100) // TabBar üçün yer
            }
        }
        .background(Color(hex: "#050505").edgesIgnoringSafeArea(.all))
    }
}

// Köməkçi Vizual Kart
struct DashboardActionCard: View {
    let title: String
    let icon: String
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(.vestoGold)
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white)
        }
        .frame(width: 110, height: 110)
        .background(Color.white.opacity(0.05))
        .cornerRadius(15)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white.opacity(0.1), lineWidth: 1))
    }
}

#Preview {
    PostRegistrationHomeView()
}
