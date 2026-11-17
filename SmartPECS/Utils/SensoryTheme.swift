//
//  SensoryTheme.swift
//  SmartPECS
//
//  Created by Minh Anh Nguyễn Trần on 5/11/26.
//


//
//  SensoryTheme.swift
//  SmartPECS
//
//  Created by Minh Anh Nguyễn Trần on 5/11/26.
//

import Foundation
import SwiftUI

// Extension hỗ trợ mã màu HEX tĩnh trong SwiftUI
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue:  Double(b) / 255, opacity: Double(a) / 255)
    }
}

// Cấu trúc hằng số giao diện
struct SensoryTheme {
    // Màu nền tổng thể - Trắng ngà dịu mắt
    static let bgPrimary = Color(hex: "F8F9FA")
    
    // Màu thẻ PECS (Pastel)
    static let cardFood = Color(hex: "FFF3E0")   // Cam nhạt
    static let cardPlay = Color(hex: "E8F5E9")   // Xanh lá nhạt
    static let cardAction = Color(hex: "E3F2FD") // Xanh dương nhạt
    
    // Màu Text chuẩn WCAG (Không dùng đen tuyền #000000 để giảm kích thích)
    static let textMain = Color(hex: "2C3E50")
    static let textSecondary = Color(hex: "546E7A")
}
