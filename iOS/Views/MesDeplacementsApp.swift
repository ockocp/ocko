import SwiftUI
import Firebase
import CoreData

@main
struct MesDeplacementsApp: App {
    @StateObject private var appState = AppState()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
} 