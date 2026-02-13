import Foundation
import StoreKit
import Combine

enum AppState {
    case loading
    case contentViewer(link: String)
    case mainApp
}

final class LaunchViewModel: ObservableObject {
    @Published var appState: AppState = .loading
    
    private let storage = StorageService.shared
    private let network = NetworkService.shared
    private var tokenObtainedDuringSession = false
    
    func checkInitialState() {
        if storage.hasStoredToken, let link = storage.contentLink {
            appState = .contentViewer(link: link)
            requestReviewIfNeeded()
        } else {
            fetchServerData()
        }
    }
    
    private func fetchServerData() {
        network.fetchInitialData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                if let data = data {
                    self.storage.accessToken = data.token
                    self.storage.contentLink = data.link
                    self.tokenObtainedDuringSession = true
                    self.appState = .contentViewer(link: data.link)
                } else {
                    self.appState = .mainApp
                }
            case .failure:
                self.appState = .mainApp
            }
        }
    }
    
    private func requestReviewIfNeeded() {
        guard !storage.wasReviewShown else { return }
        guard !tokenObtainedDuringSession else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
                self.storage.wasReviewShown = true
            }
        }
    }
}
