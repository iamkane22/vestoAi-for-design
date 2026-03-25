import SwiftUI
import PhotosUI

struct VestoScannerView: View {
    @Environment(\.dismiss) var dismiss
    @State private var scanLineOffset: CGFloat = -180
    @State private var isDetecting = false
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)
    
    var body: some View {
        ZStack {
            // 1. CAMERA FEED (Placeholder)
            Rectangle()
                .fill(Color.black)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    Image(systemName: "tshirt")
                        .font(.system(size: 150, weight: .ultraLight))
                        .foregroundColor(.white.opacity(0.1))
                )
            
            // 2. TOP BAR (X Düyməsi)
            VStack {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(.white)
                            .padding(20)
                    }
                    Spacer()
                }
                Spacer()
            }
            .zIndex(2)
            
            // 3. SCANNING FRAME & LASER
            ZStack {
                RoundedRectangle(cornerRadius: 2)
                    .stroke(vestoGold.opacity(0.3), lineWidth: 1)
                    .frame(width: 300, height: 450)
                
                Rectangle()
                    .fill(
                        LinearGradient(colors: [.clear, vestoGold, .clear], startPoint: .top, endPoint: .bottom)
                    )
                    .frame(width: 300, height: 2)
                    .offset(y: scanLineOffset)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 2.5).repeatForever(autoreverses: true)) {
                            scanLineOffset = 180
                        }
                    }
            }
            
            // 4. BOTTOM CONTROLS
            VStack {
                Spacer()
                
                VStack(spacing: 10) {
                    ScannerTag(text: "FABRIC: PREMIUM COTTON", delay: 0.5)
                    ScannerTag(text: "CUT: MINIMALIST SLIM", delay: 1.0)
                }
                .padding(.bottom, 30)
                
                HStack(spacing: 40) {
                    // QALEREYA DÜYMƏSİ
                    PhotosPicker(selection: $selectedPhotoItem, matching: .images, photoLibrary: .shared()) {
                        Image(systemName: "photo.on.rectangle")
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(.white)
                    }
                    
                    // ÇƏKMƏK DÜYMƏSİ
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
                    
                    // FLASH DÜYMƏSİ
                    Button(action: {
                        // Flash Logic
                    }) {
                        Image(systemName: "bolt")
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 50)
            }
        }
    }
}

// MARK: - Helper Components (Xətanı həll edən hissə)

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

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView { UIVisualEffectView(effect: UIBlurEffect(style: style)) }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#Preview {
    VestoScannerView()
}
