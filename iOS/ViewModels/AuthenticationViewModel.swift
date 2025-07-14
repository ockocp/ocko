import Foundation
import Firebase
import GoogleSignIn
import AuthenticationServices
import Combine

class AuthenticationViewModel: ObservableObject {
    @Published var showQuickCalculator = false
    @Published var showError = false
    @Published var errorMessage = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    func handleAppleSignIn(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                showError(message: "Erreur lors de l'authentification Apple")
                return
            }
            
            guard let nonce = currentNonce else {
                showError(message: "Erreur de sécurité")
                return
            }
            
            guard let appleIDToken = appleIDCredential.identityToken else {
                showError(message: "Impossible de récupérer le token Apple")
                return
            }
            
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                showError(message: "Erreur de format du token")
                return
            }
            
            let credential = OAuthProvider.credential(
                withProviderID: "apple.com",
                idToken: idTokenString,
                rawNonce: nonce
            )
            
            signInWithFirebase(credential: credential)
            
        case .failure(let error):
            showError(message: error.localizedDescription)
        }
    }
    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            showError(message: "Configuration Firebase manquante")
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            showError(message: "Impossible d'accéder à la vue")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            if let error = error {
                self?.showError(message: error.localizedDescription)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                self?.showError(message: "Impossible de récupérer les informations Google")
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )
            
            self?.signInWithFirebase(credential: credential)
        }
    }
    
    func signInWithFacebook() {
        // Implémentation Facebook Login
        // Nécessite l'ajout du SDK Facebook
    }
    
    private func signInWithFirebase(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { [weak self] result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.showError(message: error.localizedDescription)
                }
                // L'état d'authentification sera mis à jour automatiquement via AppState
            }
        }
    }
    
    private func showError(message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
            self.showError = true
        }
    }
    
    // Pour Apple Sign In
    private var currentNonce: String?
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
} 