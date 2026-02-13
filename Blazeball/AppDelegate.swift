import UIKit
import StoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private let launchViewModel = LaunchViewModel()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        showLoadingScreen()
        checkAppState()
        
        return true
    }
    
    private func showLoadingScreen() {
        let loadingVC = LoadingViewController()
        window?.rootViewController = loadingVC
    }
    
    private func checkAppState() {
        let storage = StorageService.shared
        
        if storage.hasStoredToken, let link = storage.contentLink {
            showContentViewer(with: link)
            requestReviewIfNeeded()
        } else {
            fetchServerData()
        }
    }
    
    private func fetchServerData() {
        NetworkService.shared.fetchInitialData { [weak self] result in
            switch result {
            case .success(let data):
                if let data = data {
                    StorageService.shared.accessToken = data.token
                    StorageService.shared.contentLink = data.link
                    self?.showContentViewer(with: data.link)
                } else {
                    self?.showMainApp()
                }
            case .failure:
                self?.showMainApp()
            }
        }
    }
    
    private func showContentViewer(with link: String) {
        let contentVC = ContentViewerController(address: link)
        window?.rootViewController = contentVC
    }
    
    private func showMainApp() {
        let tabBar = MainTabBarController()
        window?.rootViewController = tabBar
    }
    
    private func requestReviewIfNeeded() {
        let storage = StorageService.shared
        guard !storage.wasReviewShown else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
                storage.wasReviewShown = true
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if let rootVC = window?.rootViewController {
            if rootVC is ContentViewerController {
                return .all
            }
        }
        return .portrait
    }
}
