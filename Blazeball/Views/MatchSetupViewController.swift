import UIKit

final class MatchSetupViewController: UIViewController {
    
    private var homeTeam: Team?
    private var awayTeam: Team?
    private var allTeams: [Team] = []
    
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
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let homeTeamButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Select Home Team", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let awayTeamButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Select Away Team", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let vsLabel: UILabel = {
        let label = UILabel()
        label.text = "VS"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.textColor = ThemeManager.shared.accentColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let startButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Start Match", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btn.backgroundColor = ThemeManager.shared.accentColor
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isEnabled = false
        btn.alpha = 0.5
        return btn
    }()
    
    private let randomButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Random Teams", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    init(preselectedTeam: Team? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.homeTeam = preselectedTeam
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllTeams()
        setupUI()
        updateUI()
        NotificationCenter.default.addObserver(self, selector: #selector(themeDidChange), name: ThemeManager.themeChangedNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func themeDidChange() {
        let accent = ThemeManager.shared.accentColor
        vsLabel.textColor = accent
        startButton.backgroundColor = accent
    }
    
    private func loadAllTeams() {
        for league in League.allLeagues {
            allTeams.append(contentsOf: league.teams)
        }
    }
    
    private func setupUI() {
        title = "Match Setup"
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        let titleLabel = UILabel()
        titleLabel.text = "Select Teams"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textAlignment = .center
        
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(homeTeamButton)
        contentStack.addArrangedSubview(vsLabel)
        contentStack.addArrangedSubview(awayTeamButton)
        contentStack.addArrangedSubview(randomButton)
        contentStack.addArrangedSubview(startButton)
        
        NSLayoutConstraint.activate([
            homeTeamButton.heightAnchor.constraint(equalToConstant: 80),
            awayTeamButton.heightAnchor.constraint(equalToConstant: 80),
            startButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        homeTeamButton.addTarget(self, action: #selector(selectHomeTapped), for: .touchUpInside)
        awayTeamButton.addTarget(self, action: #selector(selectAwayTapped), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startMatchTapped), for: .touchUpInside)
        randomButton.addTarget(self, action: #selector(randomTapped), for: .touchUpInside)
    }
    
    private func updateUI() {
        if let home = homeTeam {
            homeTeamButton.setTitle("\(home.name) (\(home.overall))", for: .normal)
            homeTeamButton.backgroundColor = home.primaryColor.withAlphaComponent(0.3)
        } else {
            homeTeamButton.setTitle("Select Home Team", for: .normal)
            homeTeamButton.backgroundColor = .secondarySystemBackground
        }
        
        if let away = awayTeam {
            awayTeamButton.setTitle("\(away.name) (\(away.overall))", for: .normal)
            awayTeamButton.backgroundColor = away.primaryColor.withAlphaComponent(0.3)
        } else {
            awayTeamButton.setTitle("Select Away Team", for: .normal)
            awayTeamButton.backgroundColor = .secondarySystemBackground
        }
        
        let canStart = homeTeam != nil && awayTeam != nil
        startButton.isEnabled = canStart
        startButton.alpha = canStart ? 1.0 : 0.5
    }
    
    @objc private func selectHomeTapped() {
        showTeamPicker(isHome: true)
    }
    
    @objc private func selectAwayTapped() {
        showTeamPicker(isHome: false)
    }
    
    @objc private func randomTapped() {
        let shuffled = allTeams.shuffled()
        homeTeam = shuffled[0]
        awayTeam = shuffled[1]
        updateUI()
    }
    
    @objc private func startMatchTapped() {
        guard let home = homeTeam, let away = awayTeam else { return }
        let matchVC = MatchSimulationViewController(homeTeam: home, awayTeam: away)
        matchVC.modalPresentationStyle = .fullScreen
        present(matchVC, animated: true)
    }
    
    private func showTeamPicker(isHome: Bool) {
        let picker = TeamPickerViewController(teams: allTeams) { [weak self] selectedTeam in
            if isHome {
                self?.homeTeam = selectedTeam
            } else {
                self?.awayTeam = selectedTeam
            }
            self?.updateUI()
        }
        let nav = UINavigationController(rootViewController: picker)
        present(nav, animated: true)
    }
}

final class TeamPickerViewController: UIViewController {
    
    private let teams: [Team]
    private let onSelect: (Team) -> Void
    private var filteredTeams: [Team] = []
    private var tableView: UITableView!
    private var searchController: UISearchController!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    init(teams: [Team], onSelect: @escaping (Team) -> Void) {
        self.teams = teams
        self.filteredTeams = teams
        self.onSelect = onSelect
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
        title = "Select Team"
        view.backgroundColor = .systemBackground
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search teams"
        navigationItem.searchController = searchController
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
}

extension TeamPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let team = filteredTeams[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = team.name
        config.secondaryText = "Overall: \(team.overall)"
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let team = filteredTeams[indexPath.row]
        onSelect(team)
        dismiss(animated: true)
    }
}

extension TeamPickerViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.isEmpty else {
            filteredTeams = teams
            tableView.reloadData()
            return
        }
        filteredTeams = teams.filter { $0.name.localizedCaseInsensitiveContains(query) }
        tableView.reloadData()
    }
}
