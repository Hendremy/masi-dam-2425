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

> Une brève étude de l'existant. L'idée étant de savoir si d'autres ont déjà couvert le besoin auquel vous essayez de répondre. Ce qui est demandé ici, au-delà d'une brève description, ce sont les points forts et les points faibles de ces différentes applications. Il peut être intéressant de faire un tableau pour mettre en regard les avantages et les inconvénients. Enfin, mettez des captures d'écran des applications afin que l'on comprenne mieux de quoi on parle.

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
https://github.com/user-attachments/assets/ba2b2547-1c32-4a2a-ac14-fd6975e0b066

### Se connecter
https://github.com/user-attachments/assets/72b902ef-ff76-495a-a98f-dfa99aa84283

### Le shop
https://github.com/user-attachments/assets/89b48983-34dd-479e-9a4b-b71838c273df

### Acheter des artéfacts
https://github.com/user-attachments/assets/6417e0e9-1571-4814-bad2-e7a4a745be8a

### Gérer son inventaire
https://github.com/user-attachments/assets/af399a79-0c9f-40a1-b27d-0f6667dfbe56


>  Un état d'avancement pour chaque fonctionnalité de votre application. Ceci doit évidemment être mis à jour régulièrement. Dès lors que vous aurez terminé de programmer une fonctionnalité, ajoutez dans le document `README.md` un `.gif` qui l'illustre. Vous pouvez vous servir de [GIF Brewery](https://apps.apple.com/us/app/gif-brewery-3-by-gfycat/id1081413713?mt=12) (Si vous êtes sous macOS) ou de [Gyazo](https://gyazo.com) (Si vous êtes sous Windows).

## ⚙️ Compilation de l'Application

> Enfin, nous vous demandons d'ajouter une section pour les développeurs où vous expliquez ce qu'il faut faire pour pouvoir compiler l'application. Cette documentation doit être simple et surtout efficace.

<!-- vim: set spelllang=fr :-->
