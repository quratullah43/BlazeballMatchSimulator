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
            name: "Red League",
            country: "England",
            teams: Team.royalLeagueTeams
        ),
        League(
            id: "laliga",
            name: "White Liga",
            country: "Spain",
            teams: Team.solLigaTeams
        ),
        League(
            id: "bundesliga",
            name: "Black Liga",
            country: "Germany",
            teams: Team.kaiserLigaTeams
        ),
        League(
            id: "seriea",
            name: "Red Serie",
            country: "Italy",
            teams: Team.primaSerieTeams
        ),
        League(
            id: "ligue1",
            name: "White Ligue",
            country: "France",
            teams: Team.grandeLigueTeams
        ),
        League(
            id: "eredivisie",
            name: "Green Liga",
            country: "Netherlands",
            teams: Team.oranjeLigaTeams
        ),
        League(
            id: "primeiraliga",
            name: "Red Liga",
            country: "Portugal",
            teams: Team.costaLigaTeams
        ),
        League(
            id: "mls",
            name: "Blue League",
            country: "USA",
            teams: Team.starsLeagueTeams
        )
    ]
}
