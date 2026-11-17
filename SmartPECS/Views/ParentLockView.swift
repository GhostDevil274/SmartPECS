import SwiftUI

struct ParentLockView: View {
    @StateObject private var viewModel = ParentViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Group {
            if viewModel.isUnlocked {
                // Nhập đúng -> Mở khóa cho vào màn Cài đặt
                ParentSettingsView()
            } else {
                // Giao diện Khóa phép toán
                VStack(spacing: 30) {
                    HStack {
                        Spacer()
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    Text("Khu vực dành cho Phụ huynh")
                        .font(.title2.bold())
                    
                    Text("Vui lòng giải phép tính sau để tiếp tục:")
                        .foregroundColor(.secondary)
                    
                    Text(viewModel.questionString)
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.orange)
                    
                    TextField("Nhập kết quả", text: $viewModel.userInput)
                        .keyboardType(.numberPad)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .frame(width: 150)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.showError ? Color.red : Color.clear, lineWidth: 2)
                        )
                        .onChange(of: viewModel.userInput) { newValue in
                            // Tự động kiểm tra nếu nhập đủ 2 số
                            if newValue.count >= 2 {
                                viewModel.verifyAnswer()
                            }
                        }
                    
                    if viewModel.showError {
                        Text("Sai rồi, vui lòng thử lại!")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
    }
}
