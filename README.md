# 🧩 SmartPECS (iOS App)

**SmartPECS** là ứng dụng iOS được phát triển hoàn toàn bằng SwiftUI, ứng dụng phương pháp Giao tiếp qua Hình ảnh (PECS - Picture Exchange Communication System) kết hợp cùng công nghệ hỗ trợ để giúp trẻ tự kỷ phát triển ngôn ngữ, thể hiện nhu cầu và nhận biết cảm xúc một cách dễ dàng, trực quan.

Dự án được thiết kế với tiêu chí **Offline-First** và **Privacy-First**, đảm bảo trải nghiệm mượt mà, không bị gián đoạn bởi kết nối mạng, đồng thời bảo mật tuyệt đối dữ liệu hình ảnh và thói quen của trẻ.

## ✨ Tính năng nổi bật

*   🗂 **Bảng Giao Tiếp (PECS Board):** Cung cấp hệ thống thẻ hình ảnh trực quan. Trẻ chỉ cần chạm vào thẻ để ứng dụng phát âm thanh tương ứng. Thời gian phản hồi cực nhanh (Delay = 0.0s).
*   🗣 **Giọng Đọc Nhân Tạo (TTS - Text to Speech):** Tích hợp `AVFoundation` với cấu hình audio session chuyên dụng (`.spokenAudio`), mang lại giọng đọc tiếng Việt mượt mà, trong trẻo và thân thiện với trẻ em. Khắc phục triệt để lỗi nhiễu âm, méo tiếng và kẹt âm thanh khi chuyển màn hình.
*   📸 **Gương Cảm Xúc (Emotion Mirror):** Sử dụng `CameraManager` tối ưu luồng `AVCaptureSession` (tương thích chuẩn iOS 17+ với `videoRotationAngle`). Tính năng này bắt khung hình theo thời gian thực (30 FPS) giúp AI nhận diện và phản hồi lại biểu cảm khuôn mặt của trẻ.
*   🧠 **Thẻ Học Thông Minh (AI Flashcards):** Tích hợp công nghệ **SwiftData** thay thế Core Data để lưu trữ các bộ thẻ (Flashcard) được cá nhân hóa. Hình ảnh được lưu an toàn trong Document Directory cục bộ, giúp ứng dụng không bị phình to bộ nhớ (Memory Bloat).
*   🔋 **Tối Ưu Hiệu Năng & Pin:** Quản lý vòng đời (Lifecycle) chặt chẽ thông qua kiến trúc MVVM. Tự động ngắt Camera và Timer khi màn hình bị ẩn (`.onDisappear`) để tiết kiệm pin tối đa.

## 🛠 Kiến trúc & Công nghệ (Tech Stack)

*   **Ngôn ngữ:** Swift 5+
*   **Giao diện (UI):** SwiftUI
*   **Kiến trúc:** MVVM (Model - View - ViewModel)
*   **Cơ sở dữ liệu cục bộ (Local Database):** SwiftData
*   **Xử lý Đa phương tiện:** `AVFoundation` (Camera capture, Audio Playback, Speech Synthesis).
*   **Lập trình Bất đồng bộ:** Combine & GCD (Grand Central Dispatch).

## 🚀 Hướng dẫn Cài đặt & Chạy ứng dụng

### Yêu cầu hệ thống
*   **IDE:** Xcode 15.0 trở lên.
*   **Hệ điều hành tối thiểu:** iOS 17.0+
*   *Lưu ý:* Để kiểm thử được tính năng Giọng đọc (TTS) và Gương Cảm Xúc (Camera), khuyến nghị chạy ứng dụng trên **Thiết bị thật (Physical iPhone/iPad)**, Simulator có thể không hỗ trợ đầy đủ các module phần cứng này.

### Các bước cài đặt
1. Clone repository về máy tính:
   ```bash
   git clone <đường-dẫn-repo-của-bạn>
   ```
2. Mở thư mục dự án, nhấp đúp vào file `SmartPECS.xcodeproj` để mở dự án bằng Xcode.
3. Trong Xcode, chọn thiết bị đích (Target Device) của bạn.
4. Điều hướng đến tab **Signing & Capabilities**, cấu hình lại Team bằng tài khoản Apple ID của bạn.
5. Nhấn **Cmd + R** (hoặc nút Play) để Build và Run ứng dụng.

## 📁 Cấu trúc Thư mục chính (Dự kiến)

```text
SmartPECS/
├── App/
│   ├── SmartPECSApp.swift       # Entry point, Khởi tạo SwiftData ModelContainer
│   └── ContentView.swift        # View điều hướng chính
├── Managers/
│   ├── TTSManager.swift         # Quản lý hàng đợi và phát âm thanh
│   └── CameraManager.swift      # Quản lý AVCaptureSession, xoay góc camera
├── Models/
│   └── SwiftDataModels.swift    # Định nghĩa Schema (CardModel, CategoryModel)
├── ViewModels/
│   ├── EmotionViewModel.swift   # Xử lý logic Gương Cảm Xúc
│   └── GameViewModel.swift      # Xử lý logic vòng đời Game/Thẻ
├── Views/
│   ├── PecsBoardView.swift      # Màn hình Bảng giao tiếp
│   └── EmotionMirrorView.swift  # Màn hình Gương Cảm Xúc
└── Assets.xcassets/             # Lưu trữ icon, màu sắc (AccentColor)
```

## 📝 Quyền lợi và Bảo mật
Ứng dụng yêu cầu cấp quyền để hoạt động đúng chức năng:
*   `NSCameraUsageDescription`: Sử dụng camera trước để tương tác với tính năng Gương Cảm Xúc.
*   `NSMicrophoneUsageDescription`: (Nếu có dùng nhận diện giọng nói).
Dữ liệu của trẻ hoàn toàn được giữ trong môi trường sandbox của thiết bị nội bộ, không có bất kỳ API nào đẩy dữ liệu cá nhân lên máy chủ đám mây bên thứ ba.