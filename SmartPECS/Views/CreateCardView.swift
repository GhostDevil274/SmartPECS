import SwiftUI

struct CreateCardView: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    // Trạng thái AI
    @State private var isAnalyzing = false
    @State private var aiResult: String = ""
    @State private var customVietnameseTitle: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // 1. KHU VỰC HIỂN THỊ ẢNH
                if let image = inputImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .black.opacity(0.2), radius: 10)
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(SensoryTheme.bgPrimary)
                        .frame(width: 250, height: 250)
                        .overlay(
                            VStack(spacing: 10) {
                                Image(systemName: "camera.viewfinder")
                                    .font(.system(size: 50))
                                    .foregroundColor(.gray)
                                Text("Chụp một đồ vật")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }
                        )
                        .shadow(color: .black.opacity(0.05), radius: 5)
                }
                
                // 2. NÚT GỌI CAMERA
                Button(action: {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    showingImagePicker = true
                }) {
                    Label(inputImage == nil ? "Mở Camera" : "Chụp lại ảnh khác", systemImage: "camera.fill")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                        .shadow(color: .blue.opacity(0.3), radius: 5, y: 3)
                }
                .padding(.horizontal, 40)
                
                // 3. KHU VỰC AI PHÂN TÍCH & KẾT QUẢ
                if isAnalyzing {
                    VStack {
                        ProgressView()
                            .scaleEffect(1.5)
                            .padding()
                        Text("Trí tuệ nhân tạo đang quét hình ảnh...")
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 20)
                } else if !aiResult.isEmpty {
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundColor(.orange)
                            Text("AI nhận diện đây là:")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        // Kết quả tiếng Anh từ Apple Vision
                        Text(aiResult.capitalized)
                            .font(.title2.bold())
                            .foregroundColor(SensoryTheme.successGreen)
                        
                        Divider()
                        
                        // Phụ huynh nhập tên Tiếng Việt cho thẻ
                        Text("Nhập tên hiển thị trên thẻ (Tiếng Việt):")
                            .font(.subheadline)
                        
                        TextField("VD: Con gấu bông, Bát cơm...", text: $customVietnameseTitle)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        
                        // Nút lưu thẻ
                        Button(action: {
                            // (Logic lưu thẻ vào kho dữ liệu sẽ xử lý sau)
                            TTSManager.shared.speak("Đã lưu thẻ mới")
                        }) {
                            Text("Lưu thẻ PECS mới")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(customVietnameseTitle.isEmpty ? Color.gray : SensoryTheme.successGreen)
                                .cornerRadius(12)
                        }
                        .disabled(customVietnameseTitle.isEmpty)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.05), radius: 8)
                    .padding(.horizontal, 20)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .padding(.vertical, 30)
        }
        .navigationTitle("Tạo thẻ thông minh (AI)")
        // Bật màn hình Camera khi biến showingImagePicker = true
        .sheet(isPresented: $showingImagePicker, onDismiss: analyzeImageWithAI) {
            AICameraView(selectedImage: $inputImage)
        }
    }
    
    // HÀM GỌI AI SAU KHI CHỤP ẢNH XONG
    func analyzeImageWithAI() {
        guard let image = inputImage else { return }
        
        withAnimation {
            isAnalyzing = true
            aiResult = ""
            customVietnameseTitle = ""
        }
        
        // Gọi bộ não VisionManager
        VisionManager.shared.classifyImage(image) { result in
            withAnimation {
                isAnalyzing = false
                if let result = result {
                    // Cắt chuỗi kết quả lấy chữ đầu tiên (vì Vision trả về "teddy, teddy bear")
                    self.aiResult = result.components(separatedBy: ",").first ?? result
                } else {
                    self.aiResult = "Không thể nhận diện rõ đồ vật"
                }
            }
        }
    }
}
