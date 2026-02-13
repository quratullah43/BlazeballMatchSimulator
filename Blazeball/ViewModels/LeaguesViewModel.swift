import Foundation
import Combine

final class LeaguesViewModel: ObservableObject {
    @Published var leagues: [League] = League.allLeagues
    @Published var selectedLeague: League?
    
    func selectLeague(_ league: League) {
        selectedLeague = league
    }
}
