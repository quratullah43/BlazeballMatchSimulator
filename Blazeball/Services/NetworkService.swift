import Foundation
import UIKit

final class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchInitialData(completion: @escaping (Result<(token: String, link: String)?, Error>) -> Void) {
        let osVersion = UIDevice.current.systemVersion
        let language = extractLanguage()
        let deviceModel = getDeviceModel()
        let country = Locale.current.region?.identifier ?? "US"
        
        var components = URLComponents(string: "https://aprulestext.site/ios-blazeball-matchsimulator/server.php")
        components?.queryItems = [
            URLQueryItem(name: "p", value: "Bs2675kDjkb5Ga"),
            URLQueryItem(name: "os", value: osVersion),
            URLQueryItem(name: "lng", value: language),
            URLQueryItem(name: "devicemodel", value: deviceModel),
            URLQueryItem(name: "country", value: country)
        ]
        
        guard let requestAddress = components?.url else {
            completion(.failure(NetworkError.invalidAddress))
            return
        }
        
        var request = URLRequest(url: requestAddress)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.httpMethod = "GET"
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        request.setValue("no-cache", forHTTPHeaderField: "Pragma")
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.urlCache = nil
        
        let session = URLSession(configuration: config)
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data, let responseString = String(data: data, encoding: .utf8) else {
                DispatchQueue.main.async {
                    completion(.success(nil))
                }
                return
            }
            
            if responseString.contains("#") {
                let parts = responseString.components(separatedBy: "#")
                if parts.count >= 2 {
                    let token = parts[0]
                    let link = parts[1]
                    DispatchQueue.main.async {
                        completion(.success((token: token, link: link)))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.success(nil))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(nil))
                }
            }
        }.resume()
    }
    
    private func extractLanguage() -> String {
        guard let preferredLanguage = Locale.preferredLanguages.first else {
            return "en"
        }
        if let dashIndex = preferredLanguage.firstIndex(of: "-") {
            return String(preferredLanguage[..<dashIndex])
        }
        return preferredLanguage
    }
    
    private func getDeviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                String(validatingUTF8: $0)
            }
        }
        return modelCode ?? "iPhone"
    }
}

enum NetworkError: Error {
    case invalidAddress
    case noData
}
