#!/bin/bash

# Script pour ouvrir le projet MesDéplacements dans Xcode

echo "🚀 Ouverture du projet MesDéplacements dans Xcode..."

# Vérifier si Xcode est installé
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode n'est pas installé ou n'est pas dans le PATH"
    echo "📥 Téléchargez Xcode depuis l'App Store"
    exit 1
fi

# Vérifier si le projet existe
if [ ! -f "MesDeplacements.xcodeproj/project.pbxproj" ]; then
    echo "❌ Le projet Xcode n'existe pas"
    echo "📁 Création du projet Xcode..."
    
    # Créer le projet Xcode
    xcodebuild -project MesDeplacements.xcodeproj -list 2>/dev/null || {
        echo "🔧 Création du projet Xcode..."
        # Ici on pourrait créer le projet programmatiquement
        echo "⚠️  Veuillez créer le projet manuellement dans Xcode"
        echo "📂 Ouvrez Xcode et créez un nouveau projet iOS"
        echo "📂 Nommez-le 'MesDeplacements'"
        echo "📂 Sélectionnez 'SwiftUI' comme interface"
        echo "📂 Choisissez 'Core Data' pour la persistance"
    }
fi

# Ouvrir le projet dans Xcode
echo "📱 Ouverture dans Xcode..."
open MesDeplacements.xcodeproj

echo "✅ Projet ouvert dans Xcode !"
echo ""
echo "📋 Prochaines étapes :"
echo "1. 🔧 Configurer Firebase dans Xcode"
echo "2. 📦 Ajouter les dépendances Swift Package Manager"
echo "3. 🏗️  Compiler le projet (Cmd+R)"
echo "4. 🧪 Tester sur le simulateur"
echo ""
echo "📖 Consultez le README.md pour plus d'informations" 