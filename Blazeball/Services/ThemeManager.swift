import UIKit

struct AppTheme: Equatable {
    let name: String
    let accentColor: UIColor
    let key: String
}

final class ThemeManager {
    static let shared = ThemeManager()
    static let themeChangedNotification = Notification.Name("AppThemeDidChange")

    let availableThemes: [AppTheme] = [
        AppTheme(name: "Green", accentColor: .systemGreen, key: "green"),
        AppTheme(name: "Blue", accentColor: .systemBlue, key: "blue"),
        AppTheme(name: "Red", accentColor: .systemRed, key: "red"),
        AppTheme(name: "Orange", accentColor: .systemOrange, key: "orange"),
        AppTheme(name: "Purple", accentColor: .systemPurple, key: "purple"),
        AppTheme(name: "Teal", accentColor: .systemTeal, key: "teal"),
        AppTheme(name: "Pink", accentColor: .systemPink, key: "pink"),
        AppTheme(name: "Yellow", accentColor: .systemYellow, key: "yellow")
    ]

    var currentTheme: AppTheme {
        let key = StorageService.shared.themeKey
        return availableThemes.first { $0.key == key } ?? availableThemes[0]
    }

    var accentColor: UIColor {
        return currentTheme.accentColor
    }

    private init() {}

    func applyTheme(_ theme: AppTheme) {
        StorageService.shared.themeKey = theme.key
        NotificationCenter.default.post(name: ThemeManager.themeChangedNotification, object: nil)
    }
}
