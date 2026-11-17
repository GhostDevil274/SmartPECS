import Foundation
import Combine
import SwiftUI // Cần SwiftUI để dùng @AppStorage

class GameManager: ObservableObject {
    @Published var currentLevel: LevelType?
    @Published var currentLevelNumber: Int = 1
    
    // Theo dõi chuỗi đúng/sai liên tiếp để AI tự điều chỉnh độ khó
    @Published var consecutiveWrong: Int = 0
    @Published var consecutiveCorrect: Int = 0
    
    // Lưu trữ vĩnh viễn cho Phụ huynh theo dõi
    @AppStorage("totalPlayed") var totalPlayed: Int = 0
    @AppStorage("totalCorrect") var totalCorrect: Int = 0
    @AppStorage("totalWrong") var totalWrong: Int = 0
    
    init() {
        generateNextLevel()
    }
    
    func generateNextLevel() {
        let isEmotionLevel = Int.random(in: 1...10) > 8 // Giảm tỉ lệ màn cảm xúc xuống 20%
        
        if isEmotionLevel {
            let emotions = ["Cười tươi", "Khóc / Buồn", "Giận dữ", "Ngạc nhiên", "Nhắm mắt"]
            let randomEmotion = emotions.randomElement() ?? "Cười tươi"
            currentLevel = .emotion(targetEmotion: randomEmotion)
        } else {
            // LÕI AI THÍCH ỨNG (ADAPTIVE LOGIC)
            var optionCount = 4
            // Nếu bé sai 2 lần liên tiếp -> Giảm độ khó xuống chỉ còn 2 đáp án
            if consecutiveWrong >= 2 {
                optionCount = 2
            }
            
            let shuffledLibrary = CardLibrary.allCards.shuffled()
            let options = Array(shuffledLibrary.prefix(optionCount))
            guard let target = options.randomElement() else { return }
            
            currentLevel = .findFlashcard(target: target, options: options)
        }
    }
    
    // Gọi khi bé trả lời đúng
    func levelPassed() {
        FXManager.shared.playSuccess()
        consecutiveCorrect += 1
        consecutiveWrong = 0 // Reset chuỗi sai
        
        totalCorrect += 1
        totalPlayed += 1
        currentLevelNumber += 1
        
        TTSManager.shared.speak("Giỏi quá!")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.generateNextLevel()
        }
    }
    
    // BỔ SUNG: Gọi khi bé trả lời sai
    func answerWrong() {
        FXManager.shared.playError()
        consecutiveWrong += 1
        consecutiveCorrect = 0
        totalWrong += 1
        
        TTSManager.shared.speak("Chưa đúng rồi, thử lại nhé!")
        
        // Nếu sai quá nhiều, có thể kích hoạt sinh lại màn chơi dễ hơn ngay lập tức
        if consecutiveWrong >= 2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.generateNextLevel() // Khởi động lại màn chơi với độ khó thấp hơn
            }
        }
    }
}
