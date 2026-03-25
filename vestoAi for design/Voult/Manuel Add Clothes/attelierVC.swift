import SwiftUI

struct VestoScannerView: View {
    @State private var scanLineOffset: CGFloat = -180
    @State private var isDetecting = false
    
    var body: some View {
        ZStack {
            // 1. CAMERA FEED (Placeholder)
            Rectangle()
                .fill(Color.black)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    Image(systemName: "tshirt") // Kamerada görünən obyekt simvolu
                        .font(.system(size: 150, weight: .ultraLight))
                        .foregroundColor(.white.opacity(0.1))
                )
            
            // 2. THE SCANNING FRAME & LASER
            ZStack {
                // Focus Frame
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.vestoGold.opacity(0.3), lineWidth: 1)
                    .frame(width: 300, height: 450)
                
                // Animated Laser Line
                Rectangle()
                    .fill(
                        LinearGradient(colors: [.clear, .vestoGold, .clear], startPoint: .top, endPoint: .bottom)
                    )
                    .frame(width: 300, height: 2)
                    .offset(y: scanLineOffset)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 2.5).repeatForever(autoreverses: true)) {
                            scanLineOffset = 180
                        }
                    }
            }
            
            // 3. AI DETECTION OVERLAYS (Floating Labels)
            VStack {
                HStack {
                    Capsule()
                        .fill(Color.vestoGold)
                        .frame(width: 80, height: 20)
                        .overlay(Text("AI ACTIVE").font(.system(size: 8, weight: .bold)).foregroundColor(.black))
                    Spacer()
                }
                .padding(.top, 60)
                .padding(.horizontal, 40)
                
                Spacer()
                
                // AI "Düşünür" mesajları
                VStack(spacing: 10) {
                    ScannerTag(text: "FABRIC: PREMIUM COTTON", delay: 0.5)
                    ScannerTag(text: "CUT: MINIMALIST SLIM", delay: 1.0)
                    ScannerTag(text: "SHADE: OBSIDIAN BLACK", delay: 1.5)
                }
                .padding(.bottom, 40)
                
                // THE SHUTTER
                Button(action: {
                    // Capture Logic
                }) {
                    ZStack {
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                            .frame(width: 75, height: 75)
                        Circle()
                            .fill(Color.white)
                            .frame(width: 60, height: 60)
                    }
                }
                .padding(.bottom, 50)
            }
        }
    }
}

// Kiçik AI məlumat etiketləri
struct ScannerTag: View {
    let text: String
    let delay: Double
    @State private var visible = false
    
    var body: some View {
        Text(text)
            .font(.system(size: 9, weight: .bold)).kerning(1)
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(BlurView(style: .systemUltraThinMaterialDark))
            .cornerRadius(5)
            .opacity(visible ? 1 : 0)
            .onAppear {
                withAnimation(.easeIn.delay(delay)) { visible = true }
            }
    }
}

// Glassmorphism effekti üçün köməkçi
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView { UIVisualEffectView(effect: UIBlurEffect(style: style)) }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#Preview {
    VestoScannerView()
}
