import UIKit
import WebKit

final class ContentViewerController: UIViewController {
    
    private var contentView: WKWebView!
    private var loadingView: UIView!
    private var activityIndicator: UIActivityIndicatorView!
    private let contentAddress: String
    private var isInitialLoad = true
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    init(address: String) {
        self.contentAddress = address
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingView()
        setupContentView()
        loadContent()
    }
    
    private func setupLoadingView() {
        loadingView = UIView()
        loadingView.backgroundColor = .black
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    private func setupContentView() {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        
        contentView = WKWebView(frame: .zero, configuration: config)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.navigationDelegate = self
        contentView.scrollView.contentInsetAdjustmentBehavior = .never
        contentView.allowsBackForwardNavigationGestures = true
        contentView.isOpaque = false
        contentView.backgroundColor = .black
        
        view.insertSubview(contentView, at: 0)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func loadContent() {
        guard let destination = URL(string: contentAddress) else { return }
        var request = URLRequest(url: destination)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        contentView.load(request)
    }
}

extension ContentViewerController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if isInitialLoad {
            isInitialLoad = false
            UIView.animate(withDuration: 0.3) {
                self.loadingView.alpha = 0
            } completion: { _ in
                self.loadingView.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}
