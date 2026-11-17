import SwiftUI
import ARKit

// LƯU Ý: Nếu Xcode báo lỗi "Invalid redeclaration of ARCameraPreview" ở đây,
// bạn chỉ cần xóa khối struct ARCameraPreview này đi (vì nó đã có sẵn bên file DynamicEmotionView rồi).
struct ARCameraPreview: UIViewRepresentable {
    let session: ARSession
    
    func makeUIView(context: Context) -> ARSCNView {
        let view = ARSCNView(frame: UIScreen.main.bounds)
        view.session = session
        view.backgroundColor = .black
        return view
    }
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
}

struct EmotionMirrorView: View {
    // Chỉ cần gọi đúng 1 biến viewModel, không cần cameraManager nữa
    @StateObject private var viewModel = EmotionViewModel()
    
    var body: some View {
        ZStack {
            // Mở camera quét 3D của ARKit
            ARCameraPreview(session: viewModel.session)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Hiển thị thông báo phản hồi sinh động dựa trên cảm xúc nhận diện được
                Text(getMessage(for: viewModel.detectedEmotion))
                    .font(.title2.bold())
                    .foregroundColor(viewModel.detectedEmotion == "Cười tươi" ? .green : .white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(16)
                    .padding(.bottom, 50)
            }
        }
        .onAppear {
            viewModel.startSession() // Khởi động ARKit
        }
        .onDisappear {
            viewModel.stopSession() // Tắt đi để tiết kiệm pin khi thoát màn hình
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    // Hàm phụ trợ giúp màn hình Gương này sinh động hơn
    func getMessage(for emotion: String) -> String {
        switch emotion {
        case "Cười tươi": return "Tuyệt vời! Nụ cười rất đẹp! 🥰"
        case "Khóc / Buồn": return "Đừng buồn nhé, cười lên nào! 😢"
        case "Giận dữ": return "Chà, khuôn mặt giận dữ kìa! 😡"
        case "Ngạc nhiên": return "Ồ, có chuyện gì ngạc nhiên vậy? 😲"
        case "Nhắm mắt": return "Bé buồn ngủ rồi à? 😴"
        default: return "Hãy thử làm mặt cười, buồn, giận... nhé! 😊"
        }
    }
}
