//
//  SaveAddressRow.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 06/11/25.
//

import SwiftUI

struct SaveAddressRow: View {
    
    let addressRow: Res_InfoAddress
    var cloDelete: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text(addressRow.addresstype ?? "")
                    .font(.customfont(.medium, fontSize: 16))
                Text(addressRow.address ?? "")
                    .font(.customfont(.regular, fontSize: 14))
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            HStack {
                Button {
                    print("Edit address")
                } label: {
                    Image("edit")
                          .resizable()
                          .scaledToFit()
                          .frame(width: 24, height: 24)
                }
                
                Button {
                    cloDelete()
                } label: {
                    Image("delete")
                          .resizable()
                          .scaledToFit()
                          .frame(width: 24, height: 24)
                }
            }
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 14)
        .frame(minHeight: 100)
        .background (
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .overlay (
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
        )
        .padding(.horizontal, 16)

    }
}

//#Preview {
//    SaveAddressRow()
//}
