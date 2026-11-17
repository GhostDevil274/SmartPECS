import Foundation
import UIKit
import AudioToolbox // Dùng để gọi âm thanh hệ thống của Apple

class FXManager {
    static let shared = FXManager()
    
    // Khi bé trả lời ĐÚNG
    func playSuccess() {
        // 1. Rung phản hồi (Haptic - Success)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        // 2. Phát âm thanh "Ting!" nhẹ nhàng của iOS
        AudioServicesPlaySystemSound(1052) 
    }
    
    // Khi bé trả lời SAI
    func playError() {
        // 1. Rung phản hồi (Haptic - Error)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        
        // 2. Phát âm thanh "Bụp" báo lỗi
        AudioServicesPlaySystemSound(1053)
    }
}