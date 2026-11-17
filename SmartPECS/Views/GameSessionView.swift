import SwiftUI

struct GameSessionView: View {
    @StateObject private var gameManager = GameManager()
    
    var body: some View {
        VStack {
            // Thanh trạng thái (HUD) trên cùng
            HStack {
                Text("Màn: \(gameManager.currentLevelNumber)")
                    .font(.headline)
                Spacer()
                Text("Điểm: \(gameManager.score)")
                    .font(.headline).foregroundColor(.orange)
            }
            .padding()
            
            Spacer()
            
            // Khu vực trung tâm: Render màn chơi tự động dựa vào logic của GameManager
            if let level = gameManager.currentLevel {
                switch level {
                case .findFlashcard(let target, let options):
                    // Chuyển dữ liệu vào khung UI của màn tìm thẻ
                    DynamicFlashcardView(targetCard: target, options: options)
                        .environmentObject(gameManager)
                    
                case .emotion(let targetEmotion):
                    // Chuyển dữ liệu vào khung UI của màn cảm xúc
                    DynamicEmotionView(targetEmotion: targetEmotion)
                        .environmentObject(gameManager)
                }
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}