import UIKit

final class TeamsViewController: UIViewController {
    
    private let league: League
    private var tableView: UITableView!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    init(league: League) {
        self.league = league
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
        title = league.name
        view.backgroundColor = .systemBackground
        
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TeamCell.self, forCellReuseIdentifier: TeamCell.identifier)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension TeamsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return league.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamCell.identifier, for: indexPath) as? TeamCell else {
            return UITableViewCell()
        }
        let team = league.teams[indexPath.row]
        cell.configure(with: team, rank: indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let team = league.teams[indexPath.row]
        let detailVC = TeamDetailViewController(team: team)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

final class TeamCell: UITableViewCell {
    static let identifier = "TeamCell"
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let shortNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overallLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = ThemeManager.shared.accentColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(rankLabel)
        contentView.addSubview(colorView)
        colorView.addSubview(shortNameLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statsLabel)
        contentView.addSubview(overallLabel)
        
        NSLayoutConstraint.activate([
            rankLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            rankLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rankLabel.widthAnchor.constraint(equalToConstant: 30),
            
            colorView.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 8),
            colorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            colorView.widthAnchor.constraint(equalToConstant: 40),
            colorView.heightAnchor.constraint(equalToConstant: 40),
            
            shortNameLabel.centerXAnchor.constraint(equalTo: colorView.centerXAnchor),
            shortNameLabel.centerYAnchor.constraint(equalTo: colorView.centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: overallLabel.leadingAnchor, constant: -8),
            
            statsLabel.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 12),
            statsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            
            overallLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            overallLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with team: Team, rank: Int) {
        rankLabel.text = "\(rank)"
        colorView.backgroundColor = team.primaryColor
        shortNameLabel.text = team.shortName
        nameLabel.text = team.name
        statsLabel.text = "ATK: \(team.attack) | DEF: \(team.defense) | MID: \(team.midfield)"
        overallLabel.text = "\(team.overall)"
    }
}
