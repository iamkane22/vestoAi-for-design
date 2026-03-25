import SwiftUI



struct Vault: View {
    @State private var selectedCategory: String = "All"
    let categories = ["All", "Tops", "Bottoms", "Shoes", "Accessories"]
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)
    
    // Nümunə data
    let sampleItems = [
        VaultItem(name: "Cashmere Sweater", category: "Tops", image: "sweater"),
        VaultItem(name: "Wool Trousers", category: "Bottoms", image: "pants"),
        VaultItem(name: "Leather Loafers", category: "Shoes", image: "shoes"),
        VaultItem(name: "Silk Scarf", category: "Accessories", image: "scarf")
    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    // some View yalnız bura aid edilir
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    // CATEGORY SELECTOR
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(categories, id: \.self) { cat in
                                CategoryButton(title: cat, isSelected: selectedCategory == cat)
                                    .onTapGesture { selectedCategory = cat }
                            }
                        }
                        .padding(.horizontal, 25)
                    }
                    .padding(.top, 10)
                    
                    // WARDROBE GRID
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 25) {
                            ForEach(sampleItems) { item in
                                VaultCard(item: item)
                            }
                        }
                        .padding(25)
                    }
                }
            }
            .navigationTitle("THE VAULT")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("THE VAULT")
                        .font(.system(size: 14, weight: .ultraLight))
                        .tracking(8)
                        .foregroundColor(vestoGold)
                }
            }
        }
    }
}

// MARK: - Components (Bunları VaultView-dan kənarda yazırıq)

struct VaultCard: View {
    let item: VaultItem
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.03))
                    .aspectRatio(0.8, contentMode: .fit)
                
                Image(systemName: "hanger")
                    .font(.system(size: 40, weight: .ultraLight))
                    .foregroundColor(vestoGold.opacity(0.3))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(item.name.uppercased())
                    .font(.system(size: 10, weight: .bold))
                    .tracking(1)
                    .foregroundColor(.white)
                
                Text(item.category)
                    .font(.system(size: 10, weight: .light))
                    .foregroundColor(.white.opacity(0.4))
            }
            .padding(.horizontal, 5)
        }
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)
    
    var body: some View {
        Text(title)
            .font(.system(size: 12, weight: isSelected ? .bold : .light))
            .tracking(1)
            .foregroundColor(isSelected ? .black : .white.opacity(0.6))
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .background(isSelected ? vestoGold : Color.white.opacity(0.05))
            .cornerRadius(20)
    }
}

struct VaultItem: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let image: String
}

#Preview {
    Vault()
}
