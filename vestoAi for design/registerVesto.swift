import SwiftUI

struct RegisterScreen: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            // 1. SONSUR OBSIDIAN FON
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // --- A. THE HERO: Sərhədsiz Keçid (Seamless Blend)
                ZStack(alignment: .bottom) {
                    Image("fashion_model")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: UIScreen.main.bounds.height * 0.40)
                        .clipped()
                        .overlay(
                            // 10/10 Toxunuşu: Şəkli qaranlığın içində "itirən" duman
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: .clear, location: 0.5),
                                    .init(color: .black.opacity(0.8), location: 0.85),
                                    .init(color: .black, location: 1.0)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
                    // Zərif Geri Oxu
                    VStack {
                        HStack {
                            Button(action: { /* Geri */ }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 18, weight: .ultraLight))
                                    .foregroundColor(.white.opacity(0.6))
                                    .padding(25)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.top, 40)
                }
                
                VStack(spacing: 0) {
                    // --- B. THE EMBLEM: Nəfəs Alan Loqo
                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .stroke(Color.vestoGold.opacity(0.4), lineWidth: 0.4)
                                .frame(width: 48, height: 48)
                            Text("V")
                                .font(.system(size: 20, weight: .ultraLight, design: .serif))
                                .foregroundColor(.vestoGold)
                        }
                        .padding(.top, 25) // Loqonun nəfəs alması üçün boşluq
                        
                        Text("VESTO AI")
                            .font(.system(size: 26, weight: .regular, design: .serif))
                            .kerning(14)
                            .foregroundColor(.white)
                        
                        Text("Step into your curated style journey")
                            .font(.system(size: 13, weight: .ultraLight, design: .serif).italic())
                            .foregroundColor(.white.opacity(0.45))
                            .kerning(1.5)
                    }
                    .padding(.bottom, 40)
                    
                    // --- C. INPUTS: Muted Gold & Legibility
                    VStack(spacing: 30) {
                        AtelierInputField(placeholder: "Email Address", text: $email)
                        AtelierInputField(placeholder: "Password", text: $password, isSecure: true)
                    }
                    .padding(.horizontal, 45)
                    .padding(.bottom, 35)
                    
                    // --- D. THE BUTTON: Sign In to the Atelier
                    Button(action: {}) {
                        Text("SIGN IN TO THE ATELIER")
                            .font(.system(size: 13, weight: .bold))
                            .kerning(3)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                            .background(
                                ZStack {
                                    Color.vestoGold
                                    Color.vestoGold.opacity(0.3).blur(radius: 12).offset(y: 4)
                                }
                            )
                            .cornerRadius(2)
                    }
                    .padding(.horizontal, 45)
                    .padding(.bottom, 30)
                    
                    // --- E. SOCIAL & FOOTER: Balanslı Məsafə
                    VStack(spacing: 25) {
                        HStack(spacing: 40) {
                            SocialIconButton(icon: "applelogo")
                            SocialIconButton(icon: "g.circle")
                        }
                        
                        HStack(spacing: 6) {
                            Text("New to the atelier?")
                                .foregroundColor(.white.opacity(0.35))
                            Text("Create account")
                                .foregroundColor(.vestoGold.opacity(0.8))
                        }
                        .font(.system(size: 12, weight: .light))
                        .padding(.top, 10) // Toxunuş təhlükəsizliyi üçün məsafə
                    }
                }
                
                Spacer()
            }
        }
    }
}

// MARK: - ATELIER COMPONENTS (Updated)


struct SocialIconButton: View {
    var icon: String
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 18, weight: .ultraLight))
            .foregroundColor(.white.opacity(0.5))
            .frame(width: 48, height: 48)
            .overlay(
                Circle().stroke(Color.white.opacity(0.1), lineWidth: 0.5)
            )
    }
}

#Preview {
    RegisterScreen()
}
