//
//  VestoAssets.swift
//  vestoAi for design
//
//  Created by Kenan on 09.03.26.
//

import SwiftUI

// VESTO Global Dizayn Sistemi
extension Color {
    // Lüks Qızılı
    static let vestoGold = Color(hex: "#D4A017")
    static let vestoBlack = Color.black
    static let vestoGray = Color(white: 0.6)
    
    // Bu funksiya YALNIZ burada qalmalıdır!
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: 1)
    }
}

// VestoAssets.swift içində Color extension-dan aşağıda yerləşdir

// VestoAssets.swift - VESTO Global Dizayn Sistemi

// VestoAssets.swift faylına əlavə et (əgər yoxdursa)
struct AtelierInputField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(.system(size: 13, weight: .ultraLight, design: .serif).italic())
                        .foregroundColor(Color(hex: "#D4B996").opacity(0.4))
                        .tracking(1.5)
                }
                if isSecure {
                    SecureField("", text: $text).foregroundColor(.white)
                } else {
                    TextField("", text: $text).foregroundColor(.white)
                }
            }
            Rectangle()
                .fill(LinearGradient(colors: [Color.vestoGold.opacity(0.3), .clear], startPoint: .leading, endPoint: .trailing))
                .frame(height: 0.6)
        }
    }
}
