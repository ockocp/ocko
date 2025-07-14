import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var currentLocation: CLLocation?
    @Published var isTracking = false
    @Published var tripPoints: [CLLocation] = []
    
    private var tripStartTime: Date?
    private var tripStartLocation: CLLocation?
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10 // 10 mètres
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startTracking() {
        guard authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways else {
            requestLocationPermission()
            return
        }
        
        isTracking = true
        tripStartTime = Date()
        tripPoints.removeAll()
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() -> Trip? {
        guard isTracking, let startTime = tripStartTime, let startLocation = tripStartLocation else {
            return nil
        }
        
        locationManager.stopUpdatingLocation()
        isTracking = false
        
        let endTime = Date()
        let totalDistance = calculateTotalDistance()
        let duration = endTime.timeIntervalSince(startTime)
        
        let trip = Trip(
            userId: "", // Sera défini par le ViewModel
            startLocation: Location(coordinate: startLocation.coordinate),
            startTime: startTime
        )
        
        // Réinitialiser
        tripStartTime = nil
        tripStartLocation = nil
        tripPoints.removeAll()
        
        return trip
    }
    
    private func calculateTotalDistance() -> Double {
        guard tripPoints.count > 1 else { return 0 }
        
        var totalDistance: Double = 0
        for i in 1..<tripPoints.count {
            totalDistance += tripPoints[i].distance(from: tripPoints[i-1])
        }
        
        return totalDistance
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        currentLocation = location
        
        if isTracking {
            if tripStartLocation == nil {
                tripStartLocation = location
            }
            tripPoints.append(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        DispatchQueue.main.async {
            self.authorizationStatus = status
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
} 