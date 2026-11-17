import Foundation

struct PecsCardModel: Identifiable, Hashable {
    let id: String
    let title: String
    let imageNames: [String] // Đổi từ String thành mảng các link ảnh [String]
    let category: String
    var isEnabled: Bool = true
    
    // Thuộc tính tiện ích để tự động bốc ngẫu nhiên 1 ảnh trong danh sách khi dùng
    var randomImage: String {
        imageNames.randomElement() ?? "photo"
    }
}
