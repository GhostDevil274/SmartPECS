import AVFoundation
import Foundation

class BGMManager {
    // Tạo Singleton để nhạc phát xuyên suốt các màn chơi mà không bị đứt quãng
    static let shared = BGMManager()
    
    private var player: AVQueuePlayer?
    private var playerLooper: AVPlayerLooper?
    
    private init() {
        setupBGM()
    }
    
    private func setupBGM() {
        // Link nhạc Acoustic/Ukulele vui vẻ, tươi sáng cho trẻ em (Không bản quyền)
        let urlString = "https://cdn.pixabay.com/download/audio/2021/11/25/audio_91b3ce3c26.mp3?filename=happy-kids-114751.mp3"
        
        guard let url = URL(string: urlString) else { return }
        
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        
        player = AVQueuePlayer(playerItem: playerItem)
        
        // TỐI QUAN TRỌNG: Âm lượng 15% để làm nhạc nền, không đè lên giọng đọc TTS
        player?.volume = 0.15 
        
        if let player = player {
            playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        }
    }
    
    func play() {
        do {
            let session = AVAudioSession.sharedInstance()
            // Dùng .mixWithOthers để nhạc nền và TTS chạy song song, không triệt tiêu nhau
            try session.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try session.setActive(true)
            
            player?.play()
        } catch {
            print("Lỗi BGM: \(error.localizedDescription)")
        }
    }
    
    func pause() {
        player?.pause()
    }
}