import SwiftUI
import MapKit

struct TripTrackingView: View {
    @StateObject private var viewModel = TripTrackingViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            ZStack {
                // Carte en arrière-plan
                MapView(
                    region: $viewModel.mapRegion,
                    tripPoints: viewModel.tripPoints,
                    isTracking: viewModel.isTracking
                )
                .ignoresSafeArea()
                
                VStack {
                    // En-tête avec statut
                    TripStatusHeader(
                        isTracking: viewModel.isTracking,
                        currentTrip: viewModel.currentTrip
                    )
                    
                    Spacer()
                    
                    // Contrôles de suivi
                    if viewModel.isTracking {
                        TripControlsView(
                            onStop: viewModel.stopTracking,
                            onPause: viewModel.pauseTracking
                        )
                    } else {
                        StartTrackingButton(onStart: viewModel.startTracking)
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $viewModel.showTripCompletion) {
            TripCompletionView(trip: viewModel.currentTrip!) { completedTrip in
                viewModel.saveTrip(completedTrip)
            }
        }
        .alert("Permission de localisation", isPresented: $viewModel.showLocationAlert) {
            Button("Paramètres") {
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
            Button("Annuler", role: .cancel) { }
        } message: {
            Text("L'application a besoin de votre localisation pour suivre vos trajets.")
        }
    }
}

struct TripStatusHeader: View {
    let isTracking: Bool
    let currentTrip: Trip?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(isTracking ? "Trajet en cours" : "Prêt à suivre")
                    .font(.headline)
                    .foregroundColor(isTracking ? .green : .primary)
                
                if let trip = currentTrip {
                    Text("Débuté à \(trip.startTime, style: .time)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            if isTracking {
                // Indicateur de suivi animé
                Circle()
                    .fill(Color.green)
                    .frame(width: 12, height: 12)
                    .scaleEffect(1.2)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isTracking)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
}

struct TripControlsView: View {
    let onStop: () -> Void
    let onPause: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: onPause) {
                VStack {
                    Image(systemName: "pause.circle.fill")
                        .font(.system(size: 40))
                    Text("Pause")
                        .font(.caption)
                }
                .foregroundColor(.orange)
            }
            
            Button(action: onStop) {
                VStack {
                    Image(systemName: "stop.circle.fill")
                        .font(.system(size: 40))
                    Text("Arrêter")
                        .font(.caption)
                }
                .foregroundColor(.red)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
}

struct StartTrackingButton: View {
    let onStart: () -> Void
    
    var body: some View {
        Button(action: onStart) {
            VStack(spacing: 8) {
                Image(systemName: "location.circle.fill")
                    .font(.system(size: 50))
                Text("Commencer le suivi")
                    .font(.headline)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(Color.green)
            .cornerRadius(12)
        }
    }
} 