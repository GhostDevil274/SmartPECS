//
//  ParentViewModel.swift
//  SmartPECS
//
//  Created by Minh Anh Nguyễn Trần on 5/11/26.
//

import Foundation
import Combine

class ParentViewModel: ObservableObject {
    @Published var enteredPIN: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var isError: Bool = false
    
    // Mã PIN mặc định (Sau này có thể nâng cấp lưu vào UserDefaults)
    private let correctPIN = "1234"
    
    func enterDigit(_ digit: String) {
        if enteredPIN.count < 4 {
            enteredPIN += digit
        }
        
        // Tự động kiểm tra khi đủ 4 số
        if enteredPIN.count == 4 {
            verifyPIN()
        }
    }
    
    func deleteDigit() {
        if !enteredPIN.isEmpty {
            enteredPIN.removeLast()
        }
        isError = false
    }
    
    private func verifyPIN() {
        if enteredPIN == correctPIN {
            isAuthenticated = true
            isError = false
        } else {
            isError = true
            // Tự động xóa PIN sai sau 0.5s để nhập lại
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.enteredPIN = ""
            }
        }
    }
    
    func logout() {
        isAuthenticated = false
        enteredPIN = ""
    }
}
