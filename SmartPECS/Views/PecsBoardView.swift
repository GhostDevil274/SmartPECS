import Foundation
import SwiftUI

struct PecsBoardView: View {
    @StateObject private var viewModel = PecsViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var cardImages: [String: String] = [:]
    
    // CÁC BIẾN QUẢN LÝ TRẠNG THÁI AI & NHẬP LIỆU
    @State private var rawInput: String = ""
    @State private var generatedSentence: String = ""
    @State private var isProcessing: Bool = false
    @State private var activeMode: String = ""
    
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            
            // ==========================================
            // KHU VỰC 1: SMART SENTENCE BUILDER (HYBRID AI)
            // ==========================================
            VStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Từ khóa / Thẻ đã chọn:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    HStack {
                        TextField("VD: Nước uống muốn con...", text: $rawInput)
                            .focused($isInputActive)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                        
                        if !rawInput.isEmpty {
                            Button(action: {
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                rawInput = ""
                                generatedSentence = ""
                                activeMode = ""
                            }) {
                                Image(systemName: "trash.circle.fill").font(.title).foregroundColor(.red.opacity(0.8))
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                Button(action: {
                    isInputActive = false
                    buildSentence()
                }) {
                    HStack {
                        if isProcessing {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                            Text("Đang phân tích ngữ nghĩa...")
                        } else {
                            Image(systemName: "sparkles")
                            Text("Tạo Câu Hoàn Chỉnh")
                        }
                    }
                    .font(.headline)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(rawInput.isEmpty || isProcessing ? Color.gray.opacity(0.5) : Color.indigo)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .disabled(rawInput.isEmpty || isProcessing)
                .padding(.horizontal)
                
                // Ô hiển thị Kết quả
                if !generatedSentence.isEmpty {
                    VStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text("Câu giao tiếp hoàn chỉnh:")
                                    .font(.caption)
                                    .foregroundColor(.indigo)
                                Spacer()
                                Text(activeMode)
                                    .font(.caption2).bold()
                                    .padding(.horizontal, 6).padding(.vertical, 2)
                                    .background(activeMode.contains("Online") ? Color.green.opacity(0.2) : Color.orange.opacity(0.2))
                                    .foregroundColor(activeMode.contains("Online") ? .green : .orange)
                                    .cornerRadius(4)
                            }
                            
                            Text(generatedSentence)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .background(Color.indigo.opacity(0.1))
                        .cornerRadius(12)
                        
                        Button(action: {
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            TTSManager.shared.speak(generatedSentence)
                        }) {
                            HStack {
                                Image(systemName: "speaker.wave.2.fill")
                                Text("Đọc Câu Này")
                            }
                            .font(.headline)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top, 12)
            .padding(.bottom, 15)
            .background(Color.gray.opacity(0.08))
            
            // ==========================================
            // KHU VỰC 2: KHO THẺ PECS
            // ==========================================
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.cards) { card in
                        Button(action: {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            if rawInput.isEmpty {
                                rawInput = card.title
                            } else {
                                rawInput += " \(card.title)"
                            }
                            generatedSentence = ""
                            activeMode = ""
                            viewModel.handleCardTap(card: card)
                        }) {
                            VStack(spacing: 12) {
                                if let imageUrl = cardImages[card.id], imageUrl.hasPrefix("http") {
                                    AsyncImage(url: URL(string: imageUrl)) { phase in
                                        if let image = phase.image {
                                            image.resizable().scaledToFill()
                                        } else if phase.error != nil {
                                            Image(systemName: "photo.badge.exclamationmark").foregroundColor(.red)
                                        } else {
                                            ProgressView()
                                        }
                                    }
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                } else {
                                    Image(systemName: card.imageNames.first ?? "photo")
                                        .resizable().scaledToFit().frame(width: 60, height: 60)
                                }
                                Text(card.title).font(.system(size: 18, weight: .semibold, design: .rounded))
                            }
                            .frame(maxWidth: .infinity, minHeight: 140)
                            .background(getCategoryColor(for: card.category))
                            .foregroundColor(SensoryTheme.textMain)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 3)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
        .background(SensoryTheme.bgPrimary.ignoresSafeArea(edges: .bottom))
        .navigationTitle("Bảng Giao Tiếp")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Xong") { isInputActive = false }
            }
        }
        .onAppear {
            var chosenImages: [String: String] = [:]
            for card in viewModel.cards { chosenImages[card.id] = card.randomImage }
            self.cardImages = chosenImages
            BGMManager.shared.play()
        }
        .onDisappear { BGMManager.shared.pause() }
    }
    
    func getCategoryColor(for category: String) -> Color {
        switch category {
        case "Food": return SensoryTheme.cardFood
        case "Action": return SensoryTheme.cardAction
        case "Play": return SensoryTheme.cardPlay
        default: return Color.white
        }
    }
    
    private func buildSentence() {
        guard !rawInput.isEmpty else { return }
        isProcessing = true
        generatedSentence = ""
        
        Task {
            if let onlineResult = await AISentenceService.shared.generateOnline(from: rawInput) {
                await MainActor.run {
                    self.generatedSentence = onlineResult
                    self.activeMode = "✓ Online AI"
                    self.isProcessing = false
                }
            } else {
                await MainActor.run {
                    self.generatedSentence = SmartPecsNLPEngine.process(rawInput)
                    self.activeMode = "⚡ Offline NLP"
                    self.isProcessing = false
                }
            }
        }
    }
}

// ==========================================
// SERVICE 1: ONLINE AI
// ==========================================
class AISentenceService {
    static let shared = AISentenceService()
    
    private var apiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "GEMINI_API_KEY") as? String ?? ""
    }
    
    func generateOnline(from keywords: String) async -> String? {
        guard !apiKey.isEmpty, apiKey.hasPrefix("AIza") else { return nil }
        
        let urlString = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=\(apiKey)"
        guard let url = URL(string: urlString) else { return nil }
        
        let prompt = """
        Bạn là hệ thống AAC. Tạo 1 câu tiếng Việt hoàn chỉnh từ các từ khóa lộn xộn: "\(keywords)". Không giải thích.
        """
        
        let requestBody: [String: Any] = [
            "contents": [["parts": [["text": prompt]]]],
            "generationConfig": ["temperature": 0.2, "maxOutputTokens": 50]
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return nil }
            
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let candidates = json["candidates"] as? [[String: Any]],
               let text = (candidates.first?["content"] as? [String: Any])?["parts"] as? [[String: Any]],
               let finalString = text.first?["text"] as? String {
                return finalString.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } catch {
            return nil
        }
        return nil
    }
}

// ==========================================
// SERVICE 2: SMART PECS NLP ENGINE (NÂNG CẤP VỚI CONTEXT DETECTOR)
// ==========================================
struct SmartPecsNLPEngine {
    
    // TỪ ĐIỂN MỞ RỘNG (Phân loại chi tiết)
    private static let personalSubjects: Set<String> = ["con", "mẹ", "ba", "bố", "em", "cháu", "cô", "thầy", "bạn", "tôi", "mình"]
    private static let envSubjects: Set<String> = ["trời", "thời tiết", "phòng", "nhà", "nước", "ngoài"]
    
    private static let negations: Set<String> = ["không", "đừng", "chưa"]
    private static let desires: Set<String> = ["muốn", "thích", "cần", "xin", "giúp"]
    private static let actions: Set<String> = ["uống", "ăn", "đi", "chơi", "ngủ", "mặc", "lấy", "xem", "ngồi", "đứng", "vệ sinh", "tắm", "rửa", "về"]
    
    private static let personalConditions: Set<String> = ["đau", "mệt", "đói", "khát", "buồn", "vui", "sợ", "ngứa", "chóng mặt", "buồn nôn"]
    private static let envConditions: Set<String> = ["nóng", "lạnh", "mát", "ấm", "mưa", "nắng", "ồn", "tối", "sáng", "bẩn", "sạch"]
    
    // Trạng từ mức độ (Sắp xếp trật tự VN: "rất/hơi" đứng trước, "quá/lắm" đứng sau)
    private static let degreeAdverbs: Set<String> = ["quá", "lắm", "rất", "hơi", "cực kỳ"]
    
    static func process(_ rawText: String) -> String {
        let normalizedText = rawText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !normalizedText.isEmpty else { return "" }
        
        let tokens = normalizedText.components(separatedBy: .whitespaces).filter { !$0.isEmpty }
        var sentence = rebuildSyntax(from: tokens)
        sentence = polishContext(sentence)
        
        return sentence
    }
    
    private static func rebuildSyntax(from tokens: [String]) -> String {
        var foundPersSubj: String?
        var foundEnvSubj: String?
        var foundNeg: String?
        var foundDesire: String?
        var foundAction: String?
        var foundPersCond: String?
        var foundEnvCond: String?
        var foundDegree: String?
        var objects: [String] = []
        
        // 1. Phân loại Token (Token Tagging)
        for t in tokens {
            let token = t.lowercased()
            if personalSubjects.contains(token) && foundPersSubj == nil { foundPersSubj = token }
            else if envSubjects.contains(token) && foundEnvSubj == nil { foundEnvSubj = token }
            else if negations.contains(token) && foundNeg == nil { foundNeg = token }
            else if desires.contains(token) && foundDesire == nil { foundDesire = token }
            else if personalConditions.contains(token) && foundPersCond == nil { foundPersCond = token }
            else if envConditions.contains(token) && foundEnvCond == nil { foundEnvCond = token }
            else if actions.contains(token) && foundAction == nil { foundAction = token }
            else if degreeAdverbs.contains(token) && foundDegree == nil { foundDegree = token }
            else { objects.append(token) }
        }
        
        // BỘ DÒ TÌM NGỮ CẢNH (CONTEXT DETECTOR)
        // Nếu câu có chữ "trời", hoặc nói về "nóng/lạnh" nhưng không chỉ đích danh "Con" -> Ngữ cảnh Môi Trường
        let isEnvironmental = foundEnvSubj != nil || (foundPersSubj == nil && foundEnvCond != nil)
        
        var finalParts: [String] = []
        
        // ==========================================
        // NHÁNH A: NGỮ CẢNH MÔI TRƯỜNG ("Trời nóng quá")
        // ==========================================
        if isEnvironmental {
            let subject = foundEnvSubj ?? "trời" // Tự động điền "trời" nếu khuyết
            finalParts.append(subject)
            
            if let neg = foundNeg { finalParts.append(neg) }
            
            if let deg = foundDegree, ["rất", "hơi", "cực kỳ"].contains(deg) { finalParts.append(deg) } // Rất nóng
            if let envCond = foundEnvCond { finalParts.append(envCond) }
            if let deg = foundDegree, ["quá", "lắm"].contains(deg) { finalParts.append(deg) } // Nóng quá
            
            if !objects.isEmpty { finalParts.append(objects.joined(separator: " ")) }
        }
        
        // ==========================================
        // NHÁNH B: NGỮ CẢNH CÁ NHÂN ("Con muốn ăn cơm")
        // ==========================================
        else {
            let subject = foundPersSubj ?? "con" // Tự động điền "con"
            finalParts.append(subject)
            
            // Xử lý Cảm giác bản thân (Đau, Mệt, Khát...)
            if let cond = foundPersCond ?? foundEnvCond {
                if let neg = foundNeg { finalParts.append(neg) }
                else {
                    if ["đau", "mệt", "ngứa", "nhức", "chóng mặt"].contains(cond) { finalParts.append("bị") }
                    else if ["đói", "khát"].contains(cond) { finalParts.append("đang") }
                }
                
                if let deg = foundDegree, ["rất", "hơi"].contains(deg) { finalParts.append(deg) }
                finalParts.append(cond)
                if let deg = foundDegree, ["quá", "lắm"].contains(deg) { finalParts.append(deg) }
            }
            // Xử lý Hành động / Mong muốn
            else if foundDesire != nil || foundAction != nil {
                if let neg = foundNeg { finalParts.append(neg) }
                if let des = foundDesire { finalParts.append(des) }
                if let act = foundAction { finalParts.append(act) }
            }
            // Xử lý Từ chối chung (chỉ có chữ "Không")
            else if let neg = foundNeg {
                 finalParts.append(neg)
            }
            
            if !objects.isEmpty { finalParts.append(objects.joined(separator: " ")) }
        }
        
        return finalParts.joined(separator: " ")
    }
    
    private static func polishContext(_ sentence: String) -> String {
        var polished = sentence
        // Fix các cụm từ đặc thù tiếng Việt
        let specialRules = ["đi vệ sinh": "đi vệ sinh", "không bị": "không", "không đang": "không"]
        for (key, value) in specialRules { polished = polished.replacingOccurrences(of: key, with: value) }
        
        // Định dạng viết hoa đầu dòng và kết câu bằng dấu chấm
        guard !polished.isEmpty else { return "" }
        return polished.prefix(1).uppercased() + polished.dropFirst() + "."
    }
}
