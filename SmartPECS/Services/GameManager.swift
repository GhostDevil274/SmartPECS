import Foundation
import Combine
import SwiftUI // Cần SwiftUI để dùng @AppStorage

class GameManager: ObservableObject {
    @Published var currentLevel: LevelType?
    @Published var currentLevelNumber: Int = 1
    
    // [TÍNH NĂNG AI THÍCH ỨNG] Bộ nhớ theo dõi độ thuần thục của từng thẻ
    @Published var cardProficiency: [String: Int] = [:]
    
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
            let shuffledLibrary = CardLibrary.allCards.shuffled()
            
            // 1. Chọn trước 1 thẻ mục tiêu
            guard let target = shuffledLibrary.first else { return }
            
            // 2. Tra cứu điểm thuần thục của thẻ này trong quá khứ
            let score = cardProficiency[target.id] ?? 0
            
            var optionCount = 4
            
            // 3. AI Tự động điều chỉnh độ khó (Adaptive Difficulty)
            // Nếu bé sai 2 lần liên tiếp HOẶC thẻ này bé hay làm sai (điểm < 0) -> Giảm còn 2 đáp án
            if consecutiveWrong >= 2 || score < 0 {
                optionCount = 2
            }
            // Nếu thẻ này bé đã trả lời đúng nhiều lần (điểm >= 2) -> Tăng lên 6 đáp án để thử thách
            else if score >= 2 {
                optionCount = 6
            }
            
            // 4. Tạo danh sách các thẻ lựa chọn
            var options = [target] // Bỏ thẻ mục tiêu vào trước
            let remainingCards = shuffledLibrary.dropFirst().prefix(optionCount - 1)
            options.append(contentsOf: remainingCards)
            
            // Đảo vị trí để thẻ mục tiêu không luôn luôn nằm ở đầu
            options.shuffle()
            
            currentLevel = .findFlashcard(target: target, options: options)
        }
    }
    
    // Gọi khi bé trả lời đúng
    func levelPassed() {
        // AI GHI NHẬN: Bé đã học tốt thẻ này, cộng 1 điểm
        if case .findFlashcard(let target, _) = currentLevel {
            cardProficiency[target.id, default: 0] += 1
        }
        
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
    
    // Gọi khi bé trả lời sai
    func answerWrong() {
        // AI GHI NHẬN: Bé gặp khó với thẻ này, trừ 1 điểm
        if case .findFlashcard(let target, _) = currentLevel {
            cardProficiency[target.id, default: 0] -= 1
        }
        
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
