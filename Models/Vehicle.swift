import Foundation

struct Vehicle: Identifiable, Codable {
    let id: String
    let userId: String
    let brand: String
    let model: String
    let version: String?
    let fuelType: FuelType
    let consumption: Double // L/100km
    let co2Emissions: Double // gCO₂/km (case v7)
    let photoURL: URL?
    let licensePlate: String?
    let isDefault: Bool
    let createdAt: Date
    let updatedAt: Date
    
    enum FuelType: String, CaseIterable, Codable {
        case gasoline = "gasoline"
        case diesel = "diesel"
        case electric = "electric"
        case hybrid = "hybrid"
        case lpg = "lpg"
        case cng = "cng"
        
        var displayName: String {
            switch self {
            case .gasoline: return "Essence"
            case .diesel: return "Diesel"
            case .electric: return "Électrique"
            case .hybrid: return "Hybride"
            case .lpg: return "GPL"
            case .cng: return "GNV"
            }
        }
    }
    
    init(userId: String, brand: String, model: String, version: String? = nil, fuelType: FuelType, consumption: Double, co2Emissions: Double, photoURL: URL? = nil, licensePlate: String? = nil, isDefault: Bool = false) {
        self.id = UUID().uuidString
        self.userId = userId
        self.brand = brand
        self.model = model
        self.version = version
        self.fuelType = fuelType
        self.consumption = consumption
        self.co2Emissions = co2Emissions
        self.photoURL = photoURL
        self.licensePlate = licensePlate
        self.isDefault = isDefault
        self.createdAt = Date()
        self.updatedAt = Date()
    }
} 