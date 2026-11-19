import SwiftUI

struct RelaxCornerView: View {
    // Để quay về trang chủ (Home)
    @Environment(\.presentationMode) var presentationMode
    
    // Khởi tạo bộ phát nhạc Lofi
    @StateObject private var audioEngine = RelaxAudioEngine()
    
    // Animation vòng tròn lan tỏa nhịp nhàng
    @State private var isBreathing = false
    
    var body: some View {
        ZStack {
            // Nền thư giãn nhẹ nhàng
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                // Nút Thoát - Điều hướng quay lại trang chủ
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                Spacer()
                
                // Khối hiệu ứng trực quan hình mặt trăng thở
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: isBreathing ? 250 : 150, height: isBreathing ? 250 : 150)
                        .blur(radius: 20)
                        .animation(
                            Animation.easeInOut(duration: 4.0).repeatForever(autoreverses: true),
                            value: isBreathing
                        )
                    
                    Image(systemName: "moon.stars.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                        .shadow(color: .purple.opacity(0.5), radius: 10, x: 0, y: 5)
                }
                
                Text("Góc Thư Giãn")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                // Cập nhật câu text hợp lý với nhạc Lofi
                Text("Hãy nhắm mắt lại và thả lỏng cùng giai điệu...")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                // Bảng điều khiển âm thanh
                VStack(spacing: 20) {
                    HStack {
                        Image(systemName: "speaker.wave.1.fill")
                            .foregroundColor(.white)
                        
                        Slider(value: $audioEngine.volume, in: 0.0...1.0)
                            .accentColor(.white)
                        
                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 40)
                    
                    Button(action: {
                        if audioEngine.isPlaying {
                            audioEngine.stop()
                        } else {
                            audioEngine.start()
                        }
                    }) {
                        HStack {
                            Image(systemName: audioEngine.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .font(.title)
                            Text(audioEngine.isPlaying ? "Tạm Dừng" : "Phát Nhạc")
                                .font(.headline)
                        }
                        .padding()
                        .frame(width: 220)
                        .background(Color.white.opacity(0.3))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            isBreathing = true
            // Tự động phát nhạc khi vào màn hình
            audioEngine.start()
        }
        .onDisappear {
            // ĐẢM BẢO CHẮC CHẮN 100%: Thoát màn hình là dừng nhạc, không bị lọt qua các màn khác
            audioEngine.stop()
        }
    }
}
