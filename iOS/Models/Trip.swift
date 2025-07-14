import Foundation
import CoreLocation

struct Trip: Identifiable, Codable {
    let id: String
    let userId: String
    let startLocation: Location
    let endLocation: Location
    let startTime: Date
    let endTime: Date?
    let distance: Double // en mètres
    let duration: TimeInterval // en secondes
    let category: TripCategory
    let professionalCategory: ProfessionalCategory?
    let vehicleId: String?
    let passengers: Int
    let emissions: Double // en gCO₂
    let status: TripStatus
    let createdAt: Date
    let updatedAt: Date
    
    enum TripCategory: String, CaseIterable, Codable {
        case personal = "personal"
        case professional = "professional"
        
        var displayName: String {
            switch self {
            case .personal: return "Personnel"
            case .professional: return "Professionnel"
            }
        }
    }
    
    enum ProfessionalCategory: String, CaseIterable, Codable {
        case meeting = "meeting"
        case delivery = "delivery"
        case inspection = "inspection"
        case training = "training"
        case other = "other"
        
        var displayName: String {
            switch self {
            case .meeting: return "Réunion"
            case .delivery: return "Livraison"
            case .inspection: return "Inspection"
            case .training: return "Formation"
            case .other: return "Autre"
            }
        }
    }
    
    enum TripStatus: String, Codable {
        case active = "active"
        case completed = "completed"
        case cancelled = "cancelled"
    }
    
    init(userId: String, startLocation: Location, startTime: Date = Date()) {
        self.id = UUID().uuidString
        self.userId = userId
        self.startLocation = startLocation
        self.endLocation = startLocation // Sera mis à jour
        self.startTime = startTime
        self.endTime = nil
        self.distance = 0
        self.duration = 0
        self.category = .personal
        self.professionalCategory = nil
        self.vehicleId = nil
        self.passengers = 0
        self.emissions = 0
        self.status = .active
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
    let address: String?
    let timestamp: Date
    
    init(coordinate: CLLocationCoordinate2D, address: String? = nil) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.address = address
        self.timestamp = Date()
    }
} 