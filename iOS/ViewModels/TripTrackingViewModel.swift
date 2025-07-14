import Foundation
import CoreLocation
import Combine

class TripTrackingViewModel: ObservableObject {
    @Published var isTracking = false
    @Published var currentTrip: Trip?
    @Published var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522), // Paris
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @Published var tripPoints: [CLLocation] = []
    @Published var showTripCompletion = false
    @Published var showLocationAlert = false
    
    private let locationManager = LocationManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        locationManager.$isTracking
            .assign(to: \.isTracking, on: self)
            .store(in: &cancellables)
        
        locationManager.$tripPoints
            .assign(to: \.tripPoints, on: self)
            .store(in: &cancellables)
        
        locationManager.$authorizationStatus
            .sink { [weak self] status in
                if status == .denied || status == .restricted {
                    self?.showLocationAlert = true
                }
            }
            .store(in: &cancellables)
    }
    
    func startTracking() {
        locationManager.startTracking()
        currentTrip = Trip(userId: "", startLocation: Location(coordinate: locationManager.currentLocation?.coordinate ?? CLLocationCoordinate2D()))
    }
    
    func stopTracking() {
        guard let trip = locationManager.stopTracking() else { return }
        
        // Mettre à jour les informations du trajet
        var updatedTrip = trip
        updatedTrip.endTime = Date()
        updatedTrip.distance = calculateDistance()
        updatedTrip.duration = trip.endTime?.timeIntervalSince(trip.startTime) ?? 0
        
        currentTrip = updatedTrip
        showTripCompletion = true
    }
    
    func pauseTracking() {
        // Implémenter la pause
    }
    
    func saveTrip(_ trip: Trip) {
        // Sauvegarder le trajet dans Core Data
        // TripRepository.shared.saveTrip(trip)
        
        // Réinitialiser
        currentTrip = nil
        showTripCompletion = false
    }
    
    private func calculateDistance() -> Double {
        guard tripPoints.count > 1 else { return 0 }
        
        var totalDistance: Double = 0
        for i in 1..<tripPoints.count {
            totalDistance += tripPoints[i].distance(from: tripPoints[i-1])
        }
        
        return totalDistance
    }
} 