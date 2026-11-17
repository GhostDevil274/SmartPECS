import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var isBreathing = false
    
    var body: some View {
        ZStack {
            if isActive {
                HomeMenuView()
            } else {
                ZStack {
                    SensoryTheme.bgPrimary.ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        // Đổi sang Icon Bộ Não AI rất ngầu và học thuật
                        Image(systemName: "brain.head.profile")
                            .font(.system(size: 80))
                            .foregroundColor(.orange)
                            .scaleEffect(isBreathing ? 1.1 : 0.95)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isBreathing)
                        
                        Text("SmartPECS")
                            .font(.system(size: 40, weight: .heavy, design: .rounded))
                            // Màu Xám Xanh Đậm (#2C3E50) giúp chữ nổi bật hoàn toàn trên nền nhạt
                            .foregroundColor(Color(red: 0.17, green: 0.24, blue: 0.31))
                            .opacity(isBreathing ? 1.0 : 0.6)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isBreathing)
                            
                        Text("Học vui vẻ, Giao tiếp tự tin!")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.4, green: 0.5, blue: 0.6))
                            .padding(.top, 10)
                    }
                }
            }
        }
        .onAppear {
            self.isBreathing = true
            
            // Xóa đoạn gọi TTSManager đi để app mở lên trong yên tĩnh
            
            // Tăng tốc độ load app lên 2 giây thay vì 3 giây để phụ huynh không phải chờ lâu
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeOut(duration: 0.5)) {
                    self.isActive = true
                }
            }
        }
    }
}
