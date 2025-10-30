//
//  ChatView.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/10/25.
//

import SwiftUI

struct ChatView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    @State private var txtSearch: String = ""
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search here...", text: $txtSearch)
                    
                    Spacer()
                    Image(systemName: "mic.fill")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(chats) { chatss in
                            ChatRow(chat: chatss)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton {
                    router.popView()
                }
            }
        }
        .onAppear {
            UINavigationBar.setTitleColor(.white)
        }
    }
    
    struct ChatRow: View {
        let chat: ChatModel
        
        var body: some View {
            VStack(spacing: 0) {
                HStack(spacing: 25) {
                    Image(chat.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(chat.name)
                            .font(.system(size: 16, weight: .semibold))
                        Text(chat.message)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 6) {
                        Text(chat.time)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        
                        if chat.unreadCount > 0 {
                            Text("\(chat.unreadCount)")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                
                Divider()
                    .padding(.leading, 80)
            }
        }
    }
    
}

#Preview {
    ChatView()
}
