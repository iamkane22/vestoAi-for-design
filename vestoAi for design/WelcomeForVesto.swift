import SwiftUI

struct FinalEliteWelcomeView: View {
    var body: some View {
        ZStack {
            // 1. OBSIDIAN DEPTH: Sonsuzluq Hissi
            LinearGradient(gradient: Gradient(colors: [
                Color(hex: "#080808"),
                Color(hex: "#000000")
            ]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            // Fondakı mikroskopik tekstura
            RadialGradient(gradient: Gradient(colors: [Color.vestoGold.opacity(0.04), .clear]),
                           center: .center, startRadius: 1, endRadius: 800)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                
                Spacer()
                
                // --- A. THE EMBLEM: Mücrüdəki Cavahir
                ZStack {
                    Circle()
                        .fill(Color.vestoGold.opacity(0.08))
                        .frame(width: 250, height: 250)
                        .blur(radius: 80)
                    
                    Circle()
                        .stroke(
                            LinearGradient(colors: [Color.vestoGold.opacity(0.6), Color.vestoGold.opacity(0.05)],
                                           startPoint: .topLeading, endPoint: .bottomTrailing),
                            lineWidth: 0.4
                        )
                        .frame(width: 110, height: 110)
                    
                    Text("V")
                        .font(.system(size: 42, weight: .ultraLight, design: .serif))
                        .foregroundColor(.vestoGold) // Loqo Qızılı
                        .offset(y: -1)
                }
                .padding(.bottom, 45)
                
                // --- B. THE TYPOGRAPHY: Monolit Balans
                VStack(spacing: 18) {
                    HStack(spacing: 0) {
                        Text("VESTO")
                            .font(.system(size: 32, weight: .regular, design: .serif))
                            .kerning(16)
                            .foregroundColor(.white)
                        
                        Text(" AI")
                            .font(.system(size: 32, weight: .ultraLight, design: .serif))
                            .kerning(22)
                            .foregroundColor(.vestoGold) // Tam eyni Hex tonu
                    }
                    .offset(x: 8)
                    
                    // "Geniş" Nəfəs Alan Kursiv Sloqan
                    Text("Your Private AI Stylist")
                        .font(.system(size: 14, weight: .ultraLight, design: .serif))
                        .kerning(4.5) // 2-3% artırılmış məsafə
                        .italic()
                        .foregroundColor(Color.white.opacity(0.45))
                }
                .padding(.bottom, 45)
                
                // --- C. PAGINATOR: Qızıl Üzük
                HStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .stroke(Color.vestoGold.opacity(0.8), lineWidth: 0.4)
                            .frame(width: 12, height: 12)
                        Circle()
                            .fill(Color.vestoGold)
                            .frame(width: 4, height: 4)
                    }
                    Circle().fill(Color.white.opacity(0.12)).frame(width: 4, height: 4)
                    Circle().fill(Color.white.opacity(0.12)).frame(width: 4, height: 4)
                }

                Spacer()
                
                // --- D. THE FOOTER: Təmiz Pıçıltı
                Text("CURATED INTELLIGENCE")
                    .font(.system(size: 8.5, weight: .ultraLight))
                    .kerning(7)
                    .foregroundColor(Color.white.opacity(0.32)) // Maksimum parlaqlıqda aydın
                    .padding(.bottom, 45)
            }
        }
    }
}

#Preview {
    FinalEliteWelcomeView()
}
