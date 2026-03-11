import SwiftUI
import AVFoundation

// MARK: - PRO CAMERA ENGINE
struct CameraPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        let session = AVCaptureSession()
        
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else { return view }
        
        session.addInput(input)
        let layer = AVCaptureVideoPreviewLayer(session: session)
        layer.frame = view.frame
        layer.videoGravity = .resizeAspectFill // XƏTA BURADA İDİ: Düzəldildi.
        view.layer.addSublayer(layer)
        
        DispatchQueue.global(qos: .background).async { session.startRunning() }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}

// MARK: - MAIN UI
struct PeakVisionView: View {
    @State private var scanPos: CGFloat = -240
    @State private var glowOpacity = 0.8
    
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)

    var body: some View {
        ZStack {
            // 1. Canlı Kamera Fonu
            CameraPreview()
                .edgesIgnoringSafeArea(.all)
            
            // 2. Lüks Qaranlıq Overlay (Kameranı daha bahalı göstərir)
            Color.black.opacity(0.45)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Header: Minimalist & Tracking
                VStack(spacing: 4) {
                    Text("VESTO VISION")
                        .font(.system(size: 14, weight: .ultraLight))
                        .tracking(12)
                    Text("AI ANALYSIS IN PROGRESS")
                        .font(.system(size: 8, weight: .bold))
                        .opacity(0.4)
                }
                .foregroundColor(vestoGold)
                .padding(.top, 60)

                Spacer()

                // 3. SKANER ÇƏRÇİVƏSİ & DÜZƏLDİLMİŞ İŞIQ
                ZStack {
                    EliteScannerFrame(color: vestoGold)
                        .frame(width: 280, height: 480)
                    
                    // Dinamik Lazer Xətti
                    VStack(spacing: 0) {
                        // İşığın arxasındakı dumanlı iz (Trail)
                        LinearGradient(colors: [vestoGold.opacity(0.3), .clear],
                                      startPoint: .bottom,
                                      endPoint: .top)
                            .frame(width: 260, height: 120)
                            .blur(radius: 15)
                        
                        // Əsas Parlaq Xətt
                        Rectangle()
                            .fill(vestoGold)
                            .frame(width: 270, height: 1.2)
                            .shadow(color: vestoGold, radius: 8)
                    }
                    .offset(y: scanPos)
                }

                Spacer()

                // 4. STATUS BAR (Glassmorphism)
                statusIndicator
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: true)) {
                scanPos = 240
            }
        }
    }
    
    private var statusIndicator: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(vestoGold)
                .frame(width: 6, height: 6)
                .opacity(glowOpacity)
            
            Text("OPTIMIZING STYLE SCORE...")
                .font(.system(size: 10, weight: .medium))
                .tracking(2)
                .foregroundColor(.white)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 24)
        .background(.ultraThinMaterial)
        .cornerRadius(30)
        .padding(.bottom, 50)
        .onAppear {
            withAnimation(.easeInOut(duration: 1).repeatForever()) { glowOpacity = 0.2 }
        }
    }
}

// MARK: - FRAME COMPONENT
struct EliteScannerFrame: View {
    let color: Color
    var body: some View {
        ZStack {
            ForEach(0..<4) { i in
                VestoCorner()
                    .stroke(color, lineWidth: 1)
                    .frame(width: 40, height: 40)
                    .rotationEffect(.degrees(Double(i) * 90))
                    .offset(x: i == 0 || i == 2 ? -120 : 120,
                            y: i == 0 || i == 1 ? -220 : 220)
            }
        }
    }
}

struct VestoCorner: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        return path
    }
}

#Preview {
    PeakVisionView()
}
