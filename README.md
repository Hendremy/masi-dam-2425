# Greenmon

> Vous vous adressez potentiellement à un futur employeur et donc une personne qui n'aura pas nécessairement l'occasion de compiler votre projet. Votre `README.md` contiendra donc au moins :

## 📁 Présentation des Principaux Dossiers

> Une présentation des principaux dossiers de votre dépôt. Quelles sont les différentes ressources qu'il contient à la racine ? Par exemple, les maquettes, vos inspirations, etc. Si vous avez fait des efforts quant à l'organisation de vos fichiers dans le dossier `lib`, expliquez-les ici.

À la racine du repository, nous trouvons le dossier masi_dam_2425 contenant le projet Flutter, dont voici la découpe :
- android / : contient les fichier nécessaire à l'exécution de l'application Flutter sur un appareil Android, cela inclut notamment le manifeste android qui définit l'application android et les permissions nécessaires
- assets / : contient les images utilisées dans notre application, cela inclut principalement les icones des items et des personnages.
- lib / : contient le code source Dart qui constitue l'application
    
    Chaque répertoire représente une fonctionnalité principale de notre application et contient donc les classes nécessaires à son fonctionnement. Dans chacun, nous retrouverons principalement 3 types de sous-dossiers:
    - view : pages principales
    - widgets : modules réutilisables de vue
    - bloc/cubit : contient les classes d'état, d'évènements et de blocs/cubits faisant partie de l'architecture de gestion d'états BLoC

    On retrouve ici plusieurs répertoires ne représentant pas des fonctionnalités mais dont les fonctionnalités dépendent :
    - api : contient les classes d'accès aux serveurs de Firebase et aux APIs externes telles que Plant .NET
    - env : accès aux variables d'environnement telles que les clés pour les services mentionnés ci-haut
    - model : structures de données principales (plantes, profil, ...)
    - helper : classes utilitaires

    Voici les répertoires de fonctionnalités que vous pourrez retrouver :
    - app : représente le point de départ de l'application
    - common : représente les widgets utilisables partout
    - home : l'écran d'accueil d'un utilisateur authentifié
    - inventory : affiche l'équipement acquis par l'utilisateur
    - login : page d'authentification pour accéder au reste de l'application
    - network : vérifie l'état de la connexion internet et affiche un message d'erreur quand la connexion aux services est perdue
    - plants : catalogue des plantes enregistrées par l'utilisateur
    - profile : page de profil de l'utilisateur où il peut consulter et modifier ses informations
    - shop : magasin de l'application où il peut acheter différents artéfacts
    - sign-up : page d'inscription où l'utilisateur peut se créer un nouveau compte
    
- packages / : code source d'utilité générale pouvant être aisément réutilisé dans d'autres applications que celle-ci, comme pour l'authentification ou la mise en cache 

## 🚀 Présentation de l'Application

Greenmon est une application mobile gamifiée dédiée à la gestion des plantes d'intérieur.

Les plantes d'intérieur offrent de nombreux avantages, tels que l'amélioration de la qualité de l'air, une sensation de bien-être accru, la réduction du stress, et le développement d'une relation symbiotique avec leur propriétaire. Cependant, certaines de ces plantes nécessitent une attention régulière, notamment en ce qui concerne l'arrosage, la luminosité, le type de sol et le niveau d'humidité.

La solution proposée par Greenmon est une application qui permet d'identifier ses plantes grâce à une simple photo, de recevoir des notifications pour leur entretien, et d'obtenir des conseils adaptés pour en prendre soin. Le tout est conçu avec un aspect ludique et gamifié, afin de rendre l'apprentissage et l'entretien des plantes agréable et motivant pour l'utilisateur.

## 🌐 Étude de l'Existant

1. PlantNet - Permet d'identifier des plantes en prenant un photo
2. Planta - Application dont le but est de garder les plantes des utilisateurs en vie

Ces deux applications regroupent les idées de notre application. Le point qui distingue notre application du reste de l'existant est la gamification.

Une application qui nous a aidé dans la gamification est "Habitica: Gamify your Tasks". Dont le but est de traiter notre vie comme un jeux pour gagner en motivation et organisation. L'idée de la gamification provient principalement de l'utilisation de 
cette application par l'un de nos développeurs. 
## 🎯 Public Cible

Le public cible est par exemple : 

- Les amateurs de plantes débutants à la recherche de conseils
- Les passionnés de plantes voulant une expérience différentes via la gamification

Plus généralement, Greenmon s’adresse surtout aux personnes qui veulent simplifier et enrichir leur gestion de plantes, que ce soit par curiosité ou par recherche d’une expérience agréable et engageante.

## 📋 Fonctionnalités

- En tant que nouvel utilisateur, je veux pouvoir me créer un compte afin de faire partie de la communauté Greenmon.
- En tant que nouvel utilisateur, je veux pouvoir me connecter à l'application via mon compte afin d'accéder à l'application.

- En tant qu'utilisateur déjà authentifié une première fois, je ne veux pas avoir à encoder systématiquement mon login/password lorsque j'ouvre l'application. Ceci afin d'améliorer mon expérience utilisateur.
- Ent tant qu'utilisateur authentifié, je veux pouvoir me déconnecter de l'application afin de changer de compte.
- En tant qu'utilisateur authentifié, je veux pouvoir supprimer mon compte et ses données afin de supprimer mes liens avec Greenmon.
- En tant qu'utilisateur authentifié, je veux pouvoir valider mon compte afin de pouvoir modifier les données les plus sensibles.
- En tant qu'utilisateur authentifié, je veux pouvoir consulter mes données personnelles détenues par Greenmon afin de pouvoir les modifier.

- En tant qu'utilisateur authentifié, je veux avoir un dashboard comme page d'acceuil afin de voir l'état de mon application et naviguer entres les fonctionnalités.

- En tant qu'utilisateur authentifié, je veux pouvoir accéder au magasin afin de voir et de pouvoir acheter des artéfacts.
- En tant qu'utilisateur authentifié, je veux pouvoir m'équiper pour améliorer mes compétences.

- En tant qu'utilisateur authentifié, je veux pouvoir m'occuper de mes plantes pour les maintenir en vie et acquérir de l'expérience.
- En tant qu'utilisateur authentifié, je veux pouvoir prendre une photo d'une plante réelle et récupérer diverses informations pour en savoir plus sur ma plante.
- En tant qu'utilisateur authentifié, je veux pouvoir voir tous mes greenmon afin de pouvoir les gérer.
- En tant qu'utilisateur authentifié, je veux pouvoir consulter les détails d'une plante afin d'en apprendre plus sur cette plante.

- En tant qu'utilisateur authentifié, je veux pouvoir recevoir des notificiations de l'application lorsqu'un évènement survient afin d'être alerté.

## 📈 État d'Avancement

### Création de compte
#### V1
https://github.com/user-attachments/assets/ba2b2547-1c32-4a2a-ac14-fd6975e0b066

#### V2 - UI améliorée

https://github.com/user-attachments/assets/70f37e38-6b14-4f81-b552-5a667968e8b7

### Se connecter

#### V1 
https://github.com/user-attachments/assets/72b902ef-ff76-495a-a98f-dfa99aa84283

#### V2 - UI améliorée 

https://github.com/user-attachments/assets/70f37e38-6b14-4f81-b552-5a667968e8b7

### Modification du nom 

https://github.com/user-attachments/assets/2d3ba135-fa3b-4537-95c2-4c963e9af0e7

### Suppression du compte

https://github.com/user-attachments/assets/477f3494-d390-49a4-8fa3-51a1f50103a2

### Déconnexion avec notification

https://github.com/user-attachments/assets/d8984104-c21f-47f0-ade7-9a2e68853dd8

### Le shop

https://github.com/user-attachments/assets/5c939531-49c0-4a0f-b2e1-65686d099fe2

### Gérer son inventaire

https://github.com/user-attachments/assets/972e9351-4c7e-4900-864d-ce9d90feddb5

### Ajouter une plante à sa collection

https://github.com/user-attachments/assets/78551134-9f3a-4223-bec0-5822d948b956

### Enregistrer l'arrosage d'une plante

https://github.com/user-attachments/assets/62042553-7ccd-4966-aee4-1aa719a221ef

## ⚙️ Compilation de l'Application

> Enfin, nous vous demandons d'ajouter une section pour les développeurs où vous expliquez ce qu'il faut faire pour pouvoir compiler l'application. Cette documentation doit être simple et surtout efficace.

0. Se déplacer dans le dossier du projet Flutter

```bash
cd masi_dam_2425
```

2. Installer les dépendences

```bash
flutter pub get
```

2. Placer le fichier .env fourni dans le dossier courant (masi_dam_2425)

![image](https://github.com/user-attachments/assets/e968a5d7-b73e-4587-aefd-6366a0936481)

4. Exécuter la commande ci-dessous pour générer le fichier env.g.dart

```bash
dart run build_runner build
```

le fichier env.g.dart est alors généré et reprend les jetons d'accès obfuscés et utilisables par l'application.

![image](https://github.com/user-attachments/assets/be7727d7-57f3-4230-9ad8-a5f013425b3f)


5. Lancer l'application

```bash
flutter run
```
<!-- vim: set spelllang=fr :-->
