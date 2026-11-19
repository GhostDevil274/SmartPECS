import SwiftUI
import Combine

struct GameSessionView: View {
    @StateObject private var gameManager = GameManager()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            // Thanh trạng thái (HUD) trên cùng
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.gray.opacity(0.8))
                }
                
                Spacer()
                
                Text("Màn: \(gameManager.currentLevelNumber)")
                    .font(.headline)
                
                Spacer()
                
                Text("Điểm: \(gameManager.totalCorrect)")
                    .font(.headline).foregroundColor(.orange)
            }
            .padding()
            
            Spacer()
            
            // Khu vực trung tâm: Render màn chơi tự động
            if let level = gameManager.currentLevel {
                switch level {
                case .findFlashcard(let target, let options):
                    DynamicFlashcardView(targetCard: target, options: options)
                        .environmentObject(gameManager)
                    
                case .emotion(let targetEmotion):
                    DynamicEmotionView(targetEmotion: targetEmotion)
                        .environmentObject(gameManager)
                }
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        // BẬT NHẠC KHI VÀO GAME
        .onAppear {
            BGMManager.shared.play()
        }
        // TẮT NHẠC KHI THOÁT RA TRANG CHỦ
        .onDisappear {
            BGMManager.shared.pause()
        }
    }
}
