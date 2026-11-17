import SwiftUI
import UIKit

// Khung View giúp gọi Camera gốc của iPhone vào trong SwiftUI
struct AICameraView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        
        // Kiểm tra xem máy có Camera không (phòng trường hợp bạn chạy trên máy ảo Simulator)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            // Nếu chạy máy ảo, tự động chuyển sang mở Thư viện ảnh
            picker.sourceType = .photoLibrary
        }
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Điều phối viên (Coordinator) để lắng nghe sự kiện khi người dùng bấm nút "Chụp"
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: AICameraView
        
        init(_ parent: AICameraView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image // Truyền ảnh vừa chụp ra ngoài
            }
            parent.presentationMode.wrappedValue.dismiss() // Đóng camera lại
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
