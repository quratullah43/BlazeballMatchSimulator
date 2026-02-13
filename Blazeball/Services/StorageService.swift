import Foundation

final class StorageService {
    static let shared = StorageService()

    private let defaults = UserDefaults.standard
    private let tokenKey = "app_access_token"
    private let linkKey = "app_content_link"
    private let reviewShownKey = "app_review_shown"
    private let vibrationKey = "app_vibration_enabled"
    private let themeColorKey = "app_theme_key"

    private init() {}

    var accessToken: String? {
        get { defaults.string(forKey: tokenKey) }
        set { defaults.set(newValue, forKey: tokenKey) }
    }

    var contentLink: String? {
        get { defaults.string(forKey: linkKey) }
        set { defaults.set(newValue, forKey: linkKey) }
    }

    var wasReviewShown: Bool {
        get { defaults.bool(forKey: reviewShownKey) }
        set { defaults.set(newValue, forKey: reviewShownKey) }
    }

    var isVibrationEnabled: Bool {
        get {
            if defaults.object(forKey: vibrationKey) == nil { return true }
            return defaults.bool(forKey: vibrationKey)
        }
        set { defaults.set(newValue, forKey: vibrationKey) }
    }

    var themeKey: String {
        get { defaults.string(forKey: themeColorKey) ?? "green" }
        set { defaults.set(newValue, forKey: themeColorKey) }
    }

    var hasStoredToken: Bool {
        return accessToken != nil && contentLink != nil
    }

    func clearAll() {
        defaults.removeObject(forKey: tokenKey)
        defaults.removeObject(forKey: linkKey)
    }
}
