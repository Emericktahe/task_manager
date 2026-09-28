# Task Manager CLI
Une application en ligne de commande de gestion de tâches écrite en Dart.

## Prérequis
- Dart SDK installé sur votre machine

## Lancer l'application
### bash
 dart run bin/main.dart

## Lancer test
### bash
dart test

## Fontionnalités
- Ajouter une tâche avec titre, priorité et date limite
- Lister toutes les tâches
- Marquer une tâche comme terminée
- Supprimer une tâche
- Persistance des données dans un fichier JSON local

## Structure du projet
lib/
- models/
--Task, UrgentTask, Priority
- interfaces/
--Repository<T>
- repositories/
--TaskRepository
- service/
--TaskService
- exceptions/
--TaskException
- storage/
--JsonStorage
