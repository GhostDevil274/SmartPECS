import SwiftUI

struct OnboardingView: View {
    // Biến lưu trạng thái vào bộ nhớ máy: Phụ huynh đã xem hướng dẫn chưa?
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            SensoryTheme.bgPrimary.ignoresSafeArea()
            
            TabView(selection: $currentPage) {
                // TRANG 1: Giới thiệu Bảng Giao Tiếp
                OnboardingPage(
                    icon: "hand.tap.fill",
                    iconColor: .blue,
                    title: "Bảng Giao Tiếp PECS",
                    description: "Hệ thống thẻ hình ảnh sinh động giúp trẻ dễ dàng thể hiện nhu cầu, cảm xúc và tương tác với thế giới xung quanh mà không bị áp lực ngôn ngữ."
                )
                .tag(0)
                
                // TRANG 2: Giới thiệu AI & ARKit
                OnboardingPage(
                    icon: "face.smiling.fill",
                    iconColor: .orange,
                    title: "Trí Tuệ Nhân Tạo & AR",
                    description: "Sử dụng camera quét 3D để giúp trẻ nhận diện cảm xúc (Vui, Buồn, Giận...) và các trò chơi tương tác tự động điều chỉnh độ khó theo khả năng của bé."
                )
                .tag(1)
                
                // TRANG 3: Giới thiệu Khu vực Phụ Huynh & Nút Bắt Đầu
                VStack(spacing: 30) {
                    OnboardingPage(
                        icon: "camera.macro",
                        iconColor: .green,
                        title: "Cá Nhân Hóa Bằng AI",
                        description: "Phụ huynh có thể theo dõi tiến độ học tập và tự chụp ảnh đồ vật trong nhà để AI tự động nhận diện, tạo thành thẻ học riêng biệt cho bé."
                    )
                    
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                        // Đánh dấu là đã xem, lần sau mở app sẽ không hiện nữa
                        withAnimation {
                            hasSeenOnboarding = true
                        }
                    }) {
                        Text("Bắt đầu trải nghiệm")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .shadow(color: .blue.opacity(0.4), radius: 8, y: 4)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 50)
                }
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}

// MARK: - Giao diện chung cho 1 trang Onboarding
struct OnboardingPage: View {
    let icon: String
    let iconColor: Color
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: icon)
                .font(.system(size: 100))
                .foregroundColor(iconColor)
                .padding(.bottom, 20)
                .shadow(color: iconColor.opacity(0.3), radius: 15, y: 10)
            
            Text(title)
                .font(.title.bold())
                .foregroundColor(SensoryTheme.textMain)
                .multilineTextAlignment(.center)
            
            Text(description)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            Spacer() // Đẩy nội dung lên cao một chút để nhường chỗ cho dấu chấm phân trang
        }
    }
}
