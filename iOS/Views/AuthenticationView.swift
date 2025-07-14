import SwiftUI
import Firebase
import GoogleSignIn
import AuthenticationServices

struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
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
                
                // Boutons d'authentification
                VStack(spacing: 16) {
                    // Calcul rapide sans inscription
                    Button("Calculer mes émissions (sans compte)") {
                        viewModel.showQuickCalculator = true
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    
                    Divider()
                        .padding(.vertical)
                    
                    // Authentification Apple
                    SignInWithAppleButton(
                        onRequest: { request in
                            request.requestedScopes = [.fullName, .email]
                        },
                        onCompletion: { result in
                            viewModel.handleAppleSignIn(result)
                        }
                    )
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 50)
                    
                    // Authentification Google
                    Button(action: viewModel.signInWithGoogle) {
                        HStack {
                            Image("google_logo")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Continuer avec Google")
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                    
                    // Authentification Facebook
                    Button(action: viewModel.signInWithFacebook) {
                        HStack {
                            Image("facebook_logo")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Continuer avec Facebook")
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 32)
                
                Spacer()
                
                // Conditions d'utilisation
                Text("En continuant, vous acceptez nos conditions d'utilisation")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.showQuickCalculator) {
            QuickCalculatorView()
        }
        .alert("Erreur d'authentification", isPresented: $viewModel.showError) {
            Button("OK") { }
        } message: {
            Text(viewModel.errorMessage)
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