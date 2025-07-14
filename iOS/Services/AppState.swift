import Foundation
import Combine
import FirebaseAuth

class AppState: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var isTrackingTrip = false
    @Published var currentTrip: Trip?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupAuthenticationState()
    }
    
    private func setupAuthenticationState() {
        // Écouter les changements d'authentification Firebase
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.isAuthenticated = user != nil
                if let user = user {
                    self?.currentUser = User(firebaseUser: user)
                }
            }
        }
    }
} 