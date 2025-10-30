//
//  DataModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/10/25.
//

import Foundation

// MARK: - Model
struct ChatModel: Identifiable {
    let id = UUID()
    let image: String
    let name: String
    let message: String
    let time: String
    let unreadCount: Int
}

// MARK: - Sample Data
let chats = [
    ChatModel(image: "leslie", name: "Courtney Henry", message: "Fan Installation", time: "2:30 PM", unreadCount: 3),
    ChatModel(image: "jenny", name: "Guy Hawkins", message: "Fan Installation", time: "12:30 PM", unreadCount: 0),
    ChatModel(image: "leslie", name: "Wade Warren", message: "Ok Thankyou", time: "11:00 AM", unreadCount: 1),
    ChatModel(image: "jenny", name: "Jacob Jones", message: "🎧 Audio", time: "11:13 AM", unreadCount: 0),
    ChatModel(image: "leslie", name: "Courtney Henry", message: "Fan Installation", time: "1:20 PM", unreadCount: 0),
    ChatModel(image: "profileEdit", name: "Floyd Miles", message: "You're Welcome", time: "7:09 PM", unreadCount: 0),
    ChatModel(image: "leslie", name: "Floyd Miles", message: "You're Welcome", time: "7:09 PM", unreadCount: 0),
    ChatModel(image: "jenny", name: "Floyd Miles", message: "You're Welcome", time: "7:09 PM", unreadCount: 0),
    ChatModel(image: "profileEdit", name: "Floyd Miles", message: "You're Welcome", time: "7:09 PM", unreadCount: 0),
]
