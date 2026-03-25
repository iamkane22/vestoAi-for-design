import SwiftUI

struct VerdictViewMain:  View {
    let capturedImage: UIImage?
    let analysis: VestoAnalysis
    
    @State private var isPremium: Bool = false // Münsiflər üçün kilidli saxlayırıq
    @State private var scoreAnimation: Double = 0
    
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22) // #D4B138 - Elit Qızıl
    
    var body: some View {
        ZStack {
            // 1. ARXA FON: "Liquid Depth" & Vignette
            Color.black.edgesIgnoringSafeArea(.all)
            
            if let img = capturedImage {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 10)
                    .opacity(0.6)
                    .overlay(
                        // Vignette effekti üçün tünd gradient
                        RadialGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
                                       center: .center, startRadius: 100, endRadius: 500)
                    )
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 35) {
                    // HEADER: Minimalist Elegance
                    VStack(spacing: 5) {
                        Text("STYLE VERDICT")
                            .font(.system(size: 14, weight: .ultraLight))
                            .tracking(10)
                            .foregroundColor(vestoGold)
                        Text("MARCH 2026 EDITION")
                            .font(.system(size: 8, weight: .thin))
                            .foregroundColor(.white.opacity(0.4))
                    }
                    .padding(.top, 40)
                    
                    // 2. SCORE RING: "The Halo Glow"
                    scoreRingSection
                    
                    // 3. AI VERDICT: Serif Typography
                    Text("\"\(analysis.verdict)\"")
                        .font(.system(size: 19, weight: .light, design: .serif))
                        .italic()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .lineSpacing(4)
                    
                    // 4. DATA ROWS: Minimalist Icons & Elite Lock
                    VStack(spacing: 0) {
                        DetailRow(icon: "tshirt", title: "AESTHETIC VIBE", value: analysis.vibe, isLocked: false)
                        DetailRow(icon: "paintpalette", title: "COLOR HARMONY", value: analysis.colorHarmony, isLocked: false)
                        DetailRow(icon: "calendar", title: "OCCASION MATCH", value: analysis.occasion, isLocked: !isPremium)
                        DetailRow(icon: "clock", title: "UPGRADE THE LOOK", value: analysis.upgrade, isLocked: !isPremium)
                        DetailRow(icon: "briefcase", title: "VAULT SYNERGY", value: "Matches 3 Items", isLocked: !isPremium)
                    }
                    .background(Color.white.opacity(0.04))
                    .cornerRadius(20)
                    .padding(.horizontal, 25)
                    
                    // 5. ACTION BUTTONS: Elite Space
                    VStack(spacing: 15) {
                        if !isPremium {
                            Button(action: { isPremium.toggle() }) {
                                Text("UNLOCK ELITE INSIGHTS")
                                    .font(.system(size: 13, weight: .bold)).tracking(2)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 18)
                                    .background(vestoGold)
                                    .cornerRadius(12)
                            }
                        }
                        
                        Button(action: { /* Share Card Logic */ }) {
                            Text("SHARE STYLE CARD")
                                .font(.system(size: 12, weight: .bold)).tracking(2)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 18)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.2)))
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 50)
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.5)) {
                scoreAnimation = Double(analysis.score) / 100.0
            }
        }
    }
    
    var scoreRingSection: some View {
        ZStack {
            // Arxa dairə (zəif iz)
            Circle()
                .stroke(Color.white.opacity(0.05), lineWidth: 6)
                .frame(width: 160, height: 160)
            
            // Halo Glow effektli əsas dairə
            Circle()
                .trim(from: 0, to: scoreAnimation)
                .stroke(
                    LinearGradient(colors: [vestoGold, .white.opacity(0.8), vestoGold], startPoint: .topLeading, endPoint: .bottomTrailing),
                    style: StrokeStyle(lineWidth: 6, lineCap: .round)
                )
                .frame(width: 160, height: 160)
                .rotationEffect(.degrees(-90))
                .shadow(color: vestoGold.opacity(0.5), radius: 15)
            
            VStack(spacing: -5) {
                Text("\(Int(scoreAnimation * 100))")
                    .font(.system(size: 64, weight: .ultraLight, design: .serif))
                Text("MATCH SCORE")
                    .font(.system(size: 10, weight: .light)).tracking(4).opacity(0.5)
            }
            .foregroundColor(.white)
        }
    }
}

// Minimalist Sətir Dizaynı
struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    let isLocked: Bool
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(vestoGold.opacity(0.7))
            
            Text(title)
                .font(.system(size: 10, weight: .regular)).tracking(1)
                .foregroundColor(.white.opacity(0.4))
            
            Spacer()
            
            if isLocked {
                HStack(spacing: 4) {
                    Image(systemName: "lock.fill").font(.system(size: 8))
                    Text("ELITE").font(.system(size: 9, weight: .bold))
                }
                .foregroundColor(vestoGold)
                .padding(.vertical, 4).padding(.horizontal, 8)
                .background(vestoGold.opacity(0.12)).cornerRadius(4)
            } else {
                Text(value)
                    .font(.system(size: 13, weight: .light))
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 20).padding(.horizontal, 20)
        .overlay(Divider().background(Color.white.opacity(0.05)), alignment: .bottom)
    }
}

// XƏTASIZ PREVIEW
#Preview {
    let sampleAnalysis = VestoAnalysis(
        score: 94,
        vibe: "Quiet Luxury",
        colorHarmony: "Flawless",
        occasion: "Gala Dinner",
        upgrade: "Add a silver watch",
        verdict: "Zövqü pulla almaq olmur, amma bu harmoniya tam bir səssiz lüksdür.",
        vaultMatchCount: 3
    )
    
    // Artıq 'return' yazmağa ehtiyac yoxdur, birbaşa View-nu çağır:
    VerdictViewMain(
        capturedImage: UIImage(named: "test_model"), // Test üçün nil qoyduq
        analysis: sampleAnalysis
    )
    .preferredColorScheme(.dark)
}
