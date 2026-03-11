import SwiftUI

// MARK: - RƏNG SİSTEMİ
extension Color {
    static let uiVestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)
    static let uiVestoDarkGold = Color(red: 0.6, green: 0.48, blue: 0.08)
}

// MARK: - TAB BAR FORMASI
struct VestoTabShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let holeWidth: CGFloat = 85
        let holeHeight: CGFloat = 32
        let center = rect.width / 2
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: center - holeWidth/2 - 20, y: 0))
        
        path.addCurve(to: CGPoint(x: center, y: holeHeight),
                      control1: CGPoint(x: center - holeWidth/2 + 10, y: 0),
                      control2: CGPoint(x: center - holeWidth/2 + 15, y: holeHeight))
        
        path.addCurve(to: CGPoint(x: center + holeWidth/2 + 20, y: 0),
                      control1: CGPoint(x: center + holeWidth/2 - 15, y: holeHeight),
                      control2: CGPoint(x: center + holeWidth/2 - 10, y: 0))
        
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}

// MARK: - ƏSAS KONTEYNER
struct VestoMainTabContainer: View {
    @State private var selectedTab = 2
    @State private var isBreathing = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            Group {
                if selectedTab == 0 { VaultView() }
                else if selectedTab == 1 { LookbookView() }
                else if selectedTab == 2 { HomeVisionView() }
                else if selectedTab == 3 { ConciergeView() }
                else { AtelierView() }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // TAB BAR LAYER
            ZStack(alignment: .bottom) {
                VestoTabShape()
                    .fill(.ultraThinMaterial)
                    .environment(\.colorScheme, .dark)
                    .frame(height: 100)
                    .overlay(
                        // 1. HƏLL: O Kəskin Xəttin Gradientlə Yumşaldılması
                        VestoTabShape()
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        .clear,
                                        .uiVestoGold.opacity(0.1),
                                        .uiVestoGold.opacity(0.5), // Mərkəzdə işıq vuran qızılı
                                        .uiVestoGold.opacity(0.1),
                                        .clear
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 0.8 // Bir az daha dolğun amma dumanlı
                            )
                    )
                
                HStack(spacing: 0) {
                    LuxuryTabButton(index: 0, icon: "hanger", label: "VAULT", selectedTab: $selectedTab)
                    LuxuryTabButton(index: 1, icon: "rectangle.stack", label: "LOOKBOOK", selectedTab: $selectedTab)
                    
                    VestoVisionCenter(isBreathingVal: isBreathing)
                        .onTapGesture {
                            selectedTab = 2
                            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                        }
                        .offset(y: -18)
                    
                    LuxuryTabButton(index: 3, icon: "sparkles", label: "CONCIERGE", selectedTab: $selectedTab)
                    LuxuryTabButton(index: 4, icon: "person.crop.circle", label: "ATELIER", selectedTab: $selectedTab)
                }
                .padding(.horizontal, 5)
                .padding(.bottom, 30)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                isBreathing = true
            }
        }
    }
}

// MARK: - KOMPONENTLƏR
struct LuxuryTabButton: View {
    let index: Int; let icon: String; let label: String; @Binding var selectedTab: Int
    var body: some View {
        Button(action: { withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) { selectedTab = index } }) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 19, weight: selectedTab == index ? .regular : .light))
                Text(label)
                    .font(.system(size: 7.5, weight: .bold)) // Font bir az böyüdüldü
                    .kerning(1.8)
            }
            // 2. HƏLL: İkon Balansı (Şəffaflıq 0.4-dən 0.6-ya qaldırıldı)
            .foregroundColor(selectedTab == index ? .uiVestoGold : .white.opacity(0.6))
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle()) // Bütün sahəni toxunula bilən edir
        }
    }
}

struct VestoVisionCenter: View {
    let isBreathingVal: Bool
    var body: some View {
        ZStack {
            // Düymənin ətrafındakı atmosferik parıltı (Glow)
            Circle()
                .fill(Color.uiVestoGold.opacity(0.15))
                .frame(width: 80, height: 80)
                .blur(radius: isBreathingVal ? 12 : 6)
            
            Circle()
                .fill(LinearGradient(colors: [.uiVestoGold, .uiVestoDarkGold], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 62, height: 62)
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.25), lineWidth: 0.5) // Üst tərəfdən düşən zəif işıq
                )
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            
            Image(systemName: "viewfinder")
                .font(.system(size: 24, weight: .light))
                .foregroundColor(.black.opacity(0.8))
        }
    }
}

// MARK: - MÜVƏQQƏTİ SAHƏLƏR
struct VaultView: View { var body: some View { Color.black.overlay(Text("VAULT").foregroundColor(.white)) } }
struct LookbookView: View { var body: some View { Color.black.overlay(Text("LOOKBOOK").foregroundColor(.white)) } }
struct HomeVisionView: View { var body: some View { Color.black.overlay(Text("VESTO VISION").foregroundColor(.white)) } }
struct ConciergeView: View { var body: some View { Color.black.overlay(Text("CONCIERGE").foregroundColor(.white)) } }
struct AtelierView: View { var body: some View { Color.black.overlay(Text("ATELIER").foregroundColor(.white)) } }

#Preview {
    VestoMainTabContainer()
        .preferredColorScheme(.dark)
}
