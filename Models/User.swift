import Foundation
import FirebaseAuth

struct User: Identifiable {
    let id: String
    let email: String
    let displayName: String?
    let photoURL: URL?

    init(firebaseUser: FirebaseAuth.User) {
        self.id = firebaseUser.uid
        self.email = firebaseUser.email ?? ""
        self.displayName = firebaseUser.displayName
        self.photoURL = firebaseUser.photoURL
    }
} 