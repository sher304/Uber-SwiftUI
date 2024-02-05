//
//  ColorExtension.swift
//  Uber
//
//  Created by Шермат Эшеров on 5/2/24.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let backgroundCar = Color("BackgroundCar")
    let primaryTextColor = Color("PrimaryTextColor")
}
