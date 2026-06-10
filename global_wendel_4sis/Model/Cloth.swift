import Foundation

class Cloth {

    var name: String
    var clothTemperature: Double
    var mode: ThermalMode
    var adaptiveMeasures: [String]

    init(name: String, clothTemperature: Double, mode: ThermalMode, adaptiveMeasures: [String] = []) {
        self.name = name
        self.clothTemperature = clothTemperature
        self.mode = mode
        self.adaptiveMeasures = adaptiveMeasures
    }

    convenience init(name: String, clothTemperature: Double, modeTexto: String, adaptiveMeasures: [String] = []) {
        self.init(name: name,
                  clothTemperature: clothTemperature,
                  mode: ThermalMode(texto: modeTexto),
                  adaptiveMeasures: adaptiveMeasures)
    }

    func isSuitable(forIdeal ideal: Double, tolerance: Double = 2.0) -> Bool {
        return abs(clothTemperature - ideal) <= tolerance
    }
}
