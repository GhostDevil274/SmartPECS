import Foundation
import SwiftUI

struct PecsBoardView: View {
    // Khởi tạo bộ não logic cho màn hình này
    @StateObject private var viewModel = PecsViewModel()
    // Chia màn hình thành 2 cột đều nhau
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    // Lưu trữ ảnh ngẫu nhiên được bốc cho mỗi thẻ khi mở bảng
    @State private var cardImages: [String: String] = [:]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.cards) { card in
                    Button(action: {
                        viewModel.handleCardTap(card: card)
                    }) {
                        VStack(spacing: 12) {
                            // Lấy URL ảnh đã được bốc ngẫu nhiên
                            if let imageUrl = cardImages[card.id], imageUrl.hasPrefix("http") {
                                AsyncImage(url: URL(string: imageUrl)) { phase in
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
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            } else {
                                // Fallback nếu không có ảnh mạng
                                Image(systemName: card.imageNames.first ?? "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                            }
                            
                            Text(card.title)
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                        }
                        .frame(maxWidth: .infinity, minHeight: 140)
                        // Đổ màu nền tùy theo phân loại thẻ
                        .background(getCategoryColor(for: card.category))
                        .foregroundColor(SensoryTheme.textMain)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 3)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .background(SensoryTheme.bgPrimary.ignoresSafeArea())
        .navigationTitle("Bảng Giao Tiếp")
        .onAppear {
            // Khi mở bảng, bốc ngẫu nhiên 1 ảnh cho mỗi thẻ
            var chosenImages: [String: String] = [:]
            for card in viewModel.cards {
                chosenImages[card.id] = card.randomImage
            }
            self.cardImages = chosenImages
        }
    }
    
    // Hàm phụ trợ để làm code gọn gàng, không bị lỗi type-check
    func getCategoryColor(for category: String) -> Color {
        switch category {
        case "Food": return SensoryTheme.cardFood
        case "Action": return SensoryTheme.cardAction
        case "Play": return SensoryTheme.cardPlay
        default: return Color.white
        }
    }
}
