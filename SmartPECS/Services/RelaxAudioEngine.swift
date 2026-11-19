//
//  RelaxAudioEngine.swift
//  SmartPECS
//
//  Created by Minh Anh Nguyễn Trần on 17/11/26.
//


import AVFoundation
import Combine
import Foundation

class RelaxAudioEngine: ObservableObject {
    private var player: AVQueuePlayer?
    private var playerLooper: AVPlayerLooper?
    
    @Published var isPlaying: Bool = false
    @Published var volume: Float = 0.5 {
        didSet {
            player?.volume = volume
        }
    }
    
    init() {
        setupPlayer()
    }
    
    private func setupPlayer() {
        // ĐÂY LÀ NƠI GẮN LINK NHẠC: Bạn có thể thay bằng bất kỳ link nhạc trực tiếp (.mp3) nào trên mạng.
        // Link mẫu bên dưới là một bản nhạc Lofi piano thư giãn, không bản quyền.
        let urlString = "https://cdn.pixabay.com/download/audio/2022/05/27/audio_1808fbf07a.mp3?filename=lofi-study-112191.mp3"
        
        guard let url = URL(string: urlString) else {
            print("Link nhạc không hợp lệ")
            return
        }
        
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        
        // Sử dụng AVQueuePlayer chuyên trị cho việc lặp nhạc liền mạch
        player = AVQueuePlayer(playerItem: playerItem)
        player?.volume = self.volume
        
        // AVPlayerLooper giúp bài hát tự động quay vòng vô tận mà không bị ngắt quãng ở đoạn nối
        if let player = player {
            playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        }
    }
    
    func start() {
        do {
            // Cấu hình âm thanh: Cho phép phát nhạc nền êm dịu, trộn chung với các âm thanh khác của hệ thống
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try session.setActive(true)
            
            player?.play()
            DispatchQueue.main.async {
                self.isPlaying = true
            }
        } catch {
            print("Không thể khởi động Audio Session: \(error.localizedDescription)")
        }
    }
    
    func stop() {
        player?.pause()
        DispatchQueue.main.async {
            self.isPlaying = false
        }
    }
    
    deinit {
        player?.pause()
    }
}
