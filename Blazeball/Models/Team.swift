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
    static let royalLeagueTeams: [Team] = [
        Team(id: "mci", name: "Mancastle City", shortName: "MCC", primaryColor: .systemBlue, secondaryColor: .white, attack: 92, defense: 88, midfield: 90),
        Team(id: "ars", name: "Arternal", shortName: "ART", primaryColor: .systemRed, secondaryColor: .white, attack: 88, defense: 85, midfield: 87),
        Team(id: "liv", name: "Riverport", shortName: "RVP", primaryColor: .red, secondaryColor: .white, attack: 90, defense: 86, midfield: 88),
        Team(id: "mun", name: "Mancastle United", shortName: "MCU", primaryColor: .red, secondaryColor: .black, attack: 84, defense: 80, midfield: 82),
        Team(id: "che", name: "Chelford", shortName: "CHF", primaryColor: .systemBlue, secondaryColor: .white, attack: 83, defense: 82, midfield: 84),
        Team(id: "tot", name: "Tattenham Rovers", shortName: "TAT", primaryColor: .white, secondaryColor: .systemBlue, attack: 85, defense: 79, midfield: 83),
        Team(id: "new", name: "Newbridge United", shortName: "NBU", primaryColor: .black, secondaryColor: .white, attack: 82, defense: 81, midfield: 80),
        Team(id: "avl", name: "Ashton Villa", shortName: "ASV", primaryColor: .purple, secondaryColor: .systemBlue, attack: 80, defense: 78, midfield: 79),
        Team(id: "whu", name: "West Bridge United", shortName: "WBU", primaryColor: .purple, secondaryColor: .systemBlue, attack: 78, defense: 76, midfield: 77),
        Team(id: "bha", name: "Brightwell Albion", shortName: "BWA", primaryColor: .systemBlue, secondaryColor: .white, attack: 77, defense: 75, midfield: 78),
        Team(id: "cry", name: "Crystal Harbor", shortName: "CRH", primaryColor: .systemBlue, secondaryColor: .red, attack: 74, defense: 73, midfield: 74),
        Team(id: "bre", name: "Brentwick", shortName: "BRW", primaryColor: .red, secondaryColor: .white, attack: 76, defense: 74, midfield: 75),
        Team(id: "ful", name: "Fulford", shortName: "FUL", primaryColor: .white, secondaryColor: .black, attack: 75, defense: 73, midfield: 74),
        Team(id: "wol", name: "Wolfbury", shortName: "WFB", primaryColor: .orange, secondaryColor: .black, attack: 74, defense: 72, midfield: 73),
        Team(id: "bou", name: "AFC Bournville", shortName: "BRV", primaryColor: .red, secondaryColor: .black, attack: 73, defense: 71, midfield: 72),
        Team(id: "nfo", name: "Northam Forest", shortName: "NHF", primaryColor: .red, secondaryColor: .white, attack: 72, defense: 74, midfield: 71),
        Team(id: "eve", name: "Edgerton", shortName: "EDG", primaryColor: .systemBlue, secondaryColor: .white, attack: 71, defense: 72, midfield: 70),
        Team(id: "lut", name: "Lynton Town", shortName: "LYT", primaryColor: .orange, secondaryColor: .white, attack: 68, defense: 66, midfield: 67),
        Team(id: "bur", name: "Burnwick", shortName: "BNW", primaryColor: .purple, secondaryColor: .systemBlue, attack: 67, defense: 65, midfield: 66),
        Team(id: "shu", name: "Sheffmore United", shortName: "SMU", primaryColor: .red, secondaryColor: .white, attack: 66, defense: 64, midfield: 65)
    ]
    
    static let solLigaTeams: [Team] = [
        Team(id: "rma", name: "Royal Madriz", shortName: "RMZ", primaryColor: .white, secondaryColor: .systemYellow, attack: 91, defense: 87, midfield: 89),
        Team(id: "fcb", name: "FC Barcanova", shortName: "BAR", primaryColor: .systemBlue, secondaryColor: .red, attack: 89, defense: 84, midfield: 88),
        Team(id: "atm", name: "Atletica Madriz", shortName: "ATZ", primaryColor: .red, secondaryColor: .white, attack: 84, defense: 86, midfield: 83),
        Team(id: "sev", name: "Severia FC", shortName: "SVR", primaryColor: .red, secondaryColor: .white, attack: 80, defense: 79, midfield: 80),
        Team(id: "rso", name: "Royal Societa", shortName: "RSC", primaryColor: .systemBlue, secondaryColor: .white, attack: 79, defense: 77, midfield: 80),
        Team(id: "vil", name: "Villarosa CF", shortName: "VRS", primaryColor: .systemYellow, secondaryColor: .systemBlue, attack: 78, defense: 76, midfield: 79),
        Team(id: "bet", name: "Royal Bettica", shortName: "RBT", primaryColor: .systemGreen, secondaryColor: .white, attack: 77, defense: 75, midfield: 78),
        Team(id: "ath", name: "Athletic Bilbora", shortName: "ABL", primaryColor: .red, secondaryColor: .white, attack: 76, defense: 77, midfield: 76),
        Team(id: "val", name: "Valencio CF", shortName: "VLC", primaryColor: .white, secondaryColor: .orange, attack: 75, defense: 74, midfield: 75),
        Team(id: "gir", name: "Gironda FC", shortName: "GRD", primaryColor: .red, secondaryColor: .white, attack: 77, defense: 73, midfield: 76),
        Team(id: "osa", name: "CA Osanova", shortName: "OSN", primaryColor: .red, secondaryColor: .systemBlue, attack: 72, defense: 74, midfield: 72),
        Team(id: "get", name: "Getara CF", shortName: "GTR", primaryColor: .systemBlue, secondaryColor: .white, attack: 70, defense: 73, midfield: 71),
        Team(id: "cel", name: "Celta Vira", shortName: "CLV", primaryColor: .systemBlue, secondaryColor: .white, attack: 73, defense: 70, midfield: 72),
        Team(id: "mal", name: "RCD Malorca", shortName: "MLC", primaryColor: .red, secondaryColor: .black, attack: 71, defense: 72, midfield: 70),
        Team(id: "ray", name: "Rayo Vallerano", shortName: "RVL", primaryColor: .white, secondaryColor: .red, attack: 70, defense: 69, midfield: 70),
        Team(id: "cad", name: "Cadira CF", shortName: "CDR", primaryColor: .systemYellow, secondaryColor: .systemBlue, attack: 67, defense: 68, midfield: 67),
        Team(id: "alm", name: "UD Almera", shortName: "ALM", primaryColor: .red, secondaryColor: .white, attack: 66, defense: 65, midfield: 66),
        Team(id: "gra", name: "Granata CF", shortName: "GRT", primaryColor: .red, secondaryColor: .white, attack: 65, defense: 64, midfield: 65),
        Team(id: "ala", name: "Alavera", shortName: "ALV", primaryColor: .systemBlue, secondaryColor: .white, attack: 68, defense: 67, midfield: 68),
        Team(id: "lpa", name: "Las Palmera", shortName: "LPM", primaryColor: .systemYellow, secondaryColor: .systemBlue, attack: 69, defense: 66, midfield: 68)
    ]
    
    static let kaiserLigaTeams: [Team] = [
        Team(id: "bay", name: "Bavaria Munchen", shortName: "BAV", primaryColor: .red, secondaryColor: .white, attack: 90, defense: 86, midfield: 88),
        Team(id: "bvb", name: "Borusska Dortberg", shortName: "BDB", primaryColor: .systemYellow, secondaryColor: .black, attack: 86, defense: 80, midfield: 84),
        Team(id: "rbl", name: "RB Lipzig", shortName: "RBL", primaryColor: .red, secondaryColor: .white, attack: 84, defense: 81, midfield: 83),
        Team(id: "b04", name: "Bayer Levenberg", shortName: "BLV", primaryColor: .red, secondaryColor: .black, attack: 85, defense: 82, midfield: 84),
        Team(id: "ein", name: "Eintracht Frankberg", shortName: "EFB", primaryColor: .black, secondaryColor: .red, attack: 79, defense: 77, midfield: 78),
        Team(id: "wob", name: "VfL Wolfberg", shortName: "WFG", primaryColor: .systemGreen, secondaryColor: .white, attack: 76, defense: 76, midfield: 76),
        Team(id: "bmg", name: "Borusska Gladberg", shortName: "BGL", primaryColor: .black, secondaryColor: .white, attack: 75, defense: 74, midfield: 76),
        Team(id: "scf", name: "SC Freiwald", shortName: "SCW", primaryColor: .red, secondaryColor: .black, attack: 74, defense: 76, midfield: 75),
        Team(id: "tsg", name: "TSG Hofferberg", shortName: "TSH", primaryColor: .systemBlue, secondaryColor: .white, attack: 76, defense: 73, midfield: 75),
        Team(id: "uni", name: "Union Berlitz", shortName: "UBZ", primaryColor: .red, secondaryColor: .white, attack: 73, defense: 75, midfield: 73),
        Team(id: "m05", name: "Mainberg 05", shortName: "MBG", primaryColor: .red, secondaryColor: .white, attack: 72, defense: 71, midfield: 72),
        Team(id: "vfb", name: "VfB Stuttberg", shortName: "VFS", primaryColor: .red, secondaryColor: .white, attack: 77, defense: 74, midfield: 76),
        Team(id: "aug", name: "FC Augsberg", shortName: "FCA", primaryColor: .red, secondaryColor: .systemGreen, attack: 70, defense: 70, midfield: 70),
        Team(id: "boc", name: "VfL Bochberg", shortName: "VFB", primaryColor: .systemBlue, secondaryColor: .white, attack: 68, defense: 69, midfield: 68),
        Team(id: "wer", name: "Werder Bremberg", shortName: "WDB", primaryColor: .systemGreen, secondaryColor: .white, attack: 72, defense: 70, midfield: 71),
        Team(id: "koe", name: "FC Kolberg", shortName: "FCK", primaryColor: .red, secondaryColor: .white, attack: 69, defense: 68, midfield: 69),
        Team(id: "hei", name: "Heidenfeld", shortName: "HDF", primaryColor: .red, secondaryColor: .white, attack: 67, defense: 68, midfield: 67),
        Team(id: "dar", name: "Darmberg 98", shortName: "DMB", primaryColor: .systemBlue, secondaryColor: .white, attack: 65, defense: 64, midfield: 65)
    ]
    
    static let primaSerieTeams: [Team] = [
        Team(id: "int", name: "Inter Millano", shortName: "IML", primaryColor: .systemBlue, secondaryColor: .black, attack: 87, defense: 86, midfield: 86),
        Team(id: "nap", name: "Napolita", shortName: "NPT", primaryColor: .systemBlue, secondaryColor: .white, attack: 85, defense: 82, midfield: 84),
        Team(id: "juv", name: "Juventas", shortName: "JVT", primaryColor: .white, secondaryColor: .black, attack: 83, defense: 84, midfield: 82),
        Team(id: "mil", name: "AC Millano", shortName: "ACM", primaryColor: .red, secondaryColor: .black, attack: 84, defense: 80, midfield: 82),
        Team(id: "ata", name: "Atalantia", shortName: "ATL", primaryColor: .systemBlue, secondaryColor: .black, attack: 83, defense: 79, midfield: 82),
        Team(id: "rom", name: "AS Romagna", shortName: "ASR", primaryColor: .orange, secondaryColor: .red, attack: 80, defense: 78, midfield: 79),
        Team(id: "laz", name: "Laziale", shortName: "LZL", primaryColor: .systemBlue, secondaryColor: .white, attack: 79, defense: 77, midfield: 78),
        Team(id: "fio", name: "Fiorenza", shortName: "FRZ", primaryColor: .purple, secondaryColor: .white, attack: 78, defense: 75, midfield: 77),
        Team(id: "tor", name: "Torinova", shortName: "TRN", primaryColor: .purple, secondaryColor: .white, attack: 74, defense: 75, midfield: 74),
        Team(id: "bol", name: "Bolonia", shortName: "BON", primaryColor: .red, secondaryColor: .systemBlue, attack: 75, defense: 74, midfield: 75),
        Team(id: "mon", name: "Monzara", shortName: "MZR", primaryColor: .red, secondaryColor: .white, attack: 72, defense: 72, midfield: 72),
        Team(id: "gen", name: "Genovia", shortName: "GNV", primaryColor: .red, secondaryColor: .systemBlue, attack: 71, defense: 71, midfield: 71),
        Team(id: "udi", name: "Udinara", shortName: "UDN", primaryColor: .white, secondaryColor: .black, attack: 72, defense: 73, midfield: 71),
        Team(id: "emp", name: "Empolita", shortName: "EMP", primaryColor: .systemBlue, secondaryColor: .white, attack: 69, defense: 70, midfield: 69),
        Team(id: "sas", name: "Sassuria", shortName: "SSR", primaryColor: .systemGreen, secondaryColor: .black, attack: 71, defense: 68, midfield: 70),
        Team(id: "lec", name: "Leccara", shortName: "LCR", primaryColor: .systemYellow, secondaryColor: .red, attack: 68, defense: 69, midfield: 68),
        Team(id: "ver", name: "Veronara", shortName: "VRN", primaryColor: .systemYellow, secondaryColor: .systemBlue, attack: 67, defense: 68, midfield: 67),
        Team(id: "cag", name: "Cagliano", shortName: "CGL", primaryColor: .red, secondaryColor: .systemBlue, attack: 70, defense: 69, midfield: 69),
        Team(id: "fro", name: "Frosinara", shortName: "FRS", primaryColor: .systemYellow, secondaryColor: .systemBlue, attack: 66, defense: 65, midfield: 66),
        Team(id: "sal", name: "Salernova", shortName: "SLN", primaryColor: .purple, secondaryColor: .white, attack: 65, defense: 64, midfield: 65)
    ]
    
    static let grandeLigueTeams: [Team] = [
        Team(id: "psg", name: "Paris Saint-Germaine", shortName: "PSG", primaryColor: .systemBlue, secondaryColor: .red, attack: 90, defense: 84, midfield: 87),
        Team(id: "mon", name: "AS Monarca", shortName: "MNR", primaryColor: .red, secondaryColor: .white, attack: 80, defense: 77, midfield: 79),
        Team(id: "lil", name: "Lille OFC", shortName: "LOF", primaryColor: .red, secondaryColor: .white, attack: 78, defense: 78, midfield: 77),
        Team(id: "mar", name: "Olympique Marsella", shortName: "OMS", primaryColor: .systemBlue, secondaryColor: .white, attack: 79, defense: 76, midfield: 78),
        Team(id: "ren", name: "Stade Rennova", shortName: "SRN", primaryColor: .red, secondaryColor: .black, attack: 77, defense: 75, midfield: 76),
        Team(id: "nic", name: "OGC Nizza", shortName: "NZA", primaryColor: .red, secondaryColor: .black, attack: 76, defense: 77, midfield: 75),
        Team(id: "len", name: "RC Lenova", shortName: "RCL", primaryColor: .red, secondaryColor: .systemYellow, attack: 78, defense: 76, midfield: 77),
        Team(id: "lyo", name: "Olympique Lyonesse", shortName: "OLY", primaryColor: .systemBlue, secondaryColor: .white, attack: 77, defense: 73, midfield: 76),
        Team(id: "nan", name: "FC Nanterre", shortName: "FCN", primaryColor: .systemYellow, secondaryColor: .systemGreen, attack: 72, defense: 72, midfield: 72),
        Team(id: "str", name: "Strassburg", shortName: "STB", primaryColor: .systemBlue, secondaryColor: .white, attack: 71, defense: 71, midfield: 71),
        Team(id: "rei", name: "Stade Reimova", shortName: "SRM", primaryColor: .red, secondaryColor: .white, attack: 70, defense: 72, midfield: 70),
        Team(id: "mtp", name: "Montpellard", shortName: "MPL", primaryColor: .orange, secondaryColor: .systemBlue, attack: 71, defense: 70, midfield: 71),
        Team(id: "tou", name: "Toulousse FC", shortName: "TLS", primaryColor: .purple, secondaryColor: .white, attack: 72, defense: 71, midfield: 71),
        Team(id: "bre", name: "Stade Brestova", shortName: "SBR", primaryColor: .red, secondaryColor: .white, attack: 73, defense: 72, midfield: 72),
        Team(id: "leh", name: "Le Havra", shortName: "LHV", primaryColor: .systemBlue, secondaryColor: .white, attack: 68, defense: 69, midfield: 68),
        Team(id: "lor", name: "FC Lorenza", shortName: "LRZ", primaryColor: .orange, secondaryColor: .black, attack: 67, defense: 66, midfield: 67),
        Team(id: "met", name: "FC Metza", shortName: "MTZ", primaryColor: .purple, secondaryColor: .white, attack: 66, defense: 67, midfield: 66),
        Team(id: "cle", name: "Clermond Foot", shortName: "CLF", primaryColor: .red, secondaryColor: .systemBlue, attack: 65, defense: 64, midfield: 65)
    ]
    
    static let oranjeLigaTeams: [Team] = [
        Team(id: "aja", name: "Ajax Amstel", shortName: "AJA", primaryColor: .red, secondaryColor: .white, attack: 82, defense: 78, midfield: 81),
        Team(id: "psv", name: "PSV Eindberg", shortName: "PSV", primaryColor: .red, secondaryColor: .white, attack: 83, defense: 79, midfield: 81),
        Team(id: "fey", name: "Feyenord", shortName: "FEY", primaryColor: .red, secondaryColor: .white, attack: 80, defense: 77, midfield: 79),
        Team(id: "alk", name: "AZ Alkberg", shortName: "AZA", primaryColor: .red, secondaryColor: .white, attack: 77, defense: 75, midfield: 76),
        Team(id: "twe", name: "FC Twenthe", shortName: "TWE", primaryColor: .red, secondaryColor: .white, attack: 75, defense: 74, midfield: 75),
        Team(id: "utr", name: "FC Utrechia", shortName: "UTR", primaryColor: .red, secondaryColor: .white, attack: 73, defense: 72, midfield: 73),
        Team(id: "vit", name: "Vitessa", shortName: "VIT", primaryColor: .systemYellow, secondaryColor: .black, attack: 71, defense: 70, midfield: 71),
        Team(id: "her", name: "SC Heerenberg", shortName: "HEB", primaryColor: .systemBlue, secondaryColor: .white, attack: 70, defense: 69, midfield: 70),
        Team(id: "gro", name: "FC Gronberg", shortName: "GRB", primaryColor: .systemGreen, secondaryColor: .white, attack: 69, defense: 68, midfield: 69),
        Team(id: "spa", name: "Sparta Rotterberg", shortName: "SPR", primaryColor: .red, secondaryColor: .white, attack: 68, defense: 69, midfield: 68)
    ]
    
    static let costaLigaTeams: [Team] = [
        Team(id: "ben", name: "SL Benfiga", shortName: "BFG", primaryColor: .red, secondaryColor: .white, attack: 84, defense: 80, midfield: 82),
        Team(id: "por", name: "FC Portova", shortName: "PTV", primaryColor: .systemBlue, secondaryColor: .white, attack: 83, defense: 81, midfield: 82),
        Team(id: "scp", name: "Sporting CL", shortName: "SCL", primaryColor: .systemGreen, secondaryColor: .white, attack: 82, defense: 79, midfield: 81),
        Team(id: "bra", name: "SC Bragova", shortName: "BRG", primaryColor: .red, secondaryColor: .white, attack: 78, defense: 76, midfield: 77),
        Team(id: "vit", name: "Vittoria SC", shortName: "VSC", primaryColor: .white, secondaryColor: .black, attack: 73, defense: 72, midfield: 73),
        Team(id: "bfc", name: "Boavinta FC", shortName: "BVT", primaryColor: .white, secondaryColor: .black, attack: 70, defense: 71, midfield: 70),
        Team(id: "rio", name: "Rio Avera", shortName: "RVA", primaryColor: .systemGreen, secondaryColor: .white, attack: 69, defense: 70, midfield: 69),
        Team(id: "far", name: "SC Farenza", shortName: "FRN", primaryColor: .white, secondaryColor: .black, attack: 67, defense: 68, midfield: 67),
        Team(id: "gil", name: "Gil Vincente", shortName: "GVC", primaryColor: .red, secondaryColor: .white, attack: 68, defense: 67, midfield: 68),
        Team(id: "est", name: "Estoril Pravia", shortName: "EPR", primaryColor: .systemYellow, secondaryColor: .systemBlue, attack: 69, defense: 68, midfield: 69)
    ]
    
    static let starsLeagueTeams: [Team] = [
        Team(id: "lai", name: "LA Cosmos", shortName: "LAC", primaryColor: .systemBlue, secondaryColor: .systemYellow, attack: 78, defense: 74, midfield: 76),
        Team(id: "laf", name: "LASC", shortName: "LSC", primaryColor: .black, secondaryColor: .systemYellow, attack: 80, defense: 76, midfield: 78),
        Team(id: "mia", name: "Inter Mirada", shortName: "IMR", primaryColor: .systemPink, secondaryColor: .black, attack: 79, defense: 74, midfield: 77),
        Team(id: "nyc", name: "New York Metro FC", shortName: "NYM", primaryColor: .systemBlue, secondaryColor: .orange, attack: 77, defense: 75, midfield: 76),
        Team(id: "nyr", name: "New York Thunder", shortName: "NYT", primaryColor: .red, secondaryColor: .white, attack: 76, defense: 74, midfield: 75),
        Team(id: "atl", name: "Atlanta Union", shortName: "ATU", primaryColor: .red, secondaryColor: .black, attack: 77, defense: 73, midfield: 76),
        Team(id: "sea", name: "Seattle Strikers", shortName: "SST", primaryColor: .systemGreen, secondaryColor: .systemBlue, attack: 78, defense: 76, midfield: 77),
        Team(id: "cin", name: "FC Cincinova", shortName: "FCC", primaryColor: .systemBlue, secondaryColor: .orange, attack: 76, defense: 75, midfield: 75),
        Team(id: "phi", name: "Philadelphia Force", shortName: "PHF", primaryColor: .systemBlue, secondaryColor: .systemYellow, attack: 75, defense: 77, midfield: 74),
        Team(id: "col", name: "Colorado Riders", shortName: "CRD", primaryColor: .purple, secondaryColor: .systemBlue, attack: 73, defense: 72, midfield: 73),
        Team(id: "por", name: "Portland Pioneers", shortName: "PPN", primaryColor: .systemGreen, secondaryColor: .systemYellow, attack: 74, defense: 72, midfield: 74),
        Team(id: "aus", name: "Austin SC", shortName: "ASC", primaryColor: .systemGreen, secondaryColor: .black, attack: 75, defense: 73, midfield: 74)
    ]
}
