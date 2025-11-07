//
//  CardRow.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 04/11/25.
//

import SwiftUI

struct CardRow: View {
    
    let cardList: Cards
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            
            Text("\(cardList.card_brand ?? "") **** **** **** \(cardList.last_4 ?? "")")
                .font(.customfont(.medium, fontSize: 14))
            
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(isSelected ? Color.black : Color.black, lineWidth: 2)
                    .frame(width: 24, height: 24)
                if isSelected {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 12, height: 12)
                }
            }
        }
        .padding(14)
        .background (
            RoundedRectangle(cornerRadius: 15)
                .stroke(isSelected  ? Color.blue : Color(.systemGray6), lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                )
        )
        .cornerRadius(15)
    }
}

//#Preview {
//    CardRow()
//}
