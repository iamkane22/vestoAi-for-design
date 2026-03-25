import SwiftUI
import PhotosUI // Şəkil seçmək üçün vacibdir
import AVFoundation

struct PeakVisionView: View {
    @State private var scanPos: CGFloat = -240
    @State private var glowOpacity = 0.8
    
    // YENİ: Şəkil seçmək üçün state-lər
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var isAnalyzing = false
    
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)

    var body: some View {
        ZStack {
            // 1. FON (Kamera və ya Seçilmiş Şəkil)
            ZStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                } else {
                    CameraPreview()
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            // 2. Lüks Qaranlıq Overlay
            Color.black.opacity(0.45)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Header
                headerView
                
                Spacer()

                // 3. SKANER ÇƏRÇİVƏSİ
                ZStack {
                    EliteScannerFrame(color: vestoGold)
                        .frame(width: 280, height: 480)
                    
                    // Lazer Xətti (Hər iki halda işləyir)
                    scannerLaser
                }

                Spacer()

                // 4. ALT MENYU (Library düyməsi bura gəldi)
                bottomControls
            }
        }
        .sheet(isPresented: $showImagePicker) {
            VestoImagePicker(image: $selectedImage)
        }
        .onAppear {
            startScanAnimation()
        }
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        VStack(spacing: 4) {
            Text("VESTO VISION")
                .font(.system(size: 14, weight: .ultraLight))
                .tracking(12)
            Text(selectedImage == nil ? "READY TO SCAN" : "IMAGE DETECTED")
                .font(.system(size: 8, weight: .bold))
                .opacity(0.4)
        }
        .foregroundColor(vestoGold)
        .padding(.top, 60)
    }
    
    private var scannerLaser: some View {
        VStack(spacing: 0) {
            LinearGradient(colors: [vestoGold.opacity(0.3), .clear],
                          startPoint: .bottom,
                          endPoint: .top)
                .frame(width: 260, height: 120)
                .blur(radius: 15)
            
            Rectangle()
                .fill(vestoGold)
                .frame(width: 270, height: 1.2)
                .shadow(color: vestoGold, radius: 8)
        }
        .offset(y: scanPos)
    }
    
    private var bottomControls: some View {
        VStack(spacing: 25) {
            // Status Bar
            statusIndicator
            
            // Library & Actions
            HStack(spacing: 60) {
                // Qalereya Düyməsi
                Button(action: { showImagePicker = true }) {
                    VStack(spacing: 6) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.system(size: 20, weight: .light))
                        Text("LIBRARY")
                            .font(.system(size: 8, weight: .bold))
                            .tracking(1)
                    }
                    .foregroundColor(.white)
                }
                
                // Əgər şəkil seçilibsə "Clear" düyməsi çıxsın
                if selectedImage != nil {
                    Button(action: { selectedImage = nil }) {
                        VStack(spacing: 6) {
                            Image(systemName: "camera.viewfinder")
                                .font(.system(size: 20, weight: .light))
                            Text("LIVE")
                                .font(.system(size: 8, weight: .bold))
                                .tracking(1)
                        }
                        .foregroundColor(vestoGold)
                    }
                }
            }
            .padding(.bottom, 40)
        }
    }

    private var statusIndicator: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(vestoGold)
                .frame(width: 6, height: 6)
                .opacity(glowOpacity)
            
            Text(selectedImage == nil ? "WAITING FOR ITEM..." : "OPTIMIZING STYLE SCORE...")
                .font(.system(size: 10, weight: .medium))
                .tracking(2)
                .foregroundColor(.white)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 24)
        .background(.ultraThinMaterial)
        .cornerRadius(30)
        .onAppear {
            withAnimation(.easeInOut(duration: 1).repeatForever()) { glowOpacity = 0.2 }
        }
    }
    
    private func startScanAnimation() {
        withAnimation(.linear(duration: 4).repeatForever(autoreverses: true)) {
            scanPos = 240
        }
    }
}

// MARK: - IMAGE PICKER BRIDGE
struct VestoImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images // Ancaq şəkillər
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: VestoImagePicker
        init(_ parent: VestoImagePicker) { self.parent = parent }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()
            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
    }
}

// BUNLARI FAYLIN ƏN AŞAĞISINA ƏLAVƏ ET

struct CameraPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        let session = AVCaptureSession()
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else { return view }
        session.addInput(input)
        let layer = AVCaptureVideoPreviewLayer(session: session)
        layer.frame = view.frame
        layer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(layer)
        DispatchQueue.global(qos: .background).async { session.startRunning() }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}

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
