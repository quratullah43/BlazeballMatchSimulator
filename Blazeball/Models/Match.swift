import Foundation

struct Match: Identifiable {
    let id: UUID
    let homeTeam: Team
    let awayTeam: Team
    var homeScore: Int
    var awayScore: Int
    var events: [MatchEvent]
    var currentMinute: Int
    var isFinished: Bool
    
    init(homeTeam: Team, awayTeam: Team) {
        self.id = UUID()
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.homeScore = 0
        self.awayScore = 0
        self.events = []
        self.currentMinute = 0
        self.isFinished = false
    }
}

struct MatchEvent: Identifiable {
    let id: UUID
    let minute: Int
    let type: EventType
    let team: Team
    let description: String
    
    init(minute: Int, type: EventType, team: Team, description: String) {
        self.id = UUID()
        self.minute = minute
        self.type = type
        self.team = team
        self.description = description
    }
}

enum EventType {
    case goal
    case yellowCard
    case redCard
    case substitution
    case injury
    case save
    case corner
    case freeKick
    case penalty
    case penaltyMiss
    case ownGoal
}
