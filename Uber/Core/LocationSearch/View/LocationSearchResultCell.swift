//
//  LocationSearchResultCell.swift
//  Uber
//
//  Created by Шермат Эшеров on 3/2/24.
//

import SwiftUI

struct LocationSearchResultCell: View {
    
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundStyle(.green)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.body)
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundStyle(.gray)
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
        .padding(.leading)
    }
}

#Preview {
    LocationSearchResultCell(title: "Green Coffe", subtitle: "123 Aleja")
}
