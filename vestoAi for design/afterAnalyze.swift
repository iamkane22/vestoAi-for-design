import SwiftUI

struct VerdictViewMain: View {
    let capturedImage: UIImage?
    let analysis: VestoAnalysis
    
    @State private var isPremium: Bool = true // Dinamik status
    @State private var scoreAnimation: Double = 0
    @State private var showSubscription = false
    @State private var isSaved = false
    
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)
    
    var body: some View {
        ZStack {
            // ARXA FON (Şəkil + Blur Overlay)
            if let img = capturedImage {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: isPremium ? 0 : 10) // Premium deyilsə bir az gizli saxla
                    .overlay(Color.black.opacity(0.6))
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    // HEADER
                    HStack {
                        VStack(alignment: .leading) {
                            Text("STYLE VERDICT")
                                .font(.system(size: 14, weight: .ultraLight))
                                .tracking(10)
                                .foregroundColor(vestoGold)
                            Text("MARCH 2026 EDITION")
                                .font(.system(size: 9, weight: .thin))
                                .foregroundColor(.white.opacity(0.6))
                        }
                        Spacer()
                        if isPremium {
                            Image(systemName: "crown.fill").foregroundColor(vestoGold)
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    
                    // SCORE RING
                    scoreRingSection
                    
                    // AI VERDICT QUOTE
                    Text("\"\(analysis.verdict)\"")
                        .font(.system(size: 18, weight: .light, design: .serif))
                        .italic()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                    
                    // ANALİZ DETALLARI (PREMIUM MƏNTİQİ İLƏ)
                    VStack(spacing: 0) {
                        DetailRow(title: "AESTHETIC VIBE", value: analysis.vibe, isLocked: false)
                        DetailRow(title: "COLOR HARMONY", value: analysis.colorHarmony, isLocked: false)
                        
                        // Kilidli Hissələr
                        DetailRow(title: "OCCASION MATCH", value: analysis.occasion, isLocked: !isPremium)
                        DetailRow(title: "UPGRADE THE LOOK", value: analysis.upgrade, isLocked: !isPremium)
                        DetailRow(title: "VAULT SYNERGY", value: "Matches \(analysis.vaultMatchCount) Items", isLocked: !isPremium)
                    }
                    .background(Color.white.opacity(0.03))
                    .cornerRadius(20)
                    .padding(.horizontal, 25)
                    
                    // SAVE TO VAULT BUTTON (Premium funksiya)
                    if isPremium {
                        Button(action: { isSaved.toggle() }) {
                            HStack {
                                Image(systemName: isSaved ? "checkmark.seal.fill" : "plus.square.on.square")
                                Text(isSaved ? "SAVED TO VAULT" : "ADD TO DIGITAL WARDROBE")
                            }
                            .font(.system(size: 12, weight: .bold)).tracking(1)
                            .foregroundColor(isSaved ? .green : vestoGold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(vestoGold.opacity(0.1))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(vestoGold.opacity(0.3)))
                        }
                        .padding(.horizontal, 40)
                    }
                    
                    // ACTION BUTTONS
                    VStack(spacing: 15) {
                        if !isPremium {
                            Button(action: { showSubscription = true }) {
                                Text("UNLOCK ELITE INSIGHTS")
                                    .font(.system(size: 13, weight: .bold)).tracking(2)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 18)
                                    .background(vestoGold)
                                    .cornerRadius(12)
                            }
                        }
                        
                        Button(action: { /* Share */ }) {
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
        .sheet(isPresented: $showSubscription) {
            Text("Subscription View") // Bura sənin Paywall ekranın gələcək
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0)) {
                scoreAnimation = Double(analysis.score) / 100.0
            }
        }
    }
    
    var scoreRingSection: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.05), lineWidth: 8)
                .frame(width: 170, height: 170)
            Circle()
                .trim(from: 0, to: scoreAnimation)
                .stroke(vestoGold, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .frame(width: 170, height: 170)
                .rotationEffect(.degrees(-90))
                .shadow(color: vestoGold.opacity(0.3), radius: 15)
            
            VStack(spacing: -5) {
                Text("\(Int(scoreAnimation * 100))")
                    .font(.system(size: 55, weight: .thin, design: .serif))
                Text("MATCH SCORE")
                    .font(.system(size: 10, weight: .light)).tracking(3).opacity(0.6)
            }
            .foregroundColor(.white)
        }
    }
}

// DETAL SƏTRİ (Locked məntiqi bərpa olundu)
struct DetailRow: View {
    let title: String
    let value: String
    let isLocked: Bool
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 10, weight: .regular)).tracking(1)
                .foregroundColor(.white.opacity(0.4))
            Spacer()
            
            if isLocked {
                HStack(spacing: 4) {
                    Image(systemName: "lock.fill").font(.system(size: 9))
                    Text("ELITE").font(.system(size: 10, weight: .bold))
                }
                .foregroundColor(vestoGold)
                .padding(.vertical, 4).padding(.horizontal, 8)
                .background(vestoGold.opacity(0.1)).cornerRadius(4)
            } else {
                Text(value)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 18).padding(.horizontal, 20)
        .overlay(Divider().background(Color.white.opacity(0.05)), alignment: .bottom)
    }
}
// MARK: - PREVIEW DÜZƏLİŞİ
// MARK: - PREVIEW DÜZƏLİŞİ
#Preview {
    // 1. Öncə saxta bir analiz obyekti yaradırıq (Modeldəki bütün sahələr olmalıdır)
    let sampleAnalysis = VestoAnalysis(
        score: 94,
        vibe: "Quiet Luxury",
        colorHarmony: "Flawless",
        occasion: "Gala Dinner",
        upgrade: "Add a silver watch",
        verdict: "Zövqü pulla almaq olmur, amma bu harmoniya tam bir səssiz lüksdür.",
        vaultMatchCount: 3
    )
    
    // 2. 'return' sözünü sildik!
    // SwiftUI avtomatik olaraq sondakı View-nu render edəcək.
    VerdictViewMain(
        capturedImage: UIImage(named: "test_model"),
        analysis: sampleAnalysis
    )
}
