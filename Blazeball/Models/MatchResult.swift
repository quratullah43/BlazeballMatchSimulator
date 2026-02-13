import Foundation

struct MatchResult: Codable, Identifiable {
    let id: String
    let homeTeamId: String
    let homeTeamName: String
    let homeTeamShort: String
    let awayTeamId: String
    let awayTeamName: String
    let awayTeamShort: String
    let homeScore: Int
    let awayScore: Int
    let date: Date
    let goalEvents: [GoalEventRecord]

    init(homeTeam: Team, awayTeam: Team, homeScore: Int, awayScore: Int, events: [MatchEvent]) {
        self.id = UUID().uuidString
        self.homeTeamId = homeTeam.id
        self.homeTeamName = homeTeam.name
        self.homeTeamShort = homeTeam.shortName
        self.awayTeamId = awayTeam.id
        self.awayTeamName = awayTeam.name
        self.awayTeamShort = awayTeam.shortName
        self.homeScore = homeScore
        self.awayScore = awayScore
        self.date = Date()
        self.goalEvents = events
            .filter { $0.type == .goal || $0.type == .penalty || $0.type == .ownGoal }
            .map { GoalEventRecord(minute: $0.minute, teamId: $0.team.id, description: $0.description) }
    }

    var outcome: String {
        if homeScore > awayScore { return "\(homeTeamName) Win" }
        if awayScore > homeScore { return "\(awayTeamName) Win" }
        return "Draw"
    }
}

struct GoalEventRecord: Codable {
    let minute: Int
    let teamId: String
    let description: String
}
