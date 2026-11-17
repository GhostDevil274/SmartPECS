import Foundation
import ARKit
import Combine

class EmotionViewModel: NSObject, ObservableObject, ARSessionDelegate {
    @Published var detectedEmotion: String = "😐"
    let session = ARSession()
    
    override init() {
        super.init()
        session.delegate = self
    }
    
    func startSession() {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func stopSession() {
        session.pause()
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let faceAnchor = anchors.compactMap({ $0 as? ARFaceAnchor }).first else { return }
        let blendShapes = faceAnchor.blendShapes
        
        // Lấy chỉ số các cơ mặt (giá trị trả về từ 0.0 đến 1.0)
        let smileLeft = blendShapes[.mouthSmileLeft]?.floatValue ?? 0
        let smileRight = blendShapes[.mouthSmileRight]?.floatValue ?? 0
        
        // Các cơ mặt quyết định biểu cảm "Buồn"
        let frownLeft = blendShapes[.mouthFrownLeft]?.floatValue ?? 0
        let frownRight = blendShapes[.mouthFrownRight]?.floatValue ?? 0
        let browInnerUp = blendShapes[.browInnerUp]?.floatValue ?? 0
        let lipPucker = blendShapes[.mouthPucker]?.floatValue ?? 0 // Cơ bĩu môi
        
        let browDownLeft = blendShapes[.browDownLeft]?.floatValue ?? 0
        let browDownRight = blendShapes[.browDownRight]?.floatValue ?? 0
        let sneer = blendShapes[.noseSneerLeft]?.floatValue ?? 0
        
        let jawOpen = blendShapes[.jawOpen]?.floatValue ?? 0
        let eyeBlinkLeft = blendShapes[.eyeBlinkLeft]?.floatValue ?? 0
        let eyeBlinkRight = blendShapes[.eyeBlinkRight]?.floatValue ?? 0
        
        DispatchQueue.main.async {
            // 1. Cười tươi
            if smileLeft > 0.5 && smileRight > 0.5 {
                self.detectedEmotion = "Cười tươi"
            }
            // 2. Ngạc nhiên (Há miệng)
            else if jawOpen > 0.6 {
                self.detectedEmotion = "Ngạc nhiên"
            }
            // 3. Giận dữ (Nhíu mày hoặc nhăn mũi)
            else if (browDownLeft > 0.5 && browDownRight > 0.5) || sneer > 0.5 {
                self.detectedEmotion = "Giận dữ"
            }
            // 4. Nhắm mắt
            else if eyeBlinkLeft > 0.8 && eyeBlinkRight > 0.8 {
                self.detectedEmotion = "Nhắm mắt"
            }
            // 5. KHÓC / BUỒN (Đã hạ cực thấp độ khó)
            // Chấp nhận 1 trong 3 trường hợp: Hơi trễ miệng (> 0.25) HOẶC nhướn đầu mày (> 0.4) HOẶC bĩu môi (> 0.3)
            else if (frownLeft > 0.25 && frownRight > 0.25) || browInnerUp > 0.4 || lipPucker > 0.3 {
                self.detectedEmotion = "Khóc / Buồn"
            }
            // Mặc định
            else {
                self.detectedEmotion = "😐"
            }
        }
    }
}
