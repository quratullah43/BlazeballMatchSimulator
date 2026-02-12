import Foundation

struct League: Identifiable, Hashable {
    let id: String
    let name: String
    let country: String
    let teams: [Team]
}

extension League {
    static let allLeagues: [League] = [
        League(
            id: "epl",
            name: "Premier League",
            country: "England",
            teams: Team.premierLeagueTeams
        ),
        League(
            id: "laliga",
            name: "La Liga",
            country: "Spain",
            teams: Team.laLigaTeams
        ),
        League(
            id: "bundesliga",
            name: "Bundesliga",
            country: "Germany",
            teams: Team.bundesligaTeams
        ),
        League(
            id: "seriea",
            name: "Serie A",
            country: "Italy",
            teams: Team.serieATeams
        ),
        League(
            id: "ligue1",
            name: "Ligue 1",
            country: "France",
            teams: Team.ligue1Teams
        ),
        League(
            id: "eredivisie",
            name: "Eredivisie",
            country: "Netherlands",
            teams: Team.eredivisieTeams
        ),
        League(
            id: "primeiraliga",
            name: "Primeira Liga",
            country: "Portugal",
            teams: Team.primeiraLigaTeams
        ),
        League(
            id: "mls",
            name: "MLS",
            country: "USA",
            teams: Team.mlsTeams
        )
    ]
}
