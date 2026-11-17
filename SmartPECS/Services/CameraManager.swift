import Foundation
import AVFoundation
import Combine

// Giao thức (Protocol) để bắn từng khung hình (frame) ra ngoài cho AI xử lý
protocol CameraManagerDelegate: AnyObject {
    func didOutput(sampleBuffer: CMSampleBuffer)
}

class CameraManager: NSObject, ObservableObject {
    @Published var permissionGranted = false
    let captureSession = AVCaptureSession()
    weak var delegate: CameraManagerDelegate?
    
    override init() {
        super.init()
        checkPermission()
    }
    
    // 1. Kiểm tra quyền truy cập Camera
    private func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            permissionGranted = true
            setupCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    self?.permissionGranted = granted
                    if granted { self?.setupCamera() }
                }
            }
        default:
            permissionGranted = false
        }
    }
    
    // 2. Thiết lập luồng hình ảnh
    private func setupCamera() {
        // Giảm độ phân giải xuống VGA (640x480) để tối ưu hiệu năng Edge AI
        captureSession.sessionPreset = .vga640x480
        
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: frontCamera) else { return }
        
        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        // Tạo một luồng (thread) riêng để không làm đơ giao diện chính
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
            
            // Xoay video cho đúng chiều dọc và lật gương (như soi gương thật)
            if let connection = videoOutput.connection(with: .video) {
                connection.videoOrientation = .portrait
                connection.isVideoMirrored = true
            }
        }
    }
    
    // 3. Điều khiển Bật/Tắt
    func startSession() {
        DispatchQueue.global(qos: .background).async {
            if !self.captureSession.isRunning {
                self.captureSession.startRunning()
            }
        }
    }
    
    func stopSession() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
}

// 4. Bắt từng khung hình liên tục (30 FPS)
extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        delegate?.didOutput(sampleBuffer: sampleBuffer)
    }
}
