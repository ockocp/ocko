import Foundation

struct EmissionsCalculator {
    /// Calcule les émissions de CO₂ pour un trajet donné
    /// - Parameters:
    ///   - distance: Distance en mètres
    ///   - co2PerKm: Émissions du véhicule en gCO₂/km (case v7)
    ///   - passengers: Nombre total de personnes dans le véhicule (conducteur inclus)
    static func calculateEmissions(distance: Double, co2PerKm: Double, passengers: Int = 1) -> Double {
        guard distance > 0, co2PerKm > 0, passengers > 0 else { return 0 }
        let emissions = (distance / 1000) * co2PerKm
        return emissions / Double(passengers)
    }
} 