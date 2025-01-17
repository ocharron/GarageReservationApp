# Garage Reservation App - Prise de Rendez-vous pour Services Automobiles

[![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/ocharron/GarageReservationApp/blob/main/README.md)
[![fr](https://img.shields.io/badge/lang-fr-blue.svg)](https://github.com/ocharron/GarageReservationApp/blob/main/README_fr.md)

Garage Reservation App est une application fictive conçue pour simplifier la réservation de services automobiles dans votre garage local. Grâce à cette application, les clients peuvent facilement planifier des rendez-vous en fonction des disponibilités des mécaniciens.

---

## Technologies Utilisées

- **Framework** : Flutter
- **Base de données** : SQLite (sqflite)
- **Gestion d'état** : Provider

---

## Installation

Pour installer et exécuter Garage Reservation App sur votre machine locale, veuillez suivre ces étapes :

### Prérequis

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) ou [Visual Studio Code](https://code.visualstudio.com/)
- Un émulateur ou un appareil physique pour exécuter l'application

### Instructions

1. **Cloner le dépôt**
   ```bash
   git clone https://github.com/ocharron/GarageReservationApp.git
   ```

2. **Installer les dépendances**
    - Naviguez vers le répertoire du projet et exécutez la commande suivante pour installer les dépendances :
    ```bash
    flutter pub get
    ```

3. Configurer la base de données
    - L'application utilise SQLite pour le stockage local, géré via le package sqflite.
    - La base de données sera créée automatiquement lors du premier démarrage. Aucune configuration manuelle n'est nécessaire.

4. **Exécuter l'application**
   - Pour exécuter l'application, utilisez la commande suivante :
     ```bash
     flutter run
     ```
   - Vous pouvez également exécuter l'application sur un appareil connecté ou un émulateur.

---

##  Fonctionnalités Clés

1. **Gestion des disponibilités** : Les mécaniciens peuvent entrer leurs horaires de disponibilité pour les rendez-vous, garantissant que les clients ne puissent réserver que pendant ces créneaux horaires.
2. **Prise de rendez-vous** : Les clients peuvent consulter les disponibilités des mécaniciens et réserver des rendez-vous en fonction de leurs créneaux horaires préférés.
3. **Authentification avec Auth0** : Authentification sécurisée des utilisateurs via Auth0 pour gérer les sessions et profils des utilisateurs.
4. **Mode sombre** : L'application offre un mode sombre pour une expérience de visionnage confortable dans des environnements à faible éclairage.

---

## Auteur

Ce projet a été développé par [Olivier Charron](https://github.com/ocharron)