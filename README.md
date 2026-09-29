# Task Manager CLI

Une application en ligne de commande de gestion de tâches écrite en Dart.

## Prérequis

- Dart SDK installé sur votre machine

## Installation

### bash

git clone https://github.com/Emericktahe/task_manager.git
cd task_manager
dart pub get

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
- Trier les tâches par priorité et par date

## Structure du projet

lib/

- models/(classes abstraites et modèles de données)
  --Task, UrgentTask,NormalTask, Priority
- interfaces/(contrats génériques)
  --Repository<T>
- repositories/(accès aux données et persistance)
  --TaskRepository
- service/(logique métier)
  --TaskService
- exceptions/(gestion des erreurs personnalisées)
  --TaskException
- storage/(lecture et écriture JSON)
  --JsonStorage

## Exigences techniques

Classe abstraite Task avec héritage (UrgentTask, NormalTask)

Interface générique Repository<T>

Exceptions personnalisées (TaskNotFoundException, DuplicateTaskException)

Persistance JSON avec dart:io et dart:convert

8 tests unitaires

## Notes pour le reviewer

Lancer depuis la racine du projet avec dart run bin/main.dart

Les données sont persistées dans lib/data/tasks.json
