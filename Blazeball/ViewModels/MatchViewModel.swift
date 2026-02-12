import Foundation
import Combine

final class MatchViewModel: ObservableObject {
    @Published var homeTeam: Team?
    @Published var awayTeam: Team?
    @Published var currentMatch: Match?
    @Published var isSimulating = false
    @Published var currentMinute = 0
    @Published var homeScore = 0
    @Published var awayScore = 0
    @Published var matchEvents: [MatchEvent] = []
    @Published var simulationEvents: [(minute: Int, event: MatchEvent, homeScore: Int, awayScore: Int)] = []
    @Published var currentEventIndex = 0
    
    private let simulator = MatchSimulator()
    
    func setTeams(home: Team, away: Team) {
        homeTeam = home
        awayTeam = away
        resetMatch()
    }
    
    func startSimulation() {
        guard let home = homeTeam, let away = awayTeam else { return }
        
        resetMatch()
        isSimulating = true
        simulationEvents = simulator.generateMatchEvents(homeTeam: home, awayTeam: away)
    }
    
    func updateMinute(_ minute: Int) {
        currentMinute = minute
        
        while currentEventIndex < simulationEvents.count && simulationEvents[currentEventIndex].minute <= minute {
            let eventData = simulationEvents[currentEventIndex]
            matchEvents.append(eventData.event)
            homeScore = eventData.homeScore
            awayScore = eventData.awayScore
            currentEventIndex += 1
        }
    }
    
    func finishSimulation() {
        isSimulating = false
        currentMinute = 90
        
        for i in currentEventIndex..<simulationEvents.count {
            let eventData = simulationEvents[i]
            matchEvents.append(eventData.event)
            homeScore = eventData.homeScore
            awayScore = eventData.awayScore
        }
    }
    
    func resetMatch() {
        currentMatch = nil
        currentMinute = 0
        homeScore = 0
        awayScore = 0
        matchEvents = []
        simulationEvents = []
        currentEventIndex = 0
        isSimulating = false
    }
}
