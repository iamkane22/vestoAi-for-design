//
//  ChatScreen.swift
//  vestoAi for design
//
//  Created by Kenan on 26.03.26.
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isFromUser: Bool
}

struct Concierge: View {
    @State private var messageText: String = ""
    @State private var messages: [Message] = [
        Message(text: "Welcome to Atelier, Kenan. I've analyzed your Vault. Where are we heading today?", isFromUser: false)
    ]
    
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)
    
    var body: some View {
        VStack(spacing: 0) {
            // 1. VIP HEADER & EVENT STATUS
            VStack(spacing: 5) {
                Text("VIP CONCIERGE")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(4)
                    .foregroundColor(vestoGold)
                
            }
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity)
            .background(Color.black)
            
            // 2. CHAT AREA
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(messages) { msg in
                        ChatBubble(message: msg)
                    }
                }
                .padding()
            }
            .background(Color.black)
            
            // 3. INPUT AREA
            HStack(spacing: 15) {
                Button(action: {}) {
                    Image(systemName: "plus")
                        .foregroundColor(vestoGold)
                        .font(.system(size: 20))
                }
                
                TextField("Ask your stylist...", text: $messageText)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(20)
                    .foregroundColor(.white)
                
                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .foregroundColor(vestoGold)
                        .font(.system(size: 30))
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(Color.black)
        }
    }
    
    func sendMessage() {
        if !messageText.isEmpty {
            messages.append(Message(text: messageText, isFromUser: true))
            messageText = ""
            // Bura AI-ın cavab məntiqi gələcək
        }
    }
}

struct ChatBubble: View {
    let message: Message
    let vestoGold = Color(red: 0.83, green: 0.69, blue: 0.22)
    
    var body: some View {
        HStack {
            if message.isFromUser { Spacer() }
            
            Text(message.text)
                .font(.system(size: 14, weight: .light))
                .padding(15)
                .background(
                    // Küncləri fərqli dərəcədə yuvarlaqlaşdıran lüks fiqurumuz
                    UnevenRoundedRectangle(
                        topLeadingRadius: 20,
                        bottomLeadingRadius: message.isFromUser ? 20 : 2, // İstifadəçidirsə yuvarlaq, deyilsə kəsik
                        bottomTrailingRadius: message.isFromUser ? 2 : 20, // İstifadəçidirsə kəsik, deyilsə yuvarlaq
                        topTrailingRadius: 20
                    )
                    .fill(message.isFromUser ? vestoGold : Color.white.opacity(0.07))
                )
                .foregroundColor(message.isFromUser ? .black : .white)
            
            if !message.isFromUser { Spacer() }
        }
    }
}

#Preview {
    Concierge()
}
