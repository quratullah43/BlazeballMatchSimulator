import Foundation

final class MatchSimulator {
    
    func simulateMatch(homeTeam: Team, awayTeam: Team) -> Match {
        var match = Match(homeTeam: homeTeam, awayTeam: awayTeam)
        
        let homeStrength = Double(homeTeam.attack + homeTeam.midfield) / 200.0
        let awayStrength = Double(awayTeam.attack + awayTeam.midfield) / 200.0
        let homeDefense = Double(homeTeam.defense) / 100.0
        let awayDefense = Double(awayTeam.defense) / 100.0
        
        let homeAdvantage = 0.1
        
        for minute in 1...90 {
            let homeChance = (homeStrength + homeAdvantage) * (1 - awayDefense * 0.5)
            let awayChance = awayStrength * (1 - homeDefense * 0.5)
            
            if Double.random(in: 0...1) < homeChance * 0.03 {
                match.homeScore += 1
                let event = MatchEvent(
                    minute: minute,
                    type: .goal,
                    team: homeTeam,
                    description: "GOAL! \(homeTeam.name) scores!"
                )
                match.events.append(event)
            }
            
            if Double.random(in: 0...1) < awayChance * 0.025 {
                match.awayScore += 1
                let event = MatchEvent(
                    minute: minute,
                    type: .goal,
                    team: awayTeam,
                    description: "GOAL! \(awayTeam.name) scores!"
                )
                match.events.append(event)
            }
            
            if Double.random(in: 0...1) < 0.01 {
                let team = Bool.random() ? homeTeam : awayTeam
                let event = MatchEvent(
                    minute: minute,
                    type: .yellowCard,
                    team: team,
                    description: "Yellow card for \(team.name)"
                )
                match.events.append(event)
            }
            
            if Double.random(in: 0...1) < 0.02 {
                let team = Bool.random() ? homeTeam : awayTeam
                let event = MatchEvent(
                    minute: minute,
                    type: .corner,
                    team: team,
                    description: "Corner kick for \(team.name)"
                )
                match.events.append(event)
            }
            
            if Double.random(in: 0...1) < 0.015 {
                let team = Bool.random() ? homeTeam : awayTeam
                let event = MatchEvent(
                    minute: minute,
                    type: .freeKick,
                    team: team,
                    description: "Free kick for \(team.name)"
                )
                match.events.append(event)
            }
            
            if Double.random(in: 0...1) < 0.005 {
                let team = Bool.random() ? homeTeam : awayTeam
                let isScored = Double.random(in: 0...1) < 0.75
                if isScored {
                    if team.id == homeTeam.id {
                        match.homeScore += 1
                    } else {
                        match.awayScore += 1
                    }
                    let event = MatchEvent(
                        minute: minute,
                        type: .penalty,
                        team: team,
                        description: "PENALTY GOAL! \(team.name) converts!"
                    )
                    match.events.append(event)
                } else {
                    let event = MatchEvent(
                        minute: minute,
                        type: .penaltyMiss,
                        team: team,
                        description: "Penalty missed by \(team.name)!"
                    )
                    match.events.append(event)
                }
            }
        }
        
        match.currentMinute = 90
        match.isFinished = true
        
        return match
    }
    
    func generateMatchEvents(homeTeam: Team, awayTeam: Team) -> [(minute: Int, event: MatchEvent, homeScore: Int, awayScore: Int)] {
        var events: [(minute: Int, event: MatchEvent, homeScore: Int, awayScore: Int)] = []
        var homeScore = 0
        var awayScore = 0
        
        let homeStrength = Double(homeTeam.attack + homeTeam.midfield) / 200.0
        let awayStrength = Double(awayTeam.attack + awayTeam.midfield) / 200.0
        let homeDefense = Double(homeTeam.defense) / 100.0
        let awayDefense = Double(awayTeam.defense) / 100.0
        let homeAdvantage = 0.1
        
        for minute in 1...90 {
            let homeChance = (homeStrength + homeAdvantage) * (1 - awayDefense * 0.5)
            let awayChance = awayStrength * (1 - homeDefense * 0.5)
            
            if Double.random(in: 0...1) < homeChance * 0.03 {
                homeScore += 1
                let event = MatchEvent(minute: minute, type: .goal, team: homeTeam, description: "GOAL! \(homeTeam.name) scores!")
                events.append((minute, event, homeScore, awayScore))
            }
            
            if Double.random(in: 0...1) < awayChance * 0.025 {
                awayScore += 1
                let event = MatchEvent(minute: minute, type: .goal, team: awayTeam, description: "GOAL! \(awayTeam.name) scores!")
                events.append((minute, event, homeScore, awayScore))
            }
            
            if Double.random(in: 0...1) < 0.008 {
                let team = Bool.random() ? homeTeam : awayTeam
                let event = MatchEvent(minute: minute, type: .yellowCard, team: team, description: "Yellow card for \(team.name)")
                events.append((minute, event, homeScore, awayScore))
            }
            
            if Double.random(in: 0...1) < 0.004 {
                let team = Bool.random() ? homeTeam : awayTeam
                let isScored = Double.random(in: 0...1) < 0.75
                if isScored {
                    if team.id == homeTeam.id {
                        homeScore += 1
                    } else {
                        awayScore += 1
                    }
                    let event = MatchEvent(minute: minute, type: .penalty, team: team, description: "PENALTY GOAL! \(team.name) converts!")
                    events.append((minute, event, homeScore, awayScore))
                } else {
                    let event = MatchEvent(minute: minute, type: .penaltyMiss, team: team, description: "Penalty missed by \(team.name)!")
                    events.append((minute, event, homeScore, awayScore))
                }
            }
        }
        
        return events
    }
}
