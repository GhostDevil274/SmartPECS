import SwiftUI

struct SensoryTheme {
    // Dùng mã RGB trực tiếp để ra đúng màu Xanh Bầu Trời Tơ (Baby Blue) cực kỳ trong trẻo, KHÔNG dùng opacity để tránh ám màu
    static let bgPrimary = Color(red: 0.92, green: 0.96, blue: 0.98)
    
    // Các màu thẻ pastel giữ nguyên
    static let cardFood = Color.orange.opacity(0.1)
    static let cardAction = Color.green.opacity(0.1)
    static let cardPlay = Color.blue.opacity(0.1)
    static let cardAnimal = Color.pink.opacity(0.1)
    
    static let textMain = Color.primary.opacity(0.8)
    
    static let successGreen = Color.green
    static let errorRed = Color.red
}
