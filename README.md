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
    - bloc : contient les classes d'état, d'évènements et de blocs/cubits faisant partie de l'architecture de gestion d'états BLoC

    On retrouve ici plusieurs répertoires ne représentant pas des fonctionnalités mais dont les fonctionnalités dépendent :
    - api : contient les classes d'accès aux serveurs de Firebase et aux APIs externes telles que Plant .NET
    - env : accès aux variables d'environnement telles que les clés pour les services mentionnés ci-haut
    - model : structures de données principales (plantes, profil, ...)
    - helper : classes utilitaires

    Voici les répertoires de fonctionnalités que vous pourrez retrouver :
    - app : représente le point de départ de l'application
    - home : l'écran d'accueil d'un utilisateur authentifié
    - inventory : affiche l'équipement acquis par l'utilisateur
    - login : page d'authentification pour accéder au reste de l'application
    - network : vérifie l'état de la connexion internet et affiche un message d'erreur quand la connexion aux services est perdue
    - plants : catalogue des plantes enregistrées par l'utilisateur
    - profile : page de profil de l'utilisateur où il peut consulter et modifier ses informations
    - sign-up : page d'inscription où l'utilisateur peut se créer un nouveau compte
    
- packages / : code source d'utilité générale pouvant être aisément réutilisé dans d'autres applications que celle-ci, comme pour l'authentification ou la mise en cache 

## 🚀 Présentation de l'Application

> Une présentation de votre application. Ce dernier répond à un besoin, présentez-le. Ne faites aucune hypothèse sur le niveau de connaissances de votre lecteur. Vous vous adressez ici à un internaute quelconque qui découvre votre dépôt. Évitez un jargon technique dans cette partie de votre présentation.

## 🌐 Étude de l'Existant

> Une brève étude de l'existant. L'idée étant de savoir si d'autres ont déjà couvert le besoin auquel vous essayez de répondre. Ce qui est demandé ici, au-delà d'une brève description, ce sont les points forts et les points faibles de ces différentes applications. Il peut être intéressant de faire un tableau pour mettre en regard les avantages et les inconvénients. Enfin, mettez des captures d'écran des applications afin que l'on comprenne mieux de quoi on parle.

## 🎯 Public Cible

> Parlez de votre public cible. À qui s'adresse votre application et surtout comment prenez-vous en compte ce public-là ?

## 📋 Fonctionnalités

> Une présentation des différentes fonctionnalités de votre application au travers de récits utilisateurs (user story). Soit une description courte et simple d’un besoin ou d’une attente exprimée par un utilisateur. Chacun de ces récits suit la syntaxe "En tant que **&lt;qui&gt;**, je veux **&lt;quoi&gt;** afin de **&lt;pourquoi&gt;**":

> Le **qui** indique le rôle/statut de l’utilisateur à ce moment-là. Par exemple "membre premium" ou "utilisateur non identifié". Pour mieux illustrer la diversité des besoins, on peut également utiliser le concept de persona, c'est-à-dire une personne fictive et représentative à laquelle on peut s'identifier pour mieux comprendre ses attentes. L'identification et la description des personas se fait alors avant de commencer l'écriture des récits utilisateurs. Par exemple, "Odile est une enseignante qui utilise pour la première fois le système".

> Le **quoi** décrit succinctement la fonctionnalité ou le comportement attendu. Le but du récit n'est pas d'en fournir une explication exhaustive.

> Le **pourquoi** permet d'identifier l'intérêt de la fonctionnalité et d'en justifier le développement. Il permet également de mieux évaluer la priorité des fonctionnalités. Pour chacune de ces fonctionnalités, présentées par un récit utilisateur, vous présenterez les maquettes qui s'y rapportent.

## 📈 État d'Avancement

>  Un état d'avancement pour chaque fonctionnalité de votre application. Ceci doit évidemment être mis à jour régulièrement. Dès lors que vous aurez terminé de programmer une fonctionnalité, ajoutez dans le document `README.md` un `.gif` qui l'illustre. Vous pouvez vous servir de [GIF Brewery](https://apps.apple.com/us/app/gif-brewery-3-by-gfycat/id1081413713?mt=12) (Si vous êtes sous macOS) ou de [Gyazo](https://gyazo.com) (Si vous êtes sous Windows).

## ⚙️ Compilation de l'Application

> Enfin, nous vous demandons d'ajouter une section pour les développeurs où vous expliquez ce qu'il faut faire pour pouvoir compiler l'application. Cette documentation doit être simple et surtout efficace.

<!-- vim: set spelllang=fr :-->