import SwiftUI

struct ParentSettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    // Lấy dữ liệu đã lưu từ GameManager
    @AppStorage("totalPlayed") var totalPlayed: Int = 0
    @AppStorage("totalCorrect") var totalCorrect: Int = 0
    @AppStorage("totalWrong") var totalWrong: Int = 0
    
    var accuracy: Double {
        guard totalPlayed > 0 else { return 0.0 }
        return (Double(totalCorrect) / Double(totalPlayed)) * 100
    }
    
    // [TÍNH NĂNG AI - INSIGHTS] Hàm AI sinh ra lời khuyên dựa trên dữ liệu học tập
    func generateAIAdvice() -> String {
        // Cần một lượng data tối thiểu để phân tích
        guard totalPlayed >= 5 else {
            return "Hệ thống cần bé chơi thêm vài lần nữa (ít nhất 5 câu) để AI có thể phân tích hành vi chính xác."
        }
        
        if accuracy >= 80 {
            return "Bé đang học rất tuyệt vời! Khả năng nhận thức hình ảnh của bé rất tốt. Phụ huynh nên chuyển sang dùng 'AI Camera' hoặc 'Bảng Giao Tiếp' để bé thực hành biểu đạt thực tế nhé."
        } else if accuracy >= 50 {
            return "Bé đang tiến bộ đều đặn. Phụ huynh hãy cố gắng chơi cùng bé, cầm tay bé chỉ vào thẻ đúng ở vài màn đầu để bé làm quen với thao tác trên màn hình."
        } else {
            return "Có vẻ bé đang mất tập trung hoặc các thẻ hiện tại hơi khó. Hệ thống AI đã tự động giảm số lượng thẻ để bé không bị ngợp. Phụ huynh có thể đưa bé vào 'Góc Thư Giãn' nghe nhạc một chút trước khi học tiếp."
        }
    }
    
    var body: some View {
        // Đã xóa bỏ NavigationView dư thừa bọc ngoài Form. Do NavigationLink ở HomeMenuView đã bọc rồi.
        Form {
            // KHU VỰC THỐNG KÊ (DASHBOARD)
            Section(header: Text("Tiến độ học tập của bé")) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tổng số câu đã chơi:")
                        Text("Trả lời đúng:")
                        Text("Trả lời sai:")
                        Text("Tỷ lệ chính xác:")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 8) {
                        Text("\(totalPlayed)").bold()
                        Text("\(totalCorrect)").foregroundColor(.green).bold()
                        Text("\(totalWrong)").foregroundColor(.red).bold()
                        Text(String(format: "%.1f %%", accuracy))
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.vertical, 5)
                
                // Nút reset dữ liệu
                Button(action: {
                    totalPlayed = 0; totalCorrect = 0; totalWrong = 0
                }) {
                    Text("Xóa dữ liệu học tập")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
            // [THÊM MỚI] KHU VỰC PHÂN TÍCH TỪ AI
            Section(header: Text("🤖 AI Phân Tích & Gợi Ý")) {
                HStack(alignment: .top) {
                    Image(systemName: "sparkles")
                        .foregroundColor(.orange)
                        .font(.title2)
                    
                    Text(generateAIAdvice())
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .padding(.leading, 5)
                        .fixedSize(horizontal: false, vertical: true) // Đảm bảo text dài không bị cắt mất chữ
                }
                .padding(.vertical, 8)
            }
            
            Section(header: Text("Âm thanh & Cấu hình")) {
                Toggle("Nhạc nền vui nhộn", isOn: .constant(true))
                Toggle("Đọc tên thẻ (TTS)", isOn: .constant(true))
            }
        }
        .navigationTitle("Cài đặt Phụ huynh")
        // Hiển thị Navigation Bar khi vào màn hình con
        .navigationBarHidden(false)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Đóng") { dismiss() }
            }
        }
    }
}
