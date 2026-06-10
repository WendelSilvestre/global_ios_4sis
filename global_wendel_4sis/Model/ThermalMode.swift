import Foundation

enum ThermalMode: String, CaseIterable {
    case cold
    case warm
    case hot
    case basic

    init(texto: String) {
        self = ThermalMode(rawValue: texto.lowercased()) ?? .basic
    }

    var descricao: String {
        switch self {
        case .cold:  return "Resfriamento"
        case .warm:  return "Ameno"
        case .hot:   return "Aquecimento"
        case .basic: return "Básico"
        }
    }
}
