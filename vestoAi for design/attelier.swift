import SwiftUI

// 1. Lüks Rəng və Qradyan Tərifləri
extension Color {
    static let vestoObsidian = Color(red: 5/255, green: 5/255, blue: 5/255)
    
    // Qızılı Metalik Qradyan
    static let vestoGoldMetallic = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 212/255, green: 175/255, blue: 55/255), // D4AF37
            Color(red: 249/255, green: 241/255, blue: 176/255), // F9F1B0
            Color(red: 184/255, green: 134/255, blue: 11/255)  // B8860B
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let vestoSoftWhite = Color.white.opacity(0.9)
    
    // Hex rəng dəstəyi üçün daxili köməkçi (Xəta verməməsi üçün adını dəyişdim)
    static func fromHex(_ hex: String) -> Color {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        return Color(red: r, green: g, blue: b)
    }
}

struct VestoFreeProfileView: View {
    var body: some View {
        ZStack {
            Color.vestoObsidian.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    
                    // MARK: - 1. THE HEADER (Identity)
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                .frame(width: 72, height: 72)
                            Text("JV") // - Kanan (JV initsialı üçün)
                                .font(.system(size: 22, weight: .light, design: .serif))
                                .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Julian Vane")
                                .font(.system(size: 20, weight: .medium, design: .serif))
                                .foregroundColor(.white)
                            
                            Text("V-FREE MEMBER")
                                .font(.system(size: 9, weight: .bold))
                                .tracking(1.5)
                                .foregroundColor(.white.opacity(0.4))
                        }
                        
                        Spacer()
                        
                        Image(systemName: "gearshape")
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(.white.opacity(0.5))
                            .padding(.top, -20)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    
                    // MARK: - 2. THE AESTHETIC RING (The Core)
                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .stroke(Color.white.opacity(0.05), lineWidth: 12)
                                .frame(width: 200, height: 200)
                            
                            Circle()
                                .trim(from: 0, to: 0.72)
                                .stroke(Color.vestoGoldMetallic, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                                .frame(width: 200, height: 200)
                                .rotationEffect(.degrees(-90))
                            
                            VStack(spacing: -8) {
                                Text("72")
                                    .font(.system(size: 80, weight: .ultraLight, design: .serif))
                                    .foregroundColor(.white)
                                
                                Text("INDEX")
                                    .font(.system(size: 10, weight: .bold))
                                    .tracking(4)
                                    .foregroundColor(.white.opacity(0.4))
                            }
                        }
                    }
                    
                    // MARK: - 3. THE VAULT GRID (Vault Teases)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        
                        VaultCardView(icon: "paintpalette", title: "COLOR DNA", isLocked: false) {
                            Circle().fill(Color.black).frame(width: 20, height: 20)
                                .overlay(Circle().stroke(Color.white.opacity(0.2), lineWidth: 1))
                        }
                        
                        VaultCardView(icon: "tshirt", title: "SIGNATURE", isLocked: false) {
                            Text("MINIMALIST")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.vestoSoftWhite)
                        }
                        
                        VaultCardView(icon: "calendar", title: "SYNERGY", isLocked: true) { EmptyView() }
                        
                        VaultCardView(icon: "archivebox", title: "READY", isLocked: true) { EmptyView() }
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer(minLength: 120)
                }
            }
            
            // MARK: - 4. THE UPGRADE (CTA)
            VStack {
                Spacer()
                Button(action: {}) {
                    Text("UPGRADE TO VESTO PRO")
                        .font(.system(size: 12, weight: .medium, design: .serif))
                        .tracking(1.2)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(
                            ZStack {
                                Color.vestoObsidian
                                RoundedRectangle(cornerRadius: 2).stroke(Color.vestoGoldMetallic, lineWidth: 0.5)
                            }
                        )
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 30)
            }
        }
    }
}

// MARK: - Reusable Vault Card Component (Fixed Names)
struct VaultCardView<Content: View>: View {
    let icon: String
    let title: String
    let isLocked: Bool
    let content: Content
    
    init(icon: String, title: String, isLocked: Bool, @ViewBuilder content: () -> Content) {
        self.icon = icon
        self.title = title
        self.isLocked = isLocked
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(RadialGradient(gradient: Gradient(colors: [Color.white.opacity(0.05), Color.clear]), center: .center, startRadius: 1, endRadius: 100))
                .background(isLocked ? AnyView(Color.black.opacity(0.3)) : AnyView(Color.white.opacity(0.02)))
            
            VStack(spacing: 12) {
                HStack {
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .light))
                    Text(title)
                        .font(.system(size: 9, weight: .bold))
                        .tracking(1)
                }
                .foregroundColor(.white.opacity(0.4))
                
                if isLocked {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 212/255, green: 175/255, blue: 55/255).opacity(0.6))
                        .shadow(color: Color(red: 212/255, green: 175/255, blue: 55/255).opacity(0.3), radius: 4)
                } else {
                    content
                }
            }
        }
        .frame(height: 110)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isLocked ? Color.white.opacity(0.05) : Color.white.opacity(0.1), lineWidth: 0.5)
        )
        .blur(radius: isLocked ? 1.5 : 0)
    }
}

#Preview {
    VestoFreeProfileView()
}
