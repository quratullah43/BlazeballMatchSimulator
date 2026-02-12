import Foundation

final class HistoryService {
    static let shared = HistoryService()
    static let historyUpdatedNotification = Notification.Name("MatchHistoryUpdated")

    private let storageKey = "app_match_history"
    private let maxResults = 50

    private init() {}

    var results: [MatchResult] {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return [] }
        let decoded = try? JSONDecoder().decode([MatchResult].self, from: data)
        return decoded ?? []
    }

    func save(_ result: MatchResult) {
        var all = results
        all.insert(result, at: 0)
        if all.count > maxResults {
            all = Array(all.prefix(maxResults))
        }
        if let data = try? JSONEncoder().encode(all) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
        NotificationCenter.default.post(name: HistoryService.historyUpdatedNotification, object: nil)
    }

    func clearHistory() {
        UserDefaults.standard.removeObject(forKey: storageKey)
        NotificationCenter.default.post(name: HistoryService.historyUpdatedNotification, object: nil)
    }
}
