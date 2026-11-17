import SwiftUI
import Combine
import AVFoundation

// MARK: - Trình quản lý nhạc nền thư giãn
class RelaxAudioManager: ObservableObject {
    var audioPlayer: AVAudioPlayer?
    
    func playSoothingMusic() {
        if let url = Bundle.main.url(forResource: "relax_bgm", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.volume = 0.4
                audioPlayer?.play()
            } catch {
                print("Không tìm thấy file nhạc relax_bgm.mp3")
            }
        }
    }
    
    func stopMusic() {
        audioPlayer?.stop()
    }
}

// MARK: - Màn hình Góc Thư Giãn
struct RelaxCornerView: View {
    @StateObject private var audioManager = RelaxAudioManager()
    @State private var isBreathing = false
    @State private var bubbleOffsets: [CGFloat] = Array(repeating: 1000, count: 8)
    
    var body: some View {
        ZStack {
            SensoryTheme.bgPrimary.ignoresSafeArea()
            
            // HIỆU ỨNG BONG BÓNG BAY
            GeometryReader { geo in
                ForEach(0..<8, id: \.self) { index in
                    Circle()
                        .fill(Color.white.opacity(Double.random(in: 0.1...0.3)))
                        .frame(width: CGFloat.random(in: 30...90))
                        // Đã sửa lại lỗi rớt dòng cú pháp ở đây
                        .position(x: CGFloat.random(in: 50...geo.size.width - 50),
                                  y: bubbleOffsets[index])
                        .animation(
                            Animation.linear(duration: Double.random(in: 12...25))
                                .repeatForever(autoreverses: false)
                                .delay(Double.random(in: 0...5)),
                            value: bubbleOffsets[index]
                        )
                }
            }
            .onAppear {
                for i in 0..<bubbleOffsets.count {
                    bubbleOffsets[i] = -200
                }
            }
            
            // TRUNG TÂM: NHỊP THỞ THƯ GIÃN
            VStack(spacing: 40) {
                ZStack {
                    Circle()
                        .fill(Color.purple.opacity(0.15))
                        .frame(width: isBreathing ? 280 : 150)
                        .animation(.easeInOut(duration: 4.0).repeatForever(autoreverses: true), value: isBreathing)
                    
                    Image(systemName: "wind")
                        .font(.system(size: 80))
                        .foregroundColor(Color.purple.opacity(0.6))
                        .scaleEffect(isBreathing ? 1.1 : 0.9)
                        .animation(.easeInOut(duration: 4.0).repeatForever(autoreverses: true), value: isBreathing)
                }
                
                Text(isBreathing ? "Hít vào thật sâu..." : "Thở ra chầm chậm...")
                    .font(.system(size: 28, weight: .medium, design: .rounded))
                    .foregroundColor(Color(red: 0.4, green: 0.5, blue: 0.6))
                    .opacity(isBreathing ? 1.0 : 0.5)
                    .animation(.easeInOut(duration: 4.0).repeatForever(autoreverses: true), value: isBreathing)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            isBreathing = true
            audioManager.playSoothingMusic()
            
            // Đã sửa: Bỏ tham số delay bên trong hàm speak. Nếu cần delay, ta dùng DispatchQueue bọc bên ngoài.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                TTSManager.shared.speak("Bé hãy hít thở sâu và thư giãn nhé")
            }
        }
        .onDisappear {
            audioManager.stopMusic()
            TTSManager.shared.stop()
        }
    }
}
