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
    
    var body: some View {
        NavigationView {
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
                
                Section(header: Text("Âm thanh & Cấu hình")) {
                    Toggle("Nhạc nền vui nhộn", isOn: .constant(true))
                    Toggle("Đọc tên thẻ (TTS)", isOn: .constant(true))
                }
            }
            .navigationTitle("Cài đặt Phụ huynh")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Đóng") { dismiss() }
                }
            }
        }
    }
}
