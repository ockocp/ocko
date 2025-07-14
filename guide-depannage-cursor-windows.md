# Guide de Dépannage Cursor sur Windows

## Problèmes Courants et Solutions

### 1. Cursor ne démarre pas / ne s'ouvre pas

**Symptômes :**
- L'icône ne fait que montrer un curseur de chargement brièvement
- Rien ne se passe au double-clic
- Erreur de registre dans les logs

**Solutions :**

#### Solution 1: Redémarrer avec privilèges administrateur
- Clic droit sur l'icône Cursor → "Exécuter en tant qu'administrateur"

#### Solution 2: Mettre à jour Windows
- Ouvrir Windows Update dans les paramètres
- Installer toutes les mises à jour disponibles
- Redémarrer l'ordinateur

#### Solution 3: Réinstaller complètement
1. Désinstaller Cursor depuis "Programmes et fonctionnalités"
2. Supprimer le dossier `%USERPROFILE%\AppData\Local\Programs\cursor\`
3. Télécharger la dernière version depuis https://www.cursor.com
4. Installer en tant qu'administrateur

#### Solution 4: Vérifier les permissions du registre
- Erreur fréquente : `Error: Command failed: %windir%\System32\REG.exe QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography /v MachineGuid`
- Solution : Exécuter `sfc /scannow` en tant qu'administrateur

### 2. Problèmes de connexion / login

**Symptômes :**
- Le bouton "Log in" ne fait rien
- Impossible de se connecter à son compte

**Solutions :**

#### Solution 1: Vérifier le navigateur par défaut
1. Définir Google Chrome comme navigateur par défaut
2. Redémarrer Cursor
3. Essayer de se connecter à nouveau

#### Solution 2: Processus de connexion manuel
1. Cliquer sur "Sign In" dans Cursor
2. Vérifier si un nouvel onglet s'ouvre dans votre navigateur
3. Se connecter dans le navigateur
4. Cliquer sur "Yes, log in" dans la page web
5. Retourner dans Cursor

### 3. Problèmes de terminal (PowerShell)

**Symptômes :**
- `Shell integration failed to activate`
- Commandes du terminal ne fonctionnent pas dans Composer/Chat
- Erreur avec argument `-l` dans PowerShell

**Solutions :**

#### Solution temporaire (jusqu'à la prochaine mise à jour) :
1. Naviguer vers `%USERPROFILE%\AppData\Local\Programs\cursor\resources\app\out\vs\platform\terminal\node\ptyHostMain.js`
2. Ouvrir avec un éditeur de texte
3. Remplacer `"-l","-noexit"` par `"-noexit"`
4. Faire de même dans `%USERPROFILE%\AppData\Local\Programs\cursor\resources\app\out\main.js`
5. Redémarrer Cursor

#### Configuration alternative du terminal :
```json
{
  "terminal.integrated.defaultProfile.windows": "PowerShell",
  "terminal.integrated.profiles.windows": {
    "PowerShell": {
      "path": "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
      "args": ["-NoExit"],
      "icon": "terminal-powershell"
    }
  }
}
```

### 4. Problèmes avec WSL (Windows Subsystem for Linux)

**Symptômes :**
- "WSL extension is supported only in Microsoft versions of VS code"
- Impossible de se connecter à WSL

**Solutions :**
1. Désinstaller l'extension WSL dans Cursor
2. Télécharger l'extension WSL depuis le marketplace Microsoft
3. Installer manuellement le fichier .vsix
4. Redémarrer Cursor
5. Sélectionner la distribution WSL à utiliser

### 5. Problèmes de commande `cursor .` dans Git Bash

**Symptôme :**
- Erreur : `No such file or directory` lors de l'exécution de `cursor .`

**Solution :**
1. Localiser le fichier : `C:\Users\<username>\AppData\Local\Programs\cursor\resources\app\bin\cursor`
2. Éditer le fichier avec un éditeur de texte
3. Changer la ligne `VSCODE_PATH="$(dirname "$0")/.."` par `VSCODE_PATH="$(dirname "$0")/../../.."`
4. Sauvegarder le fichier

### 6. Problèmes de mise à jour

**Symptômes :**
- Impossible de mettre à jour automatiquement
- Cursor devient inaccessible après tentative de mise à jour

**Solutions :**
1. Télécharger manuellement la dernière version depuis https://www.cursor.com
2. Désinstaller l'ancienne version
3. Installer la nouvelle version
4. Redémarrer l'ordinateur

### 7. Problèmes de téléchargement

**Symptômes :**
- "Unexpected error" lors du téléchargement
- Impossible d'accéder à la page de téléchargement

**Solutions :**
1. Désactiver temporairement le VPN
2. Vider le cache du navigateur
3. Essayer avec un navigateur différent
4. Vérifier les paramètres de proxy/firewall d'entreprise

### 8. Fonctionnalités AI ne marchent pas

**Symptômes :**
- Ctrl+K ne fonctionne pas
- Pas de réponse de l'IA
- Features AI désactivées

**Solutions :**
1. Vérifier la connexion internet
2. Désactiver temporairement les extensions
3. Redémarrer en mode "disable extensions"
4. Vérifier les paramètres de proxy/firewall
5. Désactiver HTTP/2 dans les paramètres Cursor

### Actions de dépannage générales

#### Réinitialisation complète :
1. Fermer complètement Cursor
2. Supprimer `%USERPROFILE%\AppData\Roaming\Cursor\`
3. Supprimer `%USERPROFILE%\AppData\Local\Programs\cursor\`
4. Redémarrer Windows
5. Réinstaller Cursor depuis le site officiel

#### Vérification des logs :
- Logs d'erreur disponibles dans : `%USERPROFILE%\AppData\Roaming\Cursor\logs\`
- Rechercher les fichiers de log récents pour identifier les erreurs spécifiques

#### Environnement d'entreprise :
- Vérifier avec l'IT si des restrictions de sécurité bloquent Cursor
- Demander l'ajout à la whitelist si nécessaire
- Configurer les paramètres de proxy si requis

### Ressources supplémentaires

- **Forum officiel :** https://forum.cursor.com
- **Documentation :** https://docs.cursor.com
- **Support :** Utiliser le forum plutôt que GitHub issues pour un support plus rapide

### Note importante

Ces solutions sont basées sur les problèmes les plus fréquemment rapportés par la communauté. Si aucune de ces solutions ne fonctionne, il est recommandé de poster sur le forum officiel de Cursor avec :
- Version exacte de Cursor
- Version de Windows
- Description détaillée du problème
- Logs d'erreur si disponibles