import SwiftUI

struct DynamicFlashcardView: View {
    @EnvironmentObject var gameManager: GameManager
    
    let targetCard: PecsCardModel
    let options: [PecsCardModel]
    
    // Lưu trữ ảnh ngẫu nhiên được chọn cho mỗi thẻ khi View khởi tạo
    @State private var cardImages: [String: String] = [:]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 30) {
            // Đề bài lớn, rõ ràng
            Text("Đâu là: \(targetCard.title)?")
                .font(.largeTitle.bold())
                .foregroundColor(.blue)
                .padding()
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(options) { card in
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        checkAnswer(selectedCard: card)
                    }) {
                        VStack {
                            // Lấy chuỗi ảnh, ưu tiên ảnh đã bốc random, nếu không có thì lấy ảnh đầu tiên
                            let displayString = cardImages[card.id] ?? card.imageNames.first ?? ""
                            
                            // Kiểm tra xem chuỗi có phải là Link Web không
                            if displayString.hasPrefix("http") {
                                AsyncImage(url: URL(string: displayString)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } else if phase.error != nil {
                                        Image(systemName: "photo.badge.exclamationmark")
                                            .foregroundColor(.red)
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .frame(width: 140, height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            } else {
                                // Nếu không phải link web, xử lý như icon SF Symbols nội bộ
                                Image(systemName: displayString.isEmpty ? "photo" : displayString)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 180)
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray.opacity(0.1), lineWidth: 2)
                        )
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                    }
                    .buttonStyle(CardButtonStyle()) // Áp dụng hiệu ứng lún khi bấm
                }
            }
            .padding()
        }
        .onAppear {
            // Bốc ngẫu nhiên 1 ảnh cho mỗi thẻ ngay khi màn hình vừa xuất hiện
            var chosenImages: [String: String] = [:]
            for card in options {
                chosenImages[card.id] = card.randomImage
            }
            self.cardImages = chosenImages
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                TTSManager.shared.speak("Đâu là \(targetCard.title)?")
            }
        }
    }
    
    func checkAnswer(selectedCard: PecsCardModel) {
        if selectedCard.id == targetCard.id {
            gameManager.levelPassed()
        } else {
            // Báo cho AI biết bé vừa chọn sai để tính toán lại độ khó
            gameManager.answerWrong()
        }
    }
}

// MARK: - Custom Button Style
// Hiệu ứng "lún" xuống khi bé bấm vào thẻ để tăng tương tác vật lý
struct CardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}
