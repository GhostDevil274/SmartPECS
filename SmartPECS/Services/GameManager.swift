import Foundation
import Combine

class GameManager: ObservableObject {
    @Published var currentLevel: LevelType?
    @Published var score: Int = 0
    @Published var currentLevelNumber: Int = 1
    
    init() {
        generateNextLevel()
    }
    
    // Hàm cốt lõi: Tự động sinh màn chơi mới không giới hạn
    func generateNextLevel() {
        // Tỉ lệ: 70% ra màn tìm thẻ, 30% ra màn cảm xúc
        let isEmotionLevel = Int.random(in: 1...10) > 7 
        
        if isEmotionLevel {
            // Sinh màn cảm xúc (Tương lai có thể thêm Buồn, Giận...)
            currentLevel = .emotion(targetEmotion: "Mặt Cười")
        } else {
            // Sinh màn Flashcard: Bốc ngẫu nhiên 4 thẻ từ thư viện
            let shuffledLibrary = CardLibrary.allCards.shuffled()
            let options = Array(shuffledLibrary.prefix(4))
            
            // Chọn ngẫu nhiên 1 trong 4 thẻ đó làm đáp án đúng
            guard let target = options.randomElement() else { return }
            
            currentLevel = .findFlashcard(target: target, options: options)
        }
    }
    
    // Được gọi khi bé trả lời đúng
    func levelPassed() {
        score += 10
        currentLevelNumber += 1
        TTSManager.shared.speak("Giỏi quá!")
        
        // Nghỉ 1.5 giây để hiện hiệu ứng ăn mừng rồi tự động qua màn mới
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.generateNextLevel()
        }
    }
}