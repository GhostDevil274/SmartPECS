import Foundation
import Combine

class ParentViewModel: ObservableObject {
    @Published var isUnlocked: Bool = false
    @Published var questionString: String = ""
    @Published var userInput: String = ""
    @Published var showError: Bool = false
    
    private var correctAnswer: Int = 0
    
    init() {
        generateQuestion()
    }
    
    // Tạo phép tính nhân ngẫu nhiên (từ 2 đến 9)
    func generateQuestion() {
        let num1 = Int.random(in: 2...9)
        let num2 = Int.random(in: 2...9)
        correctAnswer = num1 * num2
        questionString = "\(num1) x \(num2) = ?"
        userInput = ""
        showError = false
    }
    
    // Kiểm tra kết quả phụ huynh nhập
    func verifyAnswer() {
        if let answer = Int(userInput), answer == correctAnswer {
            isUnlocked = true
        } else {
            showError = true
            userInput = ""
            generateQuestion() // Đổi câu hỏi khác nếu nhập sai
        }
    }
}
