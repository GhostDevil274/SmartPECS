import SwiftUI
import ARKit

// Đã XÓA khối struct ARCameraPreview ở đây vì nó đang dùng chung với EmotionMirrorView

struct DynamicEmotionView: View {
    @EnvironmentObject var gameManager: GameManager
    let targetEmotion: String
    
    // Sử dụng viewModel quản lý ARKit
    @StateObject private var viewModel = EmotionViewModel()
    @State private var isPassed = false
    
    // Sinh ra hình ảnh (Emoji khổng lồ) tương ứng với từng cảm xúc
    var emotionIcon: String {
        switch targetEmotion {
        case "Cười tươi": return "😄"
        case "Khóc / Buồn": return "😭"
        case "Giận dữ": return "😡"
        case "Ngạc nhiên": return "😲"
        case "Nhắm mắt": return "😴"
        default: return "😐"
        }
    }
    
    var body: some View {
        ZStack {
            // Gọi trực tiếp ARCameraPreview đã được định nghĩa ở file khác
            ARCameraPreview(session: viewModel.session)
                .ignoresSafeArea()
            
            VStack {
                // BẢNG HƯỚNG DẪN TRỰC QUAN CHO TRẺ
                HStack(spacing: 20) {
                    Text(emotionIcon)
                        .font(.system(size: 70))
                        .padding(15)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.3), radius: 10)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Thử thách:")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.9))
                        Text("Hãy \(targetEmotion)!")
                            .font(.title.bold())
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(isPassed ? Color.green : Color.blue.opacity(0.85))
                .cornerRadius(25)
                .padding(.top, 40)
                
                Spacer()
                
                // Hiệu ứng thưởng khi bé làm đúng
                if isPassed {
                    Image(systemName: "star.fill")
                        .font(.system(size: 180))
                        .foregroundColor(.yellow)
                        .shadow(color: .orange, radius: 15)
                        .transition(.scale)
                }
                
                Spacer()
            }
        }
        // Theo dõi biến detectedEmotion của ARKit
        .onChange(of: viewModel.detectedEmotion) { detected in
            if detected == targetEmotion && !isPassed {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                    isPassed = true
                }
                gameManager.levelPassed() // Vượt qua thử thách, chuyển sang màn khác
            }
        }
        .onAppear {
            viewModel.startSession() // Bật ARKit
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                TTSManager.shared.speak("Hãy \(targetEmotion) nào!")
            }
        }
        .onDisappear {
            viewModel.stopSession() // Tắt ARKit khi chuyển màn
        }
    }
}
