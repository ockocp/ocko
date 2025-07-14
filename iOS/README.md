# MesDéplacements - Application iOS

Application native iOS pour le suivi des déplacements et le calcul des émissions de CO₂.

## 🏗️ Structure du projet

```
iOS/
├── MesDeplacements.xcodeproj/     # Projet Xcode principal
│   ├── Models/                    # Modèles de données
│   │   ├── User.swift
│   │   ├── Trip.swift
│   │   └── Vehicle.swift
│   ├── Views/                     # Vues SwiftUI
│   │   ├── ContentView.swift
│   │   ├── AuthenticationView.swift
│   │   └── TripTrackingView.swift
│   ├── ViewModels/                # ViewModels MVVM
│   │   ├── AuthenticationViewModel.swift
│   │   └── TripTrackingViewModel.swift
│   ├── Services/                  # Services et gestionnaires
│   │   ├── AppState.swift
│   │   ├── LocationManager.swift
│   │   └── PersistenceController.swift
│   ├── Utils/                     # Utilitaires
│   │   ├── EmissionsCalculator.swift
│   │   └── ShareHelper.swift
│   ├── Resources/                 # Ressources
│   │   ├── Assets.xcassets/
│   │   └── GoogleService-Info.plist
│   ├── MesDeplacementsApp.swift   # Point d'entrée
│   └── Info.plist                 # Configuration
├── Package.swift                  # Dépendances Swift
├── README.md                      # Documentation
└── open_project.sh               # Script d'ouverture
```

## 🚀 Fonctionnalités

### ✅ Implémentées
- [x] Architecture MVVM avec SwiftUI
- [x] Authentification Firebase (Google, Apple, Facebook)
- [x] Suivi GPS des trajets
- [x] Modèles de données (User, Trip, Vehicle)
- [x] Interface utilisateur de base
- [x] Gestion de l'état de l'application

### 🔄 En cours de développement
- [ ] Calcul automatique des émissions CO₂
- [ ] Gestion du parc véhicule
- [ ] Dashboard interactif
- [ ] Export PDF
- [ ] Partage sur réseaux sociaux
- [ ] Interface web employeur

## 📱 Configuration requise

- **iOS 17.0+**
- **Xcode 15.0+**
- **Swift 5.9+**

## 🔧 Installation

1. **Ouvrir le projet**
   ```bash
   cd "emissions GES/iOS"
   open MesDeplacements.xcodeproj
   ```

2. **Configurer Firebase**
   - Créer un projet Firebase
   - Télécharger `GoogleService-Info.plist`
   - Remplacer le fichier dans `MesDeplacements.xcodeproj/Resources/`

3. **Installer les dépendances**
   - Dans Xcode, aller dans Project Settings > Package Dependencies
   - Ajouter les packages Swift :
     - Firebase iOS SDK
     - GoogleSignIn
     - FacebookLogin

4. **Compiler et exécuter**
   ```bash
   # Dans Xcode : Cmd+R
   ```

## 🛠️ Configuration Firebase

1. Aller sur [Firebase Console](https://console.firebase.google.com/)
2. Créer un nouveau projet
3. Ajouter une application iOS
4. Télécharger `GoogleService-Info.plist`
5. Remplacer le fichier dans `MesDeplacements.xcodeproj/Resources/`

## 📊 Architecture

### MVVM (Model-View-ViewModel)
- **Models** : Données et logique métier
- **Views** : Interface utilisateur SwiftUI
- **ViewModels** : Logique de présentation et état

### Services
- **AppState** : État global de l'application
- **LocationManager** : Gestion de la localisation GPS
- **PersistenceController** : Base de données Core Data

## 🔐 Authentification

L'application supporte :
- **Google Sign-In**
- **Apple Sign-In**
- **Facebook Login**
- **Email/Password** (optionnel)

## 📍 Suivi des trajets

- **Détection automatique** des déplacements
- **GPS en arrière-plan** pour économiser la batterie
- **Catégorisation** : Personnel/Professionnel
- **Calcul des émissions** basé sur le véhicule

## 🚗 Gestion des véhicules

- **Ajout de véhicules** avec photos
- **Case v7** de la carte grise (gCO₂/km)
- **Types d'énergie** : Essence, Diesel, Électrique, etc.
- **Véhicule par défaut** pour les calculs

## 📈 Dashboard

- **Vue d'ensemble** des trajets
- **Filtres** : Quotidien, Hebdomadaire, Mensuel
- **Graphiques** des émissions
- **Export PDF** des rapports

## 🎨 Design

L'application respecte les **Human Interface Guidelines** d'Apple :
- **Couleurs** : Vert pour l'écologie
- **Typographie** : SF Pro
- **Icônes** : SF Symbols
- **Animations** : Fluides et naturelles

## 🔧 Développement

### Ajouter une nouvelle vue
1. Créer le fichier dans `MesDeplacements.xcodeproj/Views/`
2. Créer le ViewModel correspondant dans `MesDeplacements.xcodeproj/ViewModels/`
3. Ajouter la navigation dans `ContentView.swift`

### Ajouter un nouveau modèle
1. Créer le fichier dans `MesDeplacements.xcodeproj/Models/`
2. Implémenter `Identifiable` et `Codable`
3. Ajouter les propriétés nécessaires

### Ajouter un service
1. Créer le fichier dans `MesDeplacements.xcodeproj/Services/`
2. Implémenter la logique métier
3. Injecter dans les ViewModels

## 📱 Test

```bash
# Tests unitaires
xcodebuild test -scheme MesDeplacements -destination 'platform=iOS Simulator,name=iPhone 15'

# Tests UI
xcodebuild test -scheme MesDeplacements -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:MesDeplacementsUITests
```

## 🚀 Déploiement

### App Store
1. **Archive** le projet dans Xcode
2. **Upload** vers App Store Connect
3. **Soumettre** pour review

### TestFlight
1. **Archive** le projet
2. **Upload** vers TestFlight
3. **Inviter** les testeurs

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 🤝 Contribution

1. **Fork** le projet
2. **Créer** une branche feature
3. **Commit** les changements
4. **Push** vers la branche
5. **Créer** une Pull Request

## 📞 Support

Pour toute question ou problème :
- 📧 Email : support@mesdeplacements.com
- 🐛 Issues : GitHub Issues
- 📖 Documentation : Wiki du projet

---

**Développé avec ❤️ en Swift et SwiftUI** 