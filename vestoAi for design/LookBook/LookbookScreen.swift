//
//  LookbookScreen.swift
//  vestoAi for design
//
//  Created by Kenan on 25.03.26.
//

import SwiftUI

struct Lookbook: View {
    @State private var selectedAesthetic = "OLD MONEY"
    let aesthetics = ["OLD MONEY", "MINIMALIST", "URBAN"]
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                // STYLE SELECTOR (İstifadəçinin seçimi)
                HStack(spacing: 15) {
                    ForEach(aesthetics, id: \.self) { style in
                        Button(action: { selectedAesthetic = style }) {
                            Text(style)
                                .font(.system(size: 10, weight: .bold))
                                .tracking(2)
                                .foregroundColor(selectedAesthetic == style ? .black : .white.opacity(0.6))
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .background(selectedAesthetic == style ? vestoGold : Color.white.opacity(0.05))
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.top, 20)
                
                // MAIN DAILY CARD
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white.opacity(0.03))
                        .overlay(
                            VStack {
                                Image(systemName: "sparkles")
                                    .foregroundColor(vestoGold.opacity(0.5))
                                    .font(.system(size: 40))
                                Text("YOUR \(selectedAesthetic) LOOK IS READY")
                                    .font(.system(size: 12, weight: .ultraLight))
                                    .tracking(3)
                                    .foregroundColor(.white.opacity(0.7))
                                    .padding(.top, 10)
                            }
                        )
                    
                    // Score & Info
                    HStack {
                        VStack(alignment: .leading) {
                            Text("THE SIGNATURE LUXE")
                                .font(.system(size: 16, weight: .bold))
                            Text("Based on your Vault items")
                                .font(.system(size: 10))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("94%")
                            .font(.system(size: 24, weight: .thin))
                            .foregroundColor(vestoGold)
                    }
                    .padding(25)
                    .background(Color.white.opacity(0.05))
                }
                .frame(maxHeight: .infinity)
                .cornerRadius(30)
                .padding(.horizontal, 25)
                .padding(.bottom, 40)
            }
        }
    }
}


#Preview {
    Lookbook()
}
