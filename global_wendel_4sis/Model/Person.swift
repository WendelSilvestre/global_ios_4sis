import Foundation

class Person {

    var name: String
    var height: Double
    var bodyTemperature: Double
    var measures: [String]

    init(name: String, height: Double, bodyTemperature: Double, measures: [String] = []) {
        self.name = name
        self.height = height
        self.bodyTemperature = bodyTemperature
        self.measures = measures
    }

    func idealClothTemperature(forAmbient ambient: Double) -> Double {
        let comfortBase = 30.0
        let neutralAmbient = 22.0
        let referenceBody = 36.5
        return comfortBase
            + (neutralAmbient - ambient) * 0.3
            + (referenceBody - bodyTemperature) * 0.5
    }

    func recommendedMode(forAmbient ambient: Double) -> ThermalMode {
        switch ambient {
        case ..<15:    return .hot
        case 15..<23:  return .warm
        case 23...:    return .cold
        default:       return .basic
        }
    }
}
