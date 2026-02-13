import UIKit

final class MainTabBarController: UITabBarController {

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        applyTheme()
        NotificationCenter.default.addObserver(self, selector: #selector(themeDidChange), name: ThemeManager.themeChangedNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupTabs() {
        let leaguesVC = LeaguesViewController()
        leaguesVC.tabBarItem = UITabBarItem(title: "Leagues", image: UIImage(systemName: "trophy"), tag: 0)

        let matchVC = MatchSetupViewController()
        matchVC.tabBarItem = UITabBarItem(title: "Match", image: UIImage(systemName: "sportscourt"), tag: 1)

        let historyVC = HistoryViewController()
        historyVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "clock"), tag: 2)

        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 3)

        let navLeagues = UINavigationController(rootViewController: leaguesVC)
        let navMatch = UINavigationController(rootViewController: matchVC)
        let navHistory = UINavigationController(rootViewController: historyVC)
        let navSettings = UINavigationController(rootViewController: settingsVC)

        viewControllers = [navLeagues, navMatch, navHistory, navSettings]
    }

    private func applyTheme() {
        let accent = ThemeManager.shared.accentColor
        tabBar.tintColor = accent

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }

    @objc private func themeDidChange() {
        applyTheme()
    }
}
