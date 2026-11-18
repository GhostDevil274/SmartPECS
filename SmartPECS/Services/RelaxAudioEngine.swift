import AVFoundation
import Foundation

class RelaxAudioEngine: ObservableObject {
    private var engine = AVAudioEngine()
    private var sourceNode: AVAudioSourceNode?
    
    @Published var isPlaying: Bool = false
    @Published var volume: Float = 0.5 {
        didSet {
            engine.mainMixerNode.outputVolume = volume
        }
    }
    
    init() {
        setupEngine()
    }
    
    private func setupEngine() {
        let format = engine.outputNode.inputFormat(forBus: 0)
        let sampleRate = Float(format.sampleRate)
        
        // Các biến trạng thái dùng trong khối DSP (Digital Signal Processing)
        // Dùng con trỏ mảng để tránh lỗi đa luồng trong Swift
        var brownState: Float = 0.0
        var phase: Float = 0.0
        
        // Tần số dao động của sóng biển (0.08 Hz = khoảng 12.5 giây cho một chu kỳ sóng)
        let waveFrequency: Float = 0.08
        let phaseIncrement = (2.0 * .pi * waveFrequency) / sampleRate
        
        // AVAudioSourceNode tạo âm thanh trực tiếp từ code
        sourceNode = AVAudioSourceNode { _, _, frameCount, audioBufferList -> OSStatus in
            let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
            
            for frame in 0..<Int(frameCount) {
                // 1. Tạo Brown Noise (Mô phỏng âm thanh nước, loại bỏ tiếng xì chói tai của White Noise)
                let whiteNoise = Float.random(in: -1.0...1.0)
                brownState = (0.02 * whiteNoise) + (0.98 * brownState)
                
                // 2. Tạo LFO (Low-Frequency Oscillator) mô phỏng tiếng sóng vỗ dạt dào
                phase += phaseIncrement
                if phase > 2.0 * .pi {
                    phase -= 2.0 * .pi
                }
                
                // Chuyển đổi sóng Sine (từ -1 đến 1) sang dải biên độ (từ 0.2 đến 1.0) để sóng không bao giờ tắt hẳn
                let lfo = (sin(phase) + 1.0) / 2.0
                let amplitude = 0.2 + (lfo * 0.8)
                
                // 3. Kết hợp lại và khuếch đại nhẹ
                let sample = brownState * amplitude * 3.0
                
                // Ghi sample vào tất cả các kênh (Stereo/Mono)
                for buffer in ablPointer {
                    let buf = UnsafeMutableBufferPointer<Float>(buffer)
                    buf[frame] = sample
                }
            }
            return noErr
        }
        
        if let sourceNode = sourceNode {
            engine.attach(sourceNode)
            engine.connect(sourceNode, to: engine.mainMixerNode, format: format)
        }
        
        engine.mainMixerNode.outputVolume = self.volume
    }
    
    func start() {
        do {
            // Cấu hình Session hòa trộn âm thanh, không làm ngắt TTS hoặc các âm thanh khác
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.ambient, mode: .default, options: [.mixWithOthers])
            try session.setActive(true)
            
            try engine.start()
            DispatchQueue.main.async {
                self.isPlaying = true
            }
        } catch {
            print("Không thể khởi động RelaxAudioEngine: \(error.localizedDescription)")
        }
    }
    
    func stop() {
        engine.pause()
        DispatchQueue.main.async {
            self.isPlaying = false
        }
    }
    
    // Đảm bảo dọn dẹp bộ nhớ và tắt âm thanh khi class bị hủy
    deinit {
        engine.stop()
    }
}