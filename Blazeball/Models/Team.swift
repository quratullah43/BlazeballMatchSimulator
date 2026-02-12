import Foundation
import UIKit

struct Team: Identifiable, Hashable {
    let id: String
    let name: String
    let shortName: String
    let primaryColor: UIColor
    let secondaryColor: UIColor
    let attack: Int
    let defense: Int
    let midfield: Int
    
    var overall: Int {
        (attack + defense + midfield) / 3
    }
}

extension Team {
    static let premierLeagueTeams: [Team] = [
        Team(id: "mci", name: "Manchester City", shortName: "MCI", primaryColor: .systemBlue, secondaryColor: .white, attack: 92, defense: 88, midfield: 90),
        Team(id: "ars", name: "Arsenal", shortName: "ARS", primaryColor: .systemRed, secondaryColor: .white, attack: 88, defense: 85, midfield: 87),
        Team(id: "liv", name: "Liverpool", shortName: "LIV", primaryColor: .red, secondaryColor: .white, attack: 90, defense: 86, midfield: 88),
        Team(id: "mun", name: "Manchester United", shortName: "MUN", primaryColor: .red, secondaryColor: .black, attack: 84, defense: 80, midfield: 82),
        Team(id: "che", name: "Chelsea", shortName: "CHE", primaryColor: .systemBlue, secondaryColor: .white, attack: 83, defense: 82, midfield: 84),
        Team(id: "tot", name: "Tottenham Hotspur", shortName: "TOT", primaryColor: .white, secondaryColor: .systemBlue, attack: 85, defense: 79, midfield: 83),
        Team(id: "new", name: "Newcastle United", shortName: "NEW", primaryColor: .black, secondaryColor: .white, attack: 82, defense: 81, midfield: 80),
        Team(id: "avl", name: "Aston Villa", shortName: "AVL", primaryColor: .purple, secondaryColor: .systemBlue, attack: 80, defense: 78, midfield: 79),
        Team(id: "whu", name: "West Ham United", shortName: "WHU", primaryColor: .purple, secondaryColor: .systemBlue, attack: 78, defense: 76, midfield: 77),
        Team(id: "bha", name: "Brighton & Hove Albion", shortName: "BHA", primaryColor: .systemBlue, secondaryColor: .white, attack: 77, defense: 75, midfield: 78),
        Team(id: "cry", name: "Crystal Palace", shortName: "CRY", primaryColor: .systemBlue, secondaryColor: .red, attack: 74, defense: 73, midfield: 74),
        Team(id: "bre", name: "Brentford", shortName: "BRE", primaryColor: .red, secondaryColor: .white, attack: 76, defense: 74, midfield: 75),
        Team(id: "ful", name: "Fulham", shortName: "FUL", primaryColor: .white, secondaryColor: .black, attack: 75, defense: 73, midfield: 74),
        Team(id: "wol", name: "Wolverhampton", shortName: "WOL", primaryColor: .orange, secondaryColor: .black, attack: 74, defense: 72, midfield: 73),
        Team(id: "bou", name: "AFC Bournemouth", shortName: "BOU", primaryColor: .red, secondaryColor: .black, attack: 73, defense: 71, midfield: 72),
        Team(id: "nfo", name: "Nottingham Forest", shortName: "NFO", primaryColor: .red, secondaryColor: .white, attack: 72, defense: 74, midfield: 71),
        Team(id: "eve", name: "Everton", shortName: "EVE", primaryColor: .systemBlue, secondaryColor: .white, attack: 71, defense: 72, midfield: 70),
        Team(id: "lut", name: "Luton Town", shortName: "LUT", primaryColor: .orange, secondaryColor: .white, attack: 68, defense: 66, midfield: 67),
        Team(id: "bur", name: "Burnley", shortName: "BUR", primaryColor: .purple, secondaryColor: .systemBlue, attack: 67, defense: 65, midfield: 66),
        Team(id: "shu", name: "Sheffield United", shortName: "SHU", primaryColor: .red, secondaryColor: .white, attack: 66, defense: 64, midfield: 65)
    ]
    
    static let laLigaTeams: [Team] = [
        Team(id: "rma", name: "Real Madrid", shortName: "RMA", primaryColor: .white, secondaryColor: .systemYellow, attack: 91, defense: 87, midfield: 89),
        Team(id: "fcb", name: "FC Barcelona", shortName: "BAR", primaryColor: .systemBlue, secondaryColor: .red, attack: 89, defense: 84, midfield: 88),
        Team(id: "atm", name: "Atletico Madrid", shortName: "ATM", primaryColor: .red, secondaryColor: .white, attack: 84, defense: 86, midfield: 83),
        Team(id: "sev", name: "Sevilla FC", shortName: "SEV", primaryColor: .red, secondaryColor: .white, attack: 80, defense: 79, midfield: 80),
        Team(id: "rso", name: "Real Sociedad", shortName: "RSO", primaryColor: .systemBlue, secondaryColor: .white, attack: 79, defense: 77, midfield: 80),
        Team(id: "vil", name: "Villarreal CF", shortName: "VIL", primaryColor: .systemYellow, secondaryColor: .systemBlue, attack: 78, defense: 76, midfield: 79),
        Team(id: "bet", name: "Real Betis", shortName: "BET", primaryColor: .systemGreen, secondaryColor: .white, attack: 77, defense: 75, midfield: 78),
        Team(id: "ath", name: "Athletic Bilbao", shortName: "ATH", primaryColor: .red, secondaryColor: .white, attack: 76, defense: 77, midfield: 76),
        Team(id: "val", name: "Valencia CF", shortName: "VAL", primaryColor: .white, secondaryColor: .orange, attack: 75, defense: 74, midfield: 75),
        Team(id: "gir", name: "Girona FC", shortName: "GIR", primaryColor: .red, secondaryColor: .white, attack: 77, defense: 73, midfield: 76),
        Team(id: "osa", name: "CA Osasuna", shortName: "OSA", primaryColor: .red, secondaryColor: .systemBlue, attack: 72, defense: 74, midfield: 72),
        Team(id: "get", name: "Getafe CF", shortName: "GET", primaryColor: .systemBlue, secondaryColor: .white, attack: 70, defense: 73, midfield: 71),
        Team(id: "cel", name: "Celta Vigo", shortName: "CEL", primaryColor: .systemBlue, secondaryColor: .white, attack: 73, defense: 70, midfield: 72),
        Team(id: "mal", name: "RCD Mallorca", shortName: "MAL", primaryColor: .red, secondaryColor: .black, attack: 71, defense: 72, midfield: 70),
        Team(id: "ray", name: "Rayo Vallecano", shortName: "RAY", primaryColor: .white, secondaryColor: .red, attack: 70, defense: 69, midfield: 70),
        Team(id: "cad", name: "Cadiz CF", shortName: "CAD", primaryColor: .systemYellow, secondaryColor: .systemBlue, attack: 67, defense: 68, midfield: 67),
        Team(id: "alm", name: "UD Almeria", shortName: "ALM", primaryColor: .red, secondaryColor: .white, attack: 66, defense: 65, midfield: 66),
        Team(id: "gra", name: "Granada CF", shortName: "GRA", primaryColor: .red, secondaryColor: .white, attack: 65, defense: 64, midfield: 65),
        Team(id: "ala", name: "Alaves", shortName: "ALA", primaryColor: .systemBlue, secondaryColor: .white, attack: 68, defense: 67, midfield: 68),
        Team(id: "lpa", name: "Las Palmas", shortName: "LPA", primaryColor: .systemYellow, secondaryColor: .systemBlue, attack: 69, defense: 66, midfield: 68)
    ]
    
    static let bundesligaTeams: [Team] = [
        Team(id: "bay", name: "Bayern Munich", shortName: "BAY", primaryColor: .red, secondaryColor: .white, attack: 90, defense: 86, midfield: 88),
        Team(id: "bvb", name: "Borussia Dortmund", shortName: "BVB", primaryColor: .systemYellow, secondaryColor: .black, attack: 86, defense: 80, midfield: 84),
        Team(id: "rbl", name: "RB Leipzig", shortName: "RBL", primaryColor: .red, secondaryColor: .white, attack: 84, defense: 81, midfield: 83),
        Team(id: "b04", name: "Bayer Leverkusen", shortName: "B04", primaryColor: .red, secondaryColor: .black, attack: 85, defense: 82, midfield: 84),
        Team(id: "ein", name: "Eintracht Frankfurt", shortName: "EIN", primaryColor: .black, secondaryColor: .red, attack: 79, defense: 77, midfield: 78),
        Team(id: "wob", name: "VfL Wolfsburg", shortName: "WOB", primaryColor: .systemGreen, secondaryColor: .white, attack: 76, defense: 76, midfield: 76),
        Team(id: "bmg", name: "Borussia Monchengladbach", shortName: "BMG", primaryColor: .black, secondaryColor: .white, attack: 75, defense: 74, midfield: 76),
        Team(id: "scf", name: "SC Freiburg", shortName: "SCF", primaryColor: .red, secondaryColor: .black, attack: 74, defense: 76, midfield: 75),
        Team(id: "tsg", name: "TSG Hoffenheim", shortName: "TSG", primaryColor: .systemBlue, secondaryColor: .white, attack: 76, defense: 73, midfield: 75),
        Team(id: "uni", name: "Union Berlin", shortName: "UNI", primaryColor: .red, secondaryColor: .white, attack: 73, defense: 75, midfield: 73),
        Team(id: "m05", name: "Mainz 05", shortName: "M05", primaryColor: .red, secondaryColor: .white, attack: 72, defense: 71, midfield: 72),
        Team(id: "vfb", name: "VfB Stuttgart", shortName: "VFB", primaryColor: .red, secondaryColor: .white, attack: 77, defense: 74, midfield: 76),
        Team(id: "aug", name: "FC Augsburg", shortName: "AUG", primaryColor: .red, secondaryColor: .systemGreen, attack: 70, defense: 70, midfield: 70),
        Team(id: "boc", name: "VfL Bochum", shortName: "BOC", primaryColor: .systemBlue, secondaryColor: .white, attack: 68, defense: 69, midfield: 68),
        Team(id: "wer", name: "Werder Bremen", shortName: "WER", primaryColor: .systemGreen, secondaryColor: .white, attack: 72, defense: 70, midfield: 71),
        Team(id: "koe", name: "FC Koln", shortName: "KOE", primaryColor: .red, secondaryColor: .white, attack: 69, defense: 68, midfield: 69),
        Team(id: "hei", name: "Heidenheim", shortName: "HEI", primaryColor: .red, secondaryColor: .white, attack: 67, defense: 68, midfield: 67),
        Team(id: "dar", name: "Darmstadt 98", shortName: "DAR", primaryColor: .systemBlue, secondaryColor: .white, attack: 65, defense: 64, midfield: 65)
    ]
    
    static let serieATeams: [Team] = [
        Team(id: "int", name: "Inter Milan", shortName: "INT", primaryColor: .systemBlue, secondaryColor: .black, attack: 87, defense: 86, midfield: 86),
        Team(id: "nap", name: "Napoli", shortName: "NAP", primaryColor: .systemBlue, secondaryColor: .white, attack: 85, defense: 82, midfield: 84),
        Team(id: "juv", name: "Juventus", shortName: "JUV", primaryColor: .white, secondaryColor: .black, attack: 83, defense: 84, midfield: 82),
        Team(id: "mil", name: "AC Milan", shortName: "MIL", primaryColor: .red, secondaryColor: .black, attack: 84, defense: 80, midfield: 82),
        Team(id: "ata", name: "Atalanta", shortName: "ATA", primaryColor: .systemBlue, secondaryColor: .black, attack: 83, defense: 79, midfield: 82),
        Team(id: "rom", name: "AS Roma", shortName: "ROM", primaryColor: .orange, secondaryColor: .red, attack: 80, defense: 78, midfield: 79),
        Team(id: "laz", name: "Lazio", shortName: "LAZ", primaryColor: .systemBlue, secondaryColor: .white, attack: 79, defense: 77, midfield: 78),
        Team(id: "fio", name: "Fiorentina", shortName: "FIO", primaryColor: .purple, secondaryColor: .white, attack: 78, defense: 75, midfield: 77),
        Team(id: "tor", name: "Torino", shortName: "TOR", primaryColor: .purple, secondaryColor: .white, attack: 74, defense: 75, midfield: 74),
        Team(id: "bol", name: "Bologna", shortName: "BOL", primaryColor: .red, secondaryColor: .systemBlue, attack: 75, defense: 74, midfield: 75),
        Team(id: "mon", name: "Monza", shortName: "MON", primaryColor: .red, secondaryColor: .white, attack: 72, defense: 72, midfield: 72),
        Team(id: "gen", name: "Genoa", shortName: "GEN", primaryColor: .red, secondaryColor: .systemBlue, attack: 71, defense: 71, midfield: 71),
        Team(id: "udi", name: "Udinese", shortName: "UDI", primaryColor: .white, secondaryColor: .black, attack: 72, defense: 73, midfield: 71),
        Team(id: "emp", name: "Empoli", shortName: "EMP", primaryColor: .systemBlue, secondaryColor: .white, attack: 69, defense: 70, midfield: 69),
        Team(id: "sas", name: "Sassuolo", shortName: "SAS", primaryColor: .systemGreen, secondaryColor: .black, attack: 71, defense: 68, midfield: 70),
        Team(id: "lec", name: "Lecce", shortName: "LEC", primaryColor: .systemYellow, secondaryColor: .red, attack: 68, defense: 69, midfield: 68),
        Team(id: "ver", name: "Verona", shortName: "VER", primaryColor: .systemYellow, secondaryColor: .systemBlue, attack: 67, defense: 68, midfield: 67),
        Team(id: "cag", name: "Cagliari", shortName: "CAG", primaryColor: .red, secondaryColor: .systemBlue, attack: 70, defense: 69, midfield: 69),
        Team(id: "fro", name: "Frosinone", shortName: "FRO", primaryColor: .systemYellow, secondaryColor: .systemBlue, attack: 66, defense: 65, midfield: 66),
        Team(id: "sal", name: "Salernitana", shortName: "SAL", primaryColor: .purple, secondaryColor: .white, attack: 65, defense: 64, midfield: 65)
    ]
    
    static let ligue1Teams: [Team] = [
        Team(id: "psg", name: "Paris Saint-Germain", shortName: "PSG", primaryColor: .systemBlue, secondaryColor: .red, attack: 90, defense: 84, midfield: 87),
        Team(id: "mon", name: "AS Monaco", shortName: "MON", primaryColor: .red, secondaryColor: .white, attack: 80, defense: 77, midfield: 79),
        Team(id: "lil", name: "Lille OSC", shortName: "LIL", primaryColor: .red, secondaryColor: .white, attack: 78, defense: 78, midfield: 77),
        Team(id: "mar", name: "Olympique Marseille", shortName: "MAR", primaryColor: .systemBlue, secondaryColor: .white, attack: 79, defense: 76, midfield: 78),
        Team(id: "ren", name: "Stade Rennais", shortName: "REN", primaryColor: .red, secondaryColor: .black, attack: 77, defense: 75, midfield: 76),
        Team(id: "nic", name: "OGC Nice", shortName: "NIC", primaryColor: .red, secondaryColor: .black, attack: 76, defense: 77, midfield: 75),
        Team(id: "len", name: "RC Lens", shortName: "LEN", primaryColor: .red, secondaryColor: .systemYellow, attack: 78, defense: 76, midfield: 77),
        Team(id: "lyo", name: "Olympique Lyon", shortName: "LYO", primaryColor: .systemBlue, secondaryColor: .white, attack: 77, defense: 73, midfield: 76),
        Team(id: "nan", name: "FC Nantes", shortName: "NAN", primaryColor: .systemYellow, secondaryColor: .systemGreen, attack: 72, defense: 72, midfield: 72),
        Team(id: "str", name: "Strasbourg", shortName: "STR", primaryColor: .systemBlue, secondaryColor: .white, attack: 71, defense: 71, midfield: 71),
        Team(id: "rei", name: "Stade Reims", shortName: "REI", primaryColor: .red, secondaryColor: .white, attack: 70, defense: 72, midfield: 70),
        Team(id: "mon", name: "Montpellier", shortName: "MTP", primaryColor: .orange, secondaryColor: .systemBlue, attack: 71, defense: 70, midfield: 71),
        Team(id: "tou", name: "Toulouse FC", shortName: "TOU", primaryColor: .purple, secondaryColor: .white, attack: 72, defense: 71, midfield: 71),
        Team(id: "bre", name: "Stade Brestois", shortName: "BRE", primaryColor: .red, secondaryColor: .white, attack: 73, defense: 72, midfield: 72),
        Team(id: "leh", name: "Le Havre", shortName: "LEH", primaryColor: .systemBlue, secondaryColor: .white, attack: 68, defense: 69, midfield: 68),
        Team(id: "lor", name: "FC Lorient", shortName: "LOR", primaryColor: .orange, secondaryColor: .black, attack: 67, defense: 66, midfield: 67),
        Team(id: "met", name: "FC Metz", shortName: "MET", primaryColor: .purple, secondaryColor: .white, attack: 66, defense: 67, midfield: 66),
        Team(id: "cle", name: "Clermont Foot", shortName: "CLE", primaryColor: .red, secondaryColor: .systemBlue, attack: 65, defense: 64, midfield: 65)
    ]
    
    static let eredivisieTeams: [Team] = [
        Team(id: "aja", name: "Ajax Amsterdam", shortName: "AJA", primaryColor: .red, secondaryColor: .white, attack: 82, defense: 78, midfield: 81),
        Team(id: "psv", name: "PSV Eindhoven", shortName: "PSV", primaryColor: .red, secondaryColor: .white, attack: 83, defense: 79, midfield: 81),
        Team(id: "fey", name: "Feyenoord", shortName: "FEY", primaryColor: .red, secondaryColor: .white, attack: 80, defense: 77, midfield: 79),
        Team(id: "alk", name: "AZ Alkmaar", shortName: "AZA", primaryColor: .red, secondaryColor: .white, attack: 77, defense: 75, midfield: 76),
        Team(id: "twe", name: "FC Twente", shortName: "TWE", primaryColor: .red, secondaryColor: .white, attack: 75, defense: 74, midfield: 75),
        Team(id: "utr", name: "FC Utrecht", shortName: "UTR", primaryColor: .red, secondaryColor: .white, attack: 73, defense: 72, midfield: 73),
        Team(id: "vit", name: "Vitesse", shortName: "VIT", primaryColor: .systemYellow, secondaryColor: .black, attack: 71, defense: 70, midfield: 71),
        Team(id: "her", name: "SC Heerenveen", shortName: "HEE", primaryColor: .systemBlue, secondaryColor: .white, attack: 70, defense: 69, midfield: 70),
        Team(id: "gro", name: "FC Groningen", shortName: "GRO", primaryColor: .systemGreen, secondaryColor: .white, attack: 69, defense: 68, midfield: 69),
        Team(id: "spa", name: "Sparta Rotterdam", shortName: "SPA", primaryColor: .red, secondaryColor: .white, attack: 68, defense: 69, midfield: 68)
    ]
    
    static let primeiraLigaTeams: [Team] = [
        Team(id: "ben", name: "SL Benfica", shortName: "BEN", primaryColor: .red, secondaryColor: .white, attack: 84, defense: 80, midfield: 82),
        Team(id: "por", name: "FC Porto", shortName: "POR", primaryColor: .systemBlue, secondaryColor: .white, attack: 83, defense: 81, midfield: 82),
        Team(id: "scp", name: "Sporting CP", shortName: "SCP", primaryColor: .systemGreen, secondaryColor: .white, attack: 82, defense: 79, midfield: 81),
        Team(id: "bra", name: "SC Braga", shortName: "BRA", primaryColor: .red, secondaryColor: .white, attack: 78, defense: 76, midfield: 77),
        Team(id: "vit", name: "Vitoria SC", shortName: "VIT", primaryColor: .white, secondaryColor: .black, attack: 73, defense: 72, midfield: 73),
        Team(id: "bfc", name: "Boavista FC", shortName: "BOA", primaryColor: .white, secondaryColor: .black, attack: 70, defense: 71, midfield: 70),
        Team(id: "rio", name: "Rio Ave", shortName: "RIO", primaryColor: .systemGreen, secondaryColor: .white, attack: 69, defense: 70, midfield: 69),
        Team(id: "far", name: "SC Farense", shortName: "FAR", primaryColor: .white, secondaryColor: .black, attack: 67, defense: 68, midfield: 67),
        Team(id: "gil", name: "Gil Vicente", shortName: "GIL", primaryColor: .red, secondaryColor: .white, attack: 68, defense: 67, midfield: 68),
        Team(id: "est", name: "Estoril Praia", shortName: "EST", primaryColor: .systemYellow, secondaryColor: .systemBlue, attack: 69, defense: 68, midfield: 69)
    ]
    
    static let mlsTeams: [Team] = [
        Team(id: "lai", name: "LA Galaxy", shortName: "LAG", primaryColor: .systemBlue, secondaryColor: .systemYellow, attack: 78, defense: 74, midfield: 76),
        Team(id: "laf", name: "LAFC", shortName: "LAF", primaryColor: .black, secondaryColor: .systemYellow, attack: 80, defense: 76, midfield: 78),
        Team(id: "mia", name: "Inter Miami", shortName: "MIA", primaryColor: .systemPink, secondaryColor: .black, attack: 79, defense: 74, midfield: 77),
        Team(id: "nyc", name: "New York City FC", shortName: "NYC", primaryColor: .systemBlue, secondaryColor: .orange, attack: 77, defense: 75, midfield: 76),
        Team(id: "nyr", name: "New York Red Bulls", shortName: "NYR", primaryColor: .red, secondaryColor: .white, attack: 76, defense: 74, midfield: 75),
        Team(id: "atl", name: "Atlanta United", shortName: "ATL", primaryColor: .red, secondaryColor: .black, attack: 77, defense: 73, midfield: 76),
        Team(id: "sea", name: "Seattle Sounders", shortName: "SEA", primaryColor: .systemGreen, secondaryColor: .systemBlue, attack: 78, defense: 76, midfield: 77),
        Team(id: "cin", name: "FC Cincinnati", shortName: "CIN", primaryColor: .systemBlue, secondaryColor: .orange, attack: 76, defense: 75, midfield: 75),
        Team(id: "phi", name: "Philadelphia Union", shortName: "PHI", primaryColor: .systemBlue, secondaryColor: .systemYellow, attack: 75, defense: 77, midfield: 74),
        Team(id: "col", name: "Colorado Rapids", shortName: "COL", primaryColor: .purple, secondaryColor: .systemBlue, attack: 73, defense: 72, midfield: 73),
        Team(id: "por", name: "Portland Timbers", shortName: "POR", primaryColor: .systemGreen, secondaryColor: .systemYellow, attack: 74, defense: 72, midfield: 74),
        Team(id: "aus", name: "Austin FC", shortName: "AUS", primaryColor: .systemGreen, secondaryColor: .black, attack: 75, defense: 73, midfield: 74)
    ]
}
