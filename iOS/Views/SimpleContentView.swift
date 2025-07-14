import SwiftUI

struct SimpleContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            if appState.isAuthenticated {
                SimpleMainTabView()
            } else {
                SimpleAuthView()
            }
        }
    }
}

struct SimpleMainTabView: View {
    var body: some View {
        TabView {
            SimpleTripTrackingView()
                .tabItem {
                    Image(systemName: "location.fill")
                    Text("Suivi")
                }
            
            SimpleDashboardView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Tableau de bord")
                }
            
            SimpleVehicleView()
                .tabItem {
                    Image(systemName: "car.fill")
                    Text("Véhicules")
                }
            
            SimpleProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profil")
                }
        }
    }
}

struct SimpleAuthView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 30) {
            // Logo et titre
            VStack(spacing: 16) {
                Image(systemName: "location.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.green)
                
                Text("MesDéplacements")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Suivez vos trajets, calculez vos émissions")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            // Bouton de connexion simplifié pour les tests
            Button("Se connecter (Mode Test)") {
                appState.isAuthenticated = true
                appState.currentUser = User(
                    id: "test-user",
                    email: "test@example.com",
                    displayName: "Utilisateur Test",
                    photoURL: nil
                )
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.horizontal, 32)
            
            Spacer()
        }
        .padding()
    }
}

struct SimpleTripTrackingView: View {
    @StateObject private var viewModel = TripTrackingViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // En-tête avec statut
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.isTracking ? "Trajet en cours" : "Prêt à suivre")
                                .font(.headline)
                                .foregroundColor(viewModel.isTracking ? .green : .primary)
                            
                            if let trip = viewModel.currentTrip {
                                Text("Débuté à \(trip.startTime, style: .time)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Spacer()
                        
                        if viewModel.isTracking {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 12, height: 12)
                                .scaleEffect(1.2)
                                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: viewModel.isTracking)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                }
                
                Spacer()
                
                // Contrôles de suivi
                if viewModel.isTracking {
                    HStack(spacing: 20) {
                        Button("Pause") {
                            viewModel.pauseTracking()
                        }
                        .foregroundColor(.orange)
                        
                        Button("Arrêter") {
                            viewModel.stopTracking()
                        }
                        .foregroundColor(.red)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                } else {
                    Button("Commencer le suivi") {
                        viewModel.startTracking()
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
            }
            .padding()
            .navigationTitle("Suivi des trajets")
        }
    }
}

struct SimpleDashboardView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "chart.bar.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                
                Text("Tableau de bord")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Fonctionnalité en cours de développement")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Trajets aujourd'hui:")
                        Spacer()
                        Text("0")
                            .fontWeight(.bold)
                    }
                    
                    HStack {
                        Text("Émissions CO₂:")
                        Spacer()
                        Text("0 g")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    
                    HStack {
                        Text("Distance totale:")
                        Spacer()
                        Text("0 km")
                            .fontWeight(.bold)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
            .navigationTitle("Tableau de bord")
        }
    }
}

struct SimpleVehicleView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "car.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Gestion des véhicules")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Fonctionnalité en cours de développement")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Button("Ajouter un véhicule") {
                    // Action à implémenter
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding()
            .navigationTitle("Véhicules")
        }
    }
}

struct SimpleProfileView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("Profil utilisateur")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                if let user = appState.currentUser {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Email:")
                            Spacer()
                            Text(user.email)
                                .fontWeight(.medium)
                        }
                        
                        if let name = user.displayName {
                            HStack {
                                Text("Nom:")
                                Spacer()
                                Text(name)
                                    .fontWeight(.medium)
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                }
                
                Button("Se déconnecter") {
                    appState.isAuthenticated = false
                    appState.currentUser = nil
                }
                .foregroundColor(.red)
                .padding()
            }
            .padding()
            .navigationTitle("Profil")
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
} 