import SwiftUI

struct HomeMenuView: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    
    @State private var showParentGate = false
    @State private var mathAnswer = ""
    @State private var navigateToParent = false
    @State private var num1 = Int.random(in: 5...15)
    @State private var num2 = Int.random(in: 5...15)
    
    let columns = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]
    
    var body: some View {
        NavigationView {
            ZStack {
                SensoryTheme.bgPrimary.ignoresSafeArea()
                
                VStack(spacing: 25) {
                    // 1. HEADER
                    VStack(spacing: 8) {
                        Image(systemName: "brain.head.profile")
                            .font(.system(size: 45))
                            .foregroundColor(.orange)
                        
                        Text("SmartPECS")
                            .font(.system(size: 30, weight: .heavy, design: .rounded))
                            .foregroundColor(Color(red: 0.17, green: 0.24, blue: 0.31))
                    }
                    .padding(.top, 20)
                    
                    // 2. LƯỚI 2x2
                    LazyVGrid(columns: columns, spacing: 20) {
                        NavigationLink(destination: PecsBoardView()) {
                            SquareMenuCard(
                                title: "Giao Tiếp",
                                icon: "hand.tap.fill",
                                bgColor: Color.blue.opacity(0.15),
                                iconColor: .blue
                            )
                        }
                        
                        NavigationLink(destination: GameSessionView()) {
                            SquareMenuCard(
                                title: "Chơi & Học",
                                icon: "gamecontroller.fill",
                                bgColor: Color.green.opacity(0.15),
                                iconColor: .green
                            )
                        }
                        
                        NavigationLink(destination: EmotionMirrorView()) {
                            SquareMenuCard(
                                title: "Cảm Xúc",
                                icon: "face.smiling.fill",
                                bgColor: Color.orange.opacity(0.15),
                                iconColor: .orange
                            )
                        }
                        
                        NavigationLink(destination: RelaxCornerView()) {
                            SquareMenuCard(
                                title: "Thư Giãn",
                                icon: "moon.stars.fill",
                                bgColor: Color.purple.opacity(0.15),
                                iconColor: .purple
                            )
                        }
                    }
                    .padding(.horizontal, 25)
                    
                    Spacer()
                    
                    // 3. NÚT PHỤ HUYNH
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        generateNewMathProblem()
                        showParentGate = true
                    }) {
                        HStack {
                            Image(systemName: "gearshape.fill")
                            Text("Khu vực Phụ huynh")
                        }
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.vertical, 14)
                        .padding(.horizontal, 30)
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(25)
                    }
                    .padding(.bottom, 20)
                    
                    // NAVIGATION SANG KHU VỰC PHỤ HUYNH
                    NavigationLink(destination: ParentSettingsView(), isActive: $navigateToParent) {
                        EmptyView()
                    }
                }
            }
            .alert("Cổng Bảo Mật", isPresented: $showParentGate) {
                TextField("Nhập kết quả", text: $mathAnswer)
                    .keyboardType(.numberPad)
                Button("Xác nhận", action: checkMathGate)
                Button("Hủy", role: .cancel) { mathAnswer = "" }
            } message: {
                Text("Vui lòng giải phép tính:\n\(num1) + \(num2) = ?")
            }
            .fullScreenCover(isPresented: Binding(
                get: { !hasSeenOnboarding },
                set: { _ in }
            )) {
                OnboardingView()
            }
            // Ẩn Navigation Bar mặc định ở trang chủ để UI được thoáng
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func generateNewMathProblem() {
        num1 = Int.random(in: 5...15)
        num2 = Int.random(in: 5...15)
        mathAnswer = ""
    }
    
    func checkMathGate() {
        if Int(mathAnswer) == (num1 + num2) {
            navigateToParent = true
        } else {
            // (Giả sử bạn có FXManager, nếu không thì cứ bỏ dòng này đi)
            FXManager.shared.playError()
        }
        mathAnswer = ""
    }
}

// MARK: - Component Thẻ Vuông Layout Mới
struct SquareMenuCard: View {
    let title: String
    let icon: String
    let bgColor: Color
    let iconColor: Color
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 45))
                .foregroundColor(iconColor)
            
            Text(title)
                .font(.headline.bold())
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, minHeight: 140)
        .background(bgColor)
        .cornerRadius(25)
        .shadow(color: iconColor.opacity(0.15), radius: 10, y: 5)
    }
}
