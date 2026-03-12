import SwiftUI

import SwiftUI

struct VerdictView: View {
    @State private var isPremium: Bool = true // Test üçün true/false dəyişə bilərsən
    @State private var scoreAnimation: Double = 0
    @State private var showSubscription = false
    
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)
    
    // AI-ın viral cümləsi
    let aiQuote = "Zövqü pulla almaq olmur, amma bu harmoniya tam bir səssiz lüksdür."
    
    var body: some View {
        ZStack {
            // Arxa fon
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                // HEADER
                Text("STYLE VERDICT")
                    .font(.system(size: 14, weight: .ultraLight))
                    .tracking(10)
                    .foregroundColor(vestoGold)
                    .padding(.top, 20)
                
                // 1. STYLE SCORE RING
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.05), lineWidth: 8)
                        .frame(width: 180, height: 180)
                    
                    Circle()
                        .trim(from: 0, to: scoreAnimation)
                        .stroke(vestoGold, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .frame(width: 180, height: 180)
                        .rotationEffect(.degrees(-90))
                    
                    VStack(spacing: -5) {
                        Text("\(Int(scoreAnimation * 100))")
                            .font(.system(size: 55, weight: .thin, design: .serif))
                        Text("MATCH SCORE")
                            .font(.system(size: 10, weight: .light))
                            .tracking(3)
                            .opacity(0.6)
                    }
                    .foregroundColor(.white)
                }
                .padding(.top, 10)
                
                // 2. THE AI QUOTE (Lüks tənqid mətni)
                Text("\"\(aiQuote)\"")
                    .font(.system(size: 15, weight: .light, design: .serif))
                    .italic()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    .lineSpacing(4)
                
                // 3. ANALİZ DETALLARI
                VStack(spacing: 5) {
                    DetailRow(title: "AESTHETIC VIBE", value: "Quiet Luxury", isLocked: false)
                    DetailRow(title: "COLOR HARMONY", value: "Flawless", isLocked: false)
                    
                    // Premium Kilidli Hissələr
                    DetailRow(title: "OCCASION MATCH", value: "Michelin Star Dinner", isLocked: !isPremium)
                    DetailRow(title: "UPGRADE THE LOOK", value: "Add Leather Watch", isLocked: !isPremium)
                    DetailRow(title: "VAULT SYNERGY", value: "Matches 3 Items", isLocked: !isPremium)
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                // 4. ACTION BUTTONS
                VStack(spacing: 15) {
                    if !isPremium {
                        premiumUpgradeButton
                    }
                    
                    shareButton
                }
                .padding(.bottom, 30)
            }
        }
        .sheet(isPresented: $showSubscription) {
            SubscriptionView() // Əvvəlki mesajda yazdığımız Paywall ekranı
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.2)) {
                scoreAnimation = 0.94
            }
        }
    }
    
    // Premium Upgrade Düyməsi
    var premiumUpgradeButton: some View {
        Button(action: { showSubscription = true }) {
            HStack {
                Image(systemName: "crown.fill")
                Text("UNLOCK ELITE INSIGHTS")
                    .font(.system(size: 12, weight: .bold))
                    .tracking(2)
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(vestoGold)
            .cornerRadius(12)
            .padding(.horizontal, 40)
        }
    }
    
    // Paylaşım Düyməsi (Həmişə aktivdir)
    var shareButton: some View {
        Button(action: {
            // Paylaşım funksiyası bura gələcək
        }) {
            Text(isPremium ? "SHARE ELITE CARD" : "SHARE STYLE CARD")
                .font(.system(size: 12, weight: .bold))
                .tracking(2)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.2)))
                .padding(.horizontal, 40)
        }
    }
}

// Detal Sətri Komponenti
struct DetailRow: View {
    let title: String
    let value: String
    let isLocked: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 11, weight: .regular))
                .tracking(1)
                .foregroundColor(.white.opacity(0.4))
            Spacer()
            
            if isLocked {
                HStack(spacing: 5) {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 10))
                        .foregroundColor(Color(red: 0.83, green: 0.69, blue: 0.22))
                    Text("ELITE")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(Color(red: 0.83, green: 0.69, blue: 0.22))
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(Color(red: 0.83, green: 0.69, blue: 0.22).opacity(0.1))
                .cornerRadius(4)
            } else {
                Text(value)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 14)
        .overlay(Divider().background(Color.white.opacity(0.08)), alignment: .bottom)
    }
}

#Preview {
    VerdictView()
}
