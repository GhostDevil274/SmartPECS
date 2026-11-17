//
//  HomeMenuView.swift
//  SmartPECS
//
//  Created by Minh Anh Nguyễn Trần on 5/11/26.
//

import SwiftUI

struct HomeMenuView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                // 1. Nút chuyển sang Bảng giao tiếp PECS
                NavigationLink(destination: PecsBoardView()) {
                    HStack {
                        Image(systemName: "bubble.left.and.bubble.right.fill")
                            .font(.largeTitle)
                        Text("Bảng PECS")
                            .font(.title2.bold())
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .background(SensoryTheme.cardAction)
                    .foregroundColor(SensoryTheme.textMain)
                    .cornerRadius(16)
                }

                // 2. Nút chuyển sang Gương Cảm Xúc
                NavigationLink(destination: EmotionMirrorView()) {
                    HStack {
                        Image(systemName: "camera.viewfinder")
                            .font(.largeTitle)
                        Text("Gương Cảm Xúc")
                            .font(.title2.bold())
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .background(SensoryTheme.cardPlay)
                    .foregroundColor(SensoryTheme.textMain)
                    .cornerRadius(16)
                }

                Spacer()
            }
            .padding()
            .background(SensoryTheme.bgPrimary.ignoresSafeArea())
            .navigationTitle("Smart PECS")
            // 3. Nút bánh răng cài đặt (Góc trên bên phải)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ParentLockView()) {
                        Image(systemName: "gearshape.fill")
                            .font(.title2)
                            .foregroundColor(SensoryTheme.textSecondary)
                    }
                }
            }
        }
    }
}
