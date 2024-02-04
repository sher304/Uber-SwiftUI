//
//  DoubleExtension.swift
//  Uber
//
//  Created by Шермат Эшеров on 4/2/24.
//

import Foundation

extension Double  {
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func toCurrency() -> String {
        return currencyFormatter.string(for: self) ?? ""
    }
}
