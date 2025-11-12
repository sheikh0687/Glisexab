//
//  RideRiw.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 04/11/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct RideRow: View {
    
    let vehicle: Res_VehicleList
    let selected: Bool

    var body: some View {
        HStack(spacing: 8) {
            if let urlString = vehicle.image {
                Utility.CustomWebImage(imageUrl: urlString, placeholder: Image(systemName: "placeholder"), width: 60, height: 40)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(vehicle.vehicle ?? "Unknown Vehicle")
                    .font(.customfont(.medium, fontSize: 12))
                Text(vehicle.no_of_passenger ?? "No passenger")
                    .font(.customfont(.regular, fontSize: 10))
                    .foregroundColor(Color.gray)
            }
            Spacer()
            Text("$ \(vehicle.estimate_fair ?? "")")
                .font(.customfont(.medium, fontSize: 14))
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(selected ? Color.colorLightBlue : Color(.systemGray6), lineWidth: 1)
                .background(selected ? Color(.systemGray6) : Color.white)
        )
        .cornerRadius(15)
    }
}

//#Preview {
//    RideRow(vehicle: <#Res_VehicleList#>, selected: <#Bool#>)
//}
