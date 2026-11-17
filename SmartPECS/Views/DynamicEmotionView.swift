import SwiftUI
import AVFoundation

struct DynamicEmotionView: View {
    @EnvironmentObject var gameManager: GameManager
    let targetEmotion: String
    
    @StateObject private var cameraManager = CameraManager()
    @StateObject private var viewModel = EmotionViewModel()
    @State private var isPassed = false
    
    var body: some View {
        ZStack {
            if cameraManager.permissionGranted {
                CameraPreview(session: cameraManager.captureSession)
                    .ignoresSafeArea()
            }
            
            VStack {
                Text("Thử thách: Hãy làm \(targetEmotion) nào! 😊")
                    .font(.title2.bold())
                    .padding()
                    .background(isPassed ? Color.green : Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .padding(.top, 20)
                
                Spacer()
            }
        }
        .onChange(of: viewModel.isSmiling) { isSmiling in
            // Tạm thời chỉ hỗ trợ "Mặt Cười", nếu AI nhận diện nụ cười thì qua màn
            if isSmiling && targetEmotion == "Mặt Cười" && !isPassed {
                isPassed = true
                gameManager.levelPassed()
            }
        }
        .onAppear {
            cameraManager.delegate = viewModel
            cameraManager.startSession()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                TTSManager.shared.speak("Hãy làm \(targetEmotion) nào!")
            }
        }
        .onDisappear {
            cameraManager.stopSession()
        }
    }
}