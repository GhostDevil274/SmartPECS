import Foundation
import AVFoundation
import Combine

class TTSManager: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    static let shared = TTSManager()
    
    // Dùng lại 1 bộ đọc duy nhất, không hủy đi tạo lại nữa để tránh nổ âm thanh
    private let synthesizer = AVSpeechSynthesizer()
    
    @Published var isSpeaking: Bool = false

    private override init() {
        super.init()
        synthesizer.delegate = self
        
        DispatchQueue.global(qos: .background).async {
            do {
                // SỬA LỖI RÈ: Dùng chế độ .spokenAudio chuyên dụng cho giọng nói để tiếng phát ra trong trẻo, ấm áp nhất
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("Lỗi cấu hình AudioSession: \(error.localizedDescription)")
            }
        }
    }

    // Sửa lại hàm speak, mặc định delay 0.4 giây để chờ hiệu ứng chuyển màn hình kết thúc
    func speak(_ text: String, delay: Double = 0.4) {
        let cleanText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanText.isEmpty else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if self.synthesizer.isSpeaking {
                self.synthesizer.stopSpeaking(at: .immediate)
            }
            
            let utterance = AVSpeechUtterance(string: cleanText)
            utterance.voice = AVSpeechSynthesisVoice(language: "vi-VN")
            
            // BỎ ÉP TỐC ĐỘ VÀ CAO ĐỘ: Để iOS tự quyết định mức mượt mà nhất, triệt tiêu hoàn toàn sự rung/méo tiếng
            
            self.isSpeaking = true
            
            // Ép hệ thống chờ hết thời gian delay (chuyển cảnh xong) mới đọc
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.synthesizer.speak(utterance)
            }
        }
    }

    func stop() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.synthesizer.isSpeaking {
                self.synthesizer.stopSpeaking(at: .immediate)
                self.isSpeaking = false
            }
        }
    }
    
    // MARK: - Delegate
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { self.isSpeaking = false }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { self.isSpeaking = false }
    }
}
