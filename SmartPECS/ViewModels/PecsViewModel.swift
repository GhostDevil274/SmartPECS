import Foundation
import Combine

class PecsViewModel: ObservableObject {
    // Tự động load toàn bộ kho thẻ từ CardLibrary vào Bảng PECS
    @Published var cards: [PecsCardModel] = CardLibrary.allCards
    
    @Published var isTouchLocked: Bool = false
    
    // Đã xóa synthesizer nội bộ vì chuyển sang dùng TTSManager
    
    func handleCardTap(card: PecsCardModel) {
        // Kiểm tra xem có đang bị khóa chạm không
        guard !isTouchLocked, card.isEnabled else { return }
        
        isTouchLocked = true
        
        // Gọi bộ phát âm thanh tối ưu của hệ thống
        TTSManager.shared.speak(card.title)
        
        // Khóa không cho bé bấm liên tục loạn xạ trong 0.5 giây
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isTouchLocked = false
        }
    }
}
