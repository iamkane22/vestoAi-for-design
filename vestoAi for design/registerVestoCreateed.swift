import SwiftUI

struct SignUpScreen: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    
    // Qızıl Nisbət Hesablamaları
    private let screenHeight = UIScreen.main.bounds.height
    private let phi: CGFloat = 1.618
    
    var body: some View {
        ZStack {
            // 1. DEEP OBSIDIAN CANVAS (Arxa fon)
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // --- A. THE HERO: Polo Vignette ---
                ZStack(alignment: .bottom) {
                    Image("fashion_model") // Bura öz polo şəklinin adını yaz
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: screenHeight * 0.55) // Şəklin hündürlüyünü bir az azaltdıq ki, aşağıya yer qalsın
                        .clipped()
                        .overlay(
                            // Sənətkarın Vignette Effekti: Tam dumanlı keçid
                            LinearGradient(
                                stops: [
                                    .init(color: .clear, location: 0.4),
                                    .init(color: .black.opacity(0.8), location: 0.8),
                                    .init(color: .black, location: 1.0)
                                ],
                                startPoint: .top, endPoint: .bottom
                            )
                        )
                    
                    // Geri dönüş oxu (Yuxarı sol küncdə, daha incə)
                    VStack {
                        HStack {
                            Button(action: { /* Dismiss */ }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 20, weight: .ultraLight))
                                    .foregroundColor(.white.opacity(0.5))
                                    .padding(.leading, 30)
                                    .padding(.top, 50)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    
                    // Mərkəzi "Seal" Loqosu (Şəklin düz bitdiyi və qaranlığın başladığı yerdə)
                    ZStack {
                        Circle()
                            .stroke(Color.vestoGold.opacity(0.4), lineWidth: 0.5)
                            .frame(width: 50, height: 50)
                        Text("V")
                            .font(.system(size: 22, weight: .regular, design: .serif))
                            .foregroundColor(.vestoGold)
                    }
                    .offset(y: 25) // Loqonu şəklin alt xəttinə tənzimləyirik
                }
                
                // --- B. THE INTERACTIVE: Spacing & Typography ---
                VStack(spacing: 0) {
                    
                    Spacer().frame(height: 50) // Loqo ilə başlıq arasında məsafə
                    
                    // Başlıq
                    Text("JOIN THE ATELIER")
                        .font(.system(size: 18, weight: .regular, design: .serif))
                        .kerning(8)
                        .foregroundColor(.white)
                        .padding(.bottom, 40)
                    
                    // Giriş Sahələri
                    VStack(spacing: 35) { // İnputlar arası məsafə
                        SerifInputField(placeholder: "FULL NAME", text: $fullName)
                        SerifInputField(placeholder: "EMAIL", text: $email)
                        SerifInputField(placeholder: "PASSWORD", text: $password, isSecure: true)
                    }
                    .padding(.horizontal, 45)
                    
                    Spacer() // Bu boşluq düyməni və ikonları aşağı itələyəcək
                    
                    // Sosial İkonlar və Düymə zonası
                    VStack(spacing: 30) {
                        HStack(spacing: 40) {
                            EliteSocialIcon(icon: "applelogo", isApple: true)
                            EliteSocialIcon(icon: "g.circle", isApple: false)
                        }
                        
                        Button(action: {}) {
                            Text("JOIN THE ATELIER") // və ya "START YOUR STYLE JOURNEY"
                                .font(.system(size: 12, weight: .bold))
                                .kerning(3)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(
                                    ZStack {
                                        Color.vestoGold
                                        Color.vestoGold.opacity(0.3).blur(radius: 10).offset(y: 4)
                                    }
                                )
                                .cornerRadius(6)
                        }
                        .padding(.horizontal, 45)
                    }
                    .padding(.bottom, 40) // Ən alt məsafə
                }
                .frame(height: screenHeight * 0.45) // İnteraktiv hissənin hündürlüyü
            }
        }
    }
}

// MARK: - ELITE COMPONENTS
struct SerifInputField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(.system(size: 12, weight: .regular, design: .serif))
                        .foregroundColor(Color.white.opacity(0.4))
                        .tracking(1.5)
                }
                if isSecure {
                    SecureField("", text: $text).foregroundColor(.white)
                } else {
                    TextField("", text: $text).foregroundColor(.white)
                }
            }
            // İncə və daha tutqun xətt
            Rectangle()
                .fill(Color.white.opacity(0.1))
                .frame(height: 1)
        }
    }
}

struct EliteSocialIcon: View {
    var icon: String
    var isApple: Bool
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 18, weight: .light))
            .foregroundColor(.white.opacity(0.6)) // İkonları yüngülcə qabartdıq
            .frame(width: 48, height: 48)
            .overlay(
                Circle().stroke(Color.white.opacity(0.15), lineWidth: 1) // İncə ağ/boz çərçivə
            )
    }
}


#Preview {
    SignUpScreen()
}
