import UIKit

final class TeamDetailViewController: UIViewController {
    
    private let team: Team
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(team: Team) {
        self.team = team
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = team.name
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        setupTeamHeader()
        setupStatsSection()
        setupPlayButton()
    }
    
    private func setupTeamHeader() {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let colorBadge = UIView()
        colorBadge.backgroundColor = team.primaryColor
        colorBadge.layer.cornerRadius = 40
        colorBadge.translatesAutoresizingMaskIntoConstraints = false
        
        let shortLabel = UILabel()
        shortLabel.text = team.shortName
        shortLabel.font = .systemFont(ofSize: 24, weight: .bold)
        shortLabel.textColor = .white
        shortLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let overallBadge = UIView()
        overallBadge.backgroundColor = ThemeManager.shared.accentColor
        overallBadge.layer.cornerRadius = 25
        overallBadge.translatesAutoresizingMaskIntoConstraints = false
        
        let overallLabel = UILabel()
        overallLabel.text = "\(team.overall)"
        overallLabel.font = .systemFont(ofSize: 22, weight: .bold)
        overallLabel.textColor = .white
        overallLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(colorBadge)
        colorBadge.addSubview(shortLabel)
        headerView.addSubview(overallBadge)
        overallBadge.addSubview(overallLabel)
        
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 100),
            
            colorBadge.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: -40),
            colorBadge.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            colorBadge.widthAnchor.constraint(equalToConstant: 80),
            colorBadge.heightAnchor.constraint(equalToConstant: 80),
            
            shortLabel.centerXAnchor.constraint(equalTo: colorBadge.centerXAnchor),
            shortLabel.centerYAnchor.constraint(equalTo: colorBadge.centerYAnchor),
            
            overallBadge.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: 40),
            overallBadge.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            overallBadge.widthAnchor.constraint(equalToConstant: 50),
            overallBadge.heightAnchor.constraint(equalToConstant: 50),
            
            overallLabel.centerXAnchor.constraint(equalTo: overallBadge.centerXAnchor),
            overallLabel.centerYAnchor.constraint(equalTo: overallBadge.centerYAnchor)
        ])
        
        contentStack.addArrangedSubview(headerView)
    }
    
    private func setupStatsSection() {
        let statsCard = createCard(title: "Team Statistics")
        
        let attackRow = createStatRow(title: "Attack", value: team.attack, color: .systemRed)
        let defenseRow = createStatRow(title: "Defense", value: team.defense, color: .systemBlue)
        let midfieldRow = createStatRow(title: "Midfield", value: team.midfield, color: .systemGreen)
        
        let statsStack = UIStackView(arrangedSubviews: [attackRow, defenseRow, midfieldRow])
        statsStack.axis = .vertical
        statsStack.spacing = 16
        statsStack.translatesAutoresizingMaskIntoConstraints = false
        
        statsCard.addSubview(statsStack)
        
        NSLayoutConstraint.activate([
            statsStack.topAnchor.constraint(equalTo: statsCard.topAnchor, constant: 50),
            statsStack.leadingAnchor.constraint(equalTo: statsCard.leadingAnchor, constant: 16),
            statsStack.trailingAnchor.constraint(equalTo: statsCard.trailingAnchor, constant: -16),
            statsStack.bottomAnchor.constraint(equalTo: statsCard.bottomAnchor, constant: -16)
        ])
        
        contentStack.addArrangedSubview(statsCard)
    }
    
    private func createCard(title: String) -> UIView {
        let card = UIView()
        card.backgroundColor = .secondarySystemBackground
        card.layer.cornerRadius = 12
        card.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        card.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16)
        ])
        
        return card
    }
    
    private func createStatRow(title: String, value: Int, color: UIColor) -> UIView {
        let row = UIView()
        row.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let valueLabel = UILabel()
        valueLabel.text = "\(value)"
        valueLabel.font = .systemFont(ofSize: 15, weight: .bold)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let progressBg = UIView()
        progressBg.backgroundColor = .systemGray5
        progressBg.layer.cornerRadius = 4
        progressBg.translatesAutoresizingMaskIntoConstraints = false
        
        let progressFill = UIView()
        progressFill.backgroundColor = color
        progressFill.layer.cornerRadius = 4
        progressFill.translatesAutoresizingMaskIntoConstraints = false
        
        row.addSubview(label)
        row.addSubview(valueLabel)
        row.addSubview(progressBg)
        progressBg.addSubview(progressFill)
        
        NSLayoutConstraint.activate([
            row.heightAnchor.constraint(equalToConstant: 40),
            
            label.leadingAnchor.constraint(equalTo: row.leadingAnchor),
            label.topAnchor.constraint(equalTo: row.topAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: row.trailingAnchor),
            valueLabel.topAnchor.constraint(equalTo: row.topAnchor),
            
            progressBg.leadingAnchor.constraint(equalTo: row.leadingAnchor),
            progressBg.trailingAnchor.constraint(equalTo: row.trailingAnchor),
            progressBg.bottomAnchor.constraint(equalTo: row.bottomAnchor),
            progressBg.heightAnchor.constraint(equalToConstant: 8),
            
            progressFill.leadingAnchor.constraint(equalTo: progressBg.leadingAnchor),
            progressFill.topAnchor.constraint(equalTo: progressBg.topAnchor),
            progressFill.bottomAnchor.constraint(equalTo: progressBg.bottomAnchor),
            progressFill.widthAnchor.constraint(equalTo: progressBg.widthAnchor, multiplier: CGFloat(value) / 100.0)
        ])
        
        return row
    }
    
    private func setupPlayButton() {
        let button = UIButton(type: .system)
        button.setTitle("Play Match", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = ThemeManager.shared.accentColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        
        contentStack.addArrangedSubview(button)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func playTapped() {
        let matchSetupVC = MatchSetupViewController(preselectedTeam: team)
        navigationController?.pushViewController(matchSetupVC, animated: true)
    }
}
