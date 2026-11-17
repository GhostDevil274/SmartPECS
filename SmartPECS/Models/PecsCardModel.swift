//
//  PecsCardModel.swift
//  SmartPECS
//
//  Created by Minh Anh Nguyễn Trần on 5/11/26.
//

import Foundation

struct PecsCardModel: Identifiable, Codable {
    let id: String           // Mã định danh duy nhất (ví dụ: "c_01")
    let title: String        // Chữ hiển thị (ví dụ: "Uống nước")
    let imageName: String    // Tên icon hệ thống SF Symbols hoặc tên file trong Assets
    let category: String     // Phân loại: "Food", "Action",  "Play" để tô màu tương ứng
    var isEnabled: Bool      // Dành cho tính năng Phụ huynh khóa bớt thẻ
    
    // Hàm khởi tạo mặc định
    init(id: String, title: String, imageName: String, category: String, isEnabled: Bool = true) {
        self.id = id
        self.title = title
        self.imageName = imageName
        self.category = category
        self.isEnabled = isEnabled
    }
}
