//
//  LocationSearchActivationView.swift
//  Uber
//
//  Created by Шермат Эшеров on 3/2/24.
//

import SwiftUI

struct LocationSearchActivationView: View {
    
    var body: some View {
        HStack {
            
            Rectangle()
                .fill()
                .frame(width: 8, height: 8)
            
            Text("Where to?")
                .foregroundStyle(.black)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64,
            height: 50)
        .padding(.leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(radius: 6)
        )
    }
}

#Preview {
    LocationSearchActivationView()
}
