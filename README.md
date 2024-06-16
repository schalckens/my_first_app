# Lecture du Mois

## Contexte
Nous sommes un groupe d'étudiants en ingénierie informatique et multimédia, composé de Valentine Schalckens, Bastien Kerebel et Zaccharie Darmoise. Dans le cadre de notre projet, nous devons répondre à une problématique visant à faciliter le choix du livre à lire pour le mois à venir pour des groupes de lecture, en utilisant une application mobile. Notre solution doit intégrer des fonctionnalités de vote et de sélection, tout en exploitant des technologies mobiles et en tenant compte des théories du choix social.

## Problématique
Comment simplifier et rendre plus efficace le processus de sélection du livre mensuel pour un groupe de lecture, en utilisant une application mobile qui intègre des fonctionnalités de vote et de sélection selon les principes de la théorie du choix social, tout en explorant différentes technologies de développement mobile ?

## Théorie du Choix Social
### Expression de Préférence : 
Les membres du groupe de lecture peuvent exprimer leurs préférences en sélectionnant des livres qu'ils aimeraient lire. Chaque utilisateur peut sélectionner jusqu'à quatre livres pour le vote initial.

### Fonction d'Agrégation : 
Un système de Vote Transférable avec biais social est utilisé pour le vote final. Ce processus implique des séries de votes éliminatoires où les livres avec le moins de votes sont successivement éliminés et les participants revotent parmi les livres restants, jusqu'à ce qu'un livre soit choisi.

## Technologies Utilisées
### Front-end Mobile
Valentine Schalckens : Flutter
Bastien Kerebel : Kotlin Native
Zaccharie Darmoise : React (non-native)
### Back-end
Langage : Python
Framework : Django Rest + Django ORM
Base de données : MySQL

## Structure de la Base de Données
### Tables :
User : id, username, password, registration_date, role
Author : id, first_name, last_name
Book : id, title, description, comment, main_genre, cover_url, author_id
Session : id, year, month, creation_date
Selection : user_id, book_id, session_id
Vote : user_id, book_id, session_id

## Fonctionnalités de l'Application
Page d'accueil : Accessible même pour les utilisateurs non connectés, cette page affiche des recommandations de livres par genre.
Page de Sélection : Les utilisateurs connectés peuvent sélectionner jusqu'à quatre livres pour le vote initial.
Vote Final : Les cinq livres les plus sélectionnés sont soumis à un vote final physique via des QR Codes. Les participants scannent le QR Code du livre qu'ils préfèrent. Le livre avec le moins de votes est éliminé progressivement jusqu'à ce qu'il ne reste que deux livres. Le livre ayant le plus de votes finaux est choisi pour le mois suivant.

## Fonctionnalités Spécifiques
Utilisation des QR Codes : Les votes finaux sont effectués en scannant des QR Codes, une fonctionnalité propre aux mobiles, pour enregistrer les votes des participants.

## Développement et Tests
Chaque membre du groupe testera l'application sur une technologie mobile différente pour comparer les performances et les expériences utilisateur.
Une API Rest centralisée sera développée pour garantir une cohérence des données et éviter les redondances.

## Objectifs
Faciliter la sélection et le vote du livre du mois pour les groupes de lecture.
Exploiter différentes technologies mobiles pour développer des compétences en développement mobile.
Utiliser une base de données centralisée pour gérer les utilisateurs, les livres, les sélections et les votes de manière efficace.
Déploiement

L'application sera déployée sur Android pour commencer.
