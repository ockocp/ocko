# Emissions GES - Backend PHP

Ce projet utilise Composer pour gérer les dépendances PHP.

## Installation

1. **Installer Composer** (si pas déjà installé) :
   ```bash
   curl -sS https://getcomposer.org/installer | php
   sudo mv composer.phar /usr/local/bin/composer
   ```

2. **Installer les dépendances** :
   ```bash
   composer install
   ```

3. **Installer les dépendances de développement** :
   ```bash
   composer install --dev
   ```

## Structure du projet

```
├── src/           # Code source de l'application
├── tests/         # Tests unitaires
├── vendor/        # Dépendances installées par Composer
├── composer.json  # Configuration des dépendances
└── .gitignore     # Fichiers à ignorer par Git
```

## Commandes utiles

- **Ajouter une dépendance** :
  ```bash
  composer require nom-du-package
  ```

- **Ajouter une dépendance de développement** :
  ```bash
  composer require --dev nom-du-package
  ```

- **Mettre à jour les dépendances** :
  ```bash
  composer update
  ```

- **Lancer les tests** :
  ```bash
  composer test
  ```

- **Générer l'autoloader** :
  ```bash
  composer dump-autoload
  ```

## Configuration

Le fichier `composer.json` configure :
- Les dépendances requises (`require`)
- Les dépendances de développement (`require-dev`)
- L'autoloading PSR-4 (`autoload`)
- Les scripts personnalisés (`scripts`) 