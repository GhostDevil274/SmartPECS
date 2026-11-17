import Foundation
import UIKit
import Combine
import Vision // Framework lõi của Apple chuyên xử lý AI thị giác máy tính (Computer Vision)

class VisionManager {
    // Tạo pattern Singleton để dùng chung bộ não AI này trên toàn app
    static let shared = VisionManager()
    
    // Hàm nhận vào 1 bức ảnh (UIImage) và trả về tên đồ vật nhận diện được
    func classifyImage(_ image: UIImage, completion: @escaping (String?) -> Void) {
        // Chuyển đổi ảnh sang định dạng CoreGraphics để AI đọc được
        guard let cgImage = image.cgImage else {
            completion(nil)
            return
        }
        
        // 1. Khởi tạo request phân loại ảnh (Sử dụng Core ML model phân loại mặc định của iOS)
        let request = VNClassifyImageRequest { request, error in
            guard error == nil else {
                print("Lỗi nhận diện AI: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            // 2. Lấy danh sách kết quả, chọn kết quả top 1 (độ tự tin cao nhất)
            guard let observations = request.results as? [VNClassificationObservation],
                  let topResult = observations.first else {
                completion(nil)
                return
            }
            
            // 3. Trả về kết quả (Vision sẽ trả về từ vựng tiếng Anh, ví dụ: "apple", "teddy bear")
            DispatchQueue.main.async {
                completion(topResult.identifier)
            }
        }
        
        // ĐÃ XÓA DÒNG imageCropAndScaleOption GÂY LỖI
        // (Vision sẽ tự động scale và crop ảnh ngầm định cực kỳ chính xác)
        
        // 4. Đẩy tác vụ quét ảnh sang luồng nền (Background Thread) để không làm lag giao diện
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Lỗi thực thi Vision AI: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
