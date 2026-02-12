import UIKit
import SpriteKit
import AudioToolbox

final class MatchSimulationViewController: UIViewController {

    private let homeTeam: Team
    private let awayTeam: Team
    private let viewModel = MatchViewModel()

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }

    private var skView: SKView!
    private var matchScene: MatchScene?
    private var hasStarted = false

    private let headerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let homeColorDot: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 8
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let awayColorDot: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 8
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let homeNameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .bold)
        l.textColor = .white
        l.textAlignment = .right
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let awayNameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .bold)
        l.textColor = .white
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let scoreLabel: UILabel = {
        let l = UILabel()
        l.font = .monospacedDigitSystemFont(ofSize: 36, weight: .heavy)
        l.textColor = .white
        l.textAlignment = .center
        l.text = "0 : 0"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let minuteLabel: UILabel = {
        let l = UILabel()
        l.font = .monospacedDigitSystemFont(ofSize: 15, weight: .semibold)
        l.textColor = ThemeManager.shared.accentColor
        l.textAlignment = .center
        l.text = "0'"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let pauseButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private let eventsBanner: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .semibold)
        l.textColor = .white
        l.textAlignment = .center
        l.backgroundColor = UIColor.black.withAlphaComponent(0.65)
        l.layer.cornerRadius = 16
        l.clipsToBounds = true
        l.alpha = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let pauseOverlay: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        v.isHidden = true
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let pauseStack: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 16
        s.alignment = .center
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private let resultOverlay: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        v.isHidden = true
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let resultCard: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.12, alpha: 1)
        v.layer.cornerRadius = 20
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    init(homeTeam: Team, awayTeam: Team) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPauseOverlay()
        setupResultOverlay()
        viewModel.setTeams(home: homeTeam, away: awayTeam)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !hasStarted && skView.bounds.size.width > 0 && skView.bounds.size.height > 0 {
            hasStarted = true
            startMatch()
        }
    }

    private func setupUI() {
        view.backgroundColor = .black

        skView = SKView()
        skView.translatesAutoresizingMaskIntoConstraints = false
        skView.ignoresSiblingOrder = true
        skView.allowsTransparency = false
        view.addSubview(skView)

        view.addSubview(headerView)
        headerView.addSubview(homeNameLabel)
        headerView.addSubview(awayNameLabel)
        headerView.addSubview(scoreLabel)
        headerView.addSubview(minuteLabel)
        headerView.addSubview(pauseButton)
        headerView.addSubview(homeColorDot)
        headerView.addSubview(awayColorDot)

        view.addSubview(eventsBanner)

        homeNameLabel.text = homeTeam.shortName
        awayNameLabel.text = awayTeam.shortName
        homeColorDot.backgroundColor = homeTeam.primaryColor
        awayColorDot.backgroundColor = awayTeam.primaryColor

        pauseButton.addTarget(self, action: #selector(pauseTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            skView.topAnchor.constraint(equalTo: view.topAnchor),
            skView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            skView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 72),

            pauseButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            pauseButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12),
            pauseButton.widthAnchor.constraint(equalToConstant: 32),
            pauseButton.heightAnchor.constraint(equalToConstant: 32),

            scoreLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),

            minuteLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            minuteLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 2),

            homeColorDot.trailingAnchor.constraint(equalTo: homeNameLabel.leadingAnchor, constant: -6),
            homeColorDot.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            homeColorDot.widthAnchor.constraint(equalToConstant: 16),
            homeColorDot.heightAnchor.constraint(equalToConstant: 16),

            homeNameLabel.trailingAnchor.constraint(equalTo: scoreLabel.leadingAnchor, constant: -14),
            homeNameLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),

            awayColorDot.leadingAnchor.constraint(equalTo: awayNameLabel.trailingAnchor, constant: 6),
            awayColorDot.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            awayColorDot.widthAnchor.constraint(equalToConstant: 16),
            awayColorDot.heightAnchor.constraint(equalToConstant: 16),

            awayNameLabel.leadingAnchor.constraint(equalTo: scoreLabel.trailingAnchor, constant: 14),
            awayNameLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),

            eventsBanner.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            eventsBanner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            eventsBanner.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -40),
            eventsBanner.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    private func setupPauseOverlay() {
        view.addSubview(pauseOverlay)
        pauseOverlay.addSubview(pauseStack)

        NSLayoutConstraint.activate([
            pauseOverlay.topAnchor.constraint(equalTo: view.topAnchor),
            pauseOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pauseOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pauseOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            pauseStack.centerXAnchor.constraint(equalTo: pauseOverlay.centerXAnchor),
            pauseStack.centerYAnchor.constraint(equalTo: pauseOverlay.centerYAnchor)
        ])

        let pauseTitle = UILabel()
        pauseTitle.text = "PAUSED"
        pauseTitle.font = .systemFont(ofSize: 32, weight: .heavy)
        pauseTitle.textColor = .white
        pauseStack.addArrangedSubview(pauseTitle)

        let resumeBtn = makePauseMenuButton(title: "Resume", color: ThemeManager.shared.accentColor)
        resumeBtn.addTarget(self, action: #selector(resumeTapped), for: .touchUpInside)
        pauseStack.addArrangedSubview(resumeBtn)

        let exitBtn = makePauseMenuButton(title: "Exit to Menu", color: .systemRed)
        exitBtn.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        pauseStack.addArrangedSubview(exitBtn)

        NSLayoutConstraint.activate([
            resumeBtn.widthAnchor.constraint(equalToConstant: 220),
            resumeBtn.heightAnchor.constraint(equalToConstant: 50),
            exitBtn.widthAnchor.constraint(equalToConstant: 220),
            exitBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupResultOverlay() {
        view.addSubview(resultOverlay)
        resultOverlay.addSubview(resultCard)

        NSLayoutConstraint.activate([
            resultOverlay.topAnchor.constraint(equalTo: view.topAnchor),
            resultOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            resultOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            resultCard.centerXAnchor.constraint(equalTo: resultOverlay.centerXAnchor),
            resultCard.centerYAnchor.constraint(equalTo: resultOverlay.centerYAnchor),
            resultCard.widthAnchor.constraint(equalToConstant: 300),
            resultCard.heightAnchor.constraint(equalToConstant: 320)
        ])
    }

    private func makePauseMenuButton(title: String, color: UIColor) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = color
        btn.layer.cornerRadius = 14
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }

    private func startMatch() {
        let sceneSize = skView.bounds.size
        let scene = MatchScene(size: sceneSize, homeTeam: homeTeam, awayTeam: awayTeam)
        scene.scaleMode = .aspectFill
        scene.matchDelegate = self
        matchScene = scene
        skView.presentScene(scene)

        homeColorDot.backgroundColor = scene.resolvedHomeUIColor
        awayColorDot.backgroundColor = scene.resolvedAwayUIColor

        viewModel.startSimulation()
        scene.startSimulation()
    }

    @objc private func pauseTapped() {
        matchScene?.pauseSimulation()
        pauseOverlay.isHidden = false
        UIView.animate(withDuration: 0.25) {
            self.pauseOverlay.alpha = 1
        }
    }

    @objc private func resumeTapped() {
        UIView.animate(withDuration: 0.25, animations: {
            self.pauseOverlay.alpha = 0
        }) { _ in
            self.pauseOverlay.isHidden = true
            self.matchScene?.resumeSimulation()
        }
    }

    @objc private func exitTapped() {
        matchScene?.forceStop()
        dismiss(animated: true)
    }

    private func showEventBanner(_ text: String) {
        eventsBanner.text = "  \(text)  "
        UIView.animate(withDuration: 0.3) {
            self.eventsBanner.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            UIView.animate(withDuration: 0.5) {
                self.eventsBanner.alpha = 0
            }
        }
    }

    private func showResult() {
        resultCard.subviews.forEach { $0.removeFromSuperview() }

        let accent = ThemeManager.shared.accentColor

        let ftLabel = UILabel()
        ftLabel.text = "Full Time"
        ftLabel.font = .systemFont(ofSize: 16, weight: .medium)
        ftLabel.textColor = accent
        ftLabel.textAlignment = .center
        ftLabel.translatesAutoresizingMaskIntoConstraints = false
        resultCard.addSubview(ftLabel)

        let resultScoreLabel = UILabel()
        resultScoreLabel.text = "\(viewModel.homeScore) : \(viewModel.awayScore)"
        resultScoreLabel.font = .monospacedDigitSystemFont(ofSize: 52, weight: .heavy)
        resultScoreLabel.textColor = .white
        resultScoreLabel.textAlignment = .center
        resultScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        resultCard.addSubview(resultScoreLabel)

        let teamsLabel = UILabel()
        teamsLabel.text = "\(homeTeam.name) vs \(awayTeam.name)"
        teamsLabel.font = .systemFont(ofSize: 14, weight: .medium)
        teamsLabel.textColor = UIColor(white: 0.7, alpha: 1)
        teamsLabel.textAlignment = .center
        teamsLabel.numberOfLines = 2
        teamsLabel.translatesAutoresizingMaskIntoConstraints = false
        resultCard.addSubview(teamsLabel)

        var outcome = "Draw!"
        if viewModel.homeScore > viewModel.awayScore {
            outcome = "\(homeTeam.name) Wins!"
        } else if viewModel.awayScore > viewModel.homeScore {
            outcome = "\(awayTeam.name) Wins!"
        }
        let outcomeLabel = UILabel()
        outcomeLabel.text = outcome
        outcomeLabel.font = .systemFont(ofSize: 20, weight: .bold)
        outcomeLabel.textColor = .white
        outcomeLabel.textAlignment = .center
        outcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        resultCard.addSubview(outcomeLabel)

        let exitResultBtn = makePauseMenuButton(title: "Back to Menu", color: accent)
        exitResultBtn.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        resultCard.addSubview(exitResultBtn)

        NSLayoutConstraint.activate([
            ftLabel.topAnchor.constraint(equalTo: resultCard.topAnchor, constant: 24),
            ftLabel.centerXAnchor.constraint(equalTo: resultCard.centerXAnchor),

            resultScoreLabel.topAnchor.constraint(equalTo: ftLabel.bottomAnchor, constant: 12),
            resultScoreLabel.centerXAnchor.constraint(equalTo: resultCard.centerXAnchor),

            teamsLabel.topAnchor.constraint(equalTo: resultScoreLabel.bottomAnchor, constant: 8),
            teamsLabel.leadingAnchor.constraint(equalTo: resultCard.leadingAnchor, constant: 16),
            teamsLabel.trailingAnchor.constraint(equalTo: resultCard.trailingAnchor, constant: -16),

            outcomeLabel.topAnchor.constraint(equalTo: teamsLabel.bottomAnchor, constant: 16),
            outcomeLabel.centerXAnchor.constraint(equalTo: resultCard.centerXAnchor),

            exitResultBtn.bottomAnchor.constraint(equalTo: resultCard.bottomAnchor, constant: -24),
            exitResultBtn.centerXAnchor.constraint(equalTo: resultCard.centerXAnchor),
            exitResultBtn.widthAnchor.constraint(equalToConstant: 220),
            exitResultBtn.heightAnchor.constraint(equalToConstant: 50)
        ])

        resultOverlay.isHidden = false
        resultCard.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) {
            self.resultOverlay.alpha = 1
            self.resultCard.transform = .identity
        }
    }
}

extension MatchSimulationViewController: MatchSceneDelegate {
    func matchScene(_ scene: MatchScene, didUpdateMinute minute: Int) {
        let prevHome = viewModel.homeScore
        let prevAway = viewModel.awayScore
        viewModel.updateMinute(minute)
        scoreLabel.text = "\(viewModel.homeScore) : \(viewModel.awayScore)"
        minuteLabel.text = "\(minute)'"

        if viewModel.homeScore > prevHome || viewModel.awayScore > prevAway {
            triggerGoalVibration()
            if let lastGoal = viewModel.matchEvents.last(where: { $0.type == .goal || $0.type == .penalty }) {
                showEventBanner(lastGoal.description)
            }
        }
    }

    func matchSceneDidFinish(_ scene: MatchScene) {
        viewModel.finishSimulation()
        scoreLabel.text = "\(viewModel.homeScore) : \(viewModel.awayScore)"
        minuteLabel.text = "FT"

        let result = MatchResult(
            homeTeam: homeTeam,
            awayTeam: awayTeam,
            homeScore: viewModel.homeScore,
            awayScore: viewModel.awayScore,
            events: viewModel.matchEvents
        )
        HistoryService.shared.save(result)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.showResult()
        }
    }

    private func triggerGoalVibration() {
        guard StorageService.shared.isVibrationEnabled else { return }
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            let impact = UIImpactFeedbackGenerator(style: .heavy)
            impact.prepare()
            impact.impactOccurred()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let impact = UIImpactFeedbackGenerator(style: .heavy)
            impact.prepare()
            impact.impactOccurred()
        }
    }
}
