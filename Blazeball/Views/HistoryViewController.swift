import UIKit

final class HistoryViewController: UIViewController {

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }

    private var allResults: [MatchResult] = []
    private var filteredResults: [MatchResult] = []
    private var selectedLeagueId: String? = nil
    private var tableView: UITableView!

    private let filterScroll: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let filterStack: UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.spacing = 8
        s.alignment = .center
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private let emptyStack: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 16
        s.alignment = .center
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFilters()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadHistory), name: HistoryService.historyUpdatedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(themeDidChange), name: ThemeManager.themeChangedNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadHistory()
    }

    private func setupUI() {
        title = "History"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(filterScroll)
        filterScroll.addSubview(filterStack)

        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.identifier)
        view.addSubview(tableView)

        let icon = UIImageView()
        icon.image = UIImage(systemName: "clock.badge.questionmark")
        icon.tintColor = .systemGray3
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: 64).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 64).isActive = true

        let label = UILabel()
        label.text = "No match history yet.\nPlay some matches to see them here!"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0

        emptyStack.addArrangedSubview(icon)
        emptyStack.addArrangedSubview(label)
        view.addSubview(emptyStack)

        NSLayoutConstraint.activate([
            filterScroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterScroll.heightAnchor.constraint(equalToConstant: 48),

            filterStack.topAnchor.constraint(equalTo: filterScroll.topAnchor, constant: 8),
            filterStack.bottomAnchor.constraint(equalTo: filterScroll.bottomAnchor, constant: -8),
            filterStack.leadingAnchor.constraint(equalTo: filterScroll.leadingAnchor, constant: 16),
            filterStack.trailingAnchor.constraint(equalTo: filterScroll.trailingAnchor, constant: -16),
            filterStack.heightAnchor.constraint(equalTo: filterScroll.heightAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: filterScroll.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            emptyStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emptyStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }

    private func setupFilters() {
        filterStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let allChip = makeChip(title: "All", leagueId: nil)
        filterStack.addArrangedSubview(allChip)

        for league in League.allLeagues {
            let chip = makeChip(title: league.name, leagueId: league.id)
            filterStack.addArrangedSubview(chip)
        }

        updateChipStyles()
    }

    private func makeChip(title: String, leagueId: String?) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var out = incoming
            out.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
            return out
        }
        config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 14, bottom: 6, trailing: 14)
        config.cornerStyle = .capsule
        let btn = UIButton(configuration: config)
        btn.tag = chipTag(for: leagueId)
        btn.addTarget(self, action: #selector(chipTapped(_:)), for: .touchUpInside)
        return btn
    }

    private func chipTag(for leagueId: String?) -> Int {
        guard let lid = leagueId else { return 0 }
        if let idx = League.allLeagues.firstIndex(where: { $0.id == lid }) {
            return idx + 1
        }
        return 0
    }

    private func leagueId(for tag: Int) -> String? {
        guard tag > 0 else { return nil }
        let idx = tag - 1
        guard idx < League.allLeagues.count else { return nil }
        return League.allLeagues[idx].id
    }

    @objc private func chipTapped(_ sender: UIButton) {
        selectedLeagueId = leagueId(for: sender.tag)
        updateChipStyles()
        applyFilter()
    }

    private func updateChipStyles() {
        let accent = ThemeManager.shared.accentColor
        for case let btn as UIButton in filterStack.arrangedSubviews {
            let isSelected = leagueId(for: btn.tag) == selectedLeagueId
            var config = btn.configuration ?? UIButton.Configuration.filled()
            if isSelected {
                config.baseBackgroundColor = accent
                config.baseForegroundColor = .white
            } else {
                config.baseBackgroundColor = UIColor.secondarySystemBackground
                config.baseForegroundColor = .label
            }
            btn.configuration = config
        }
    }

    private func applyFilter() {
        if let lid = selectedLeagueId {
            filteredResults = allResults.filter { resultBelongsToLeague($0, leagueId: lid) }
        } else {
            filteredResults = allResults
        }
        tableView.reloadData()
        let isEmpty = filteredResults.isEmpty
        tableView.isHidden = isEmpty && allResults.isEmpty
        emptyStack.isHidden = !isEmpty || !allResults.isEmpty
    }

    private func resultBelongsToLeague(_ result: MatchResult, leagueId: String) -> Bool {
        guard let league = League.allLeagues.first(where: { $0.id == leagueId }) else { return false }
        let teamIds = Set(league.teams.map { $0.id })
        return teamIds.contains(result.homeTeamId) || teamIds.contains(result.awayTeamId)
    }

    @objc private func reloadHistory() {
        allResults = HistoryService.shared.results
        applyFilter()

        if !allResults.isEmpty {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearTapped))
            navigationItem.rightBarButtonItem?.tintColor = .systemRed
        } else {
            navigationItem.rightBarButtonItem = nil
        }

        filterScroll.isHidden = allResults.isEmpty
    }

    @objc private func clearTapped() {
        let alert = UIAlertController(title: "Clear History", message: "Are you sure you want to delete all match history?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive) { _ in
            HistoryService.shared.clearHistory()
        })
        present(alert, animated: true)
    }

    @objc private func themeDidChange() {
        updateChipStyles()
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.identifier, for: indexPath) as? HistoryCell else {
            return UITableViewCell()
        }
        let result = filteredResults[indexPath.row]
        let leagueName = leagueNameForResult(result)
        cell.configure(with: result, leagueName: leagueName)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    private func leagueNameForResult(_ result: MatchResult) -> String? {
        for league in League.allLeagues {
            let teamIds = league.teams.map { $0.id }
            if teamIds.contains(result.homeTeamId) || teamIds.contains(result.awayTeamId) {
                return league.name
            }
        }
        return nil
    }
}

final class HistoryCell: UITableViewCell {
    static let identifier = "HistoryCell"

    private let homeLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 15, weight: .semibold)
        l.textAlignment = .right
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let awayLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 15, weight: .semibold)
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let scoreLabel: UILabel = {
        let l = UILabel()
        l.font = .monospacedDigitSystemFont(ofSize: 22, weight: .heavy)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let outcomeLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 12, weight: .medium)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let dateLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 11)
        l.textColor = .tertiaryLabel
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let leagueLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 11, weight: .medium)
        l.textColor = .secondaryLabel
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(leagueLabel)
        contentView.addSubview(homeLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(awayLabel)
        contentView.addSubview(outcomeLabel)
        contentView.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            leagueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            leagueLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            scoreLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: leagueLabel.bottomAnchor, constant: 4),

            homeLabel.trailingAnchor.constraint(equalTo: scoreLabel.leadingAnchor, constant: -12),
            homeLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            homeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 12),

            awayLabel.leadingAnchor.constraint(equalTo: scoreLabel.trailingAnchor, constant: 12),
            awayLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            awayLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -12),

            outcomeLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 4),
            outcomeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            dateLabel.topAnchor.constraint(equalTo: outcomeLabel.bottomAnchor, constant: 2),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    func configure(with result: MatchResult, leagueName: String?) {
        homeLabel.text = result.homeTeamShort
        awayLabel.text = result.awayTeamShort
        scoreLabel.text = "\(result.homeScore) : \(result.awayScore)"

        let accent = ThemeManager.shared.accentColor
        outcomeLabel.text = result.outcome
        outcomeLabel.textColor = accent

        leagueLabel.text = leagueName ?? ""

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        dateLabel.text = formatter.string(from: result.date)
    }
}
