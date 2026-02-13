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
            name: "Royal League",
            country: "England",
            teams: Team.royalLeagueTeams
        ),
        League(
            id: "laliga",
            name: "Sol Liga",
            country: "Spain",
            teams: Team.solLigaTeams
        ),
        League(
            id: "bundesliga",
            name: "Kaiser Liga",
            country: "Germany",
            teams: Team.kaiserLigaTeams
        ),
        League(
            id: "seriea",
            name: "Prima Serie",
            country: "Italy",
            teams: Team.primaSerieTeams
        ),
        League(
            id: "ligue1",
            name: "Grande Ligue",
            country: "France",
            teams: Team.grandeLigueTeams
        ),
        League(
            id: "eredivisie",
            name: "Oranje Liga",
            country: "Netherlands",
            teams: Team.oranjeLigaTeams
        ),
        League(
            id: "primeiraliga",
            name: "Costa Liga",
            country: "Portugal",
            teams: Team.costaLigaTeams
        ),
        League(
            id: "mls",
            name: "Stars League",
            country: "USA",
            teams: Team.starsLeagueTeams
        )
    ]
}
