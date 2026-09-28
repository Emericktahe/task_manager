import 'dart:io';
import 'dart:math';

import 'package:task_manager/models/priority.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/services/task_service.dart';

void main() async {
  final service = TaskService();
  int choix = 0;
  print("Bienvenue dans ton gestionnaire de tâches");
  do {
    print("1. AJouter une tâche");
    print("2. Voir toutes les tâches");
    print("3. Supprimer une tâche");
    print("4. Marquer une tâche comme terminée");
    print("5. Trier par priorité");
    print("6. Trier par date");
    print("0. Quitter");

    choix = int.parse(stdin.readLineSync()!);

    switch (choix) {
      case 1:
        final String id = Random().nextInt(10).toString();
        print('Entrer le titre de la tâche : ');
        final title = stdin.readLineSync();
        print(
          'Entrer le numéro de la priorité (1: Urgent, 2: Normal, 3: Faible) : ',
        );
        int choixPriority = int.parse(stdin.readLineSync()!);
        if (choixPriority == 1) {
          choixPriority = Priority.high.index;
        } else if (choixPriority == 2) {
          choixPriority = Priority.medium.index;
        } else if (choixPriority == 3) {
          choixPriority = Priority.low.index;
        } else {
          print('Priorité invalide. Veuillez entrer 1, 2 ou 3.');
        }
        bool isCompleted = false;
        DateTime? deadline;
        print("Voulez vous une date limite ? (o/n)");
        String choixDate = stdin.readLineSync()!.toLowerCase();

        if (choixDate == "o") {
          print('Entrer la date limite (YYYY-MM-DD) : ');
          String deadlineString = stdin.readLineSync()!;
          deadline = DateTime.parse(deadlineString);
        } else {
          print('Aucune date limite ajoutée.');
          deadline = null;
        }
        await service.addTask(
          UrgentTask(
            id: id,
            title: title!,
            priority: Priority.values[choixPriority],
            isCompleted: isCompleted,
            deadline: deadline,
          ),
        );
        print("Tache AJoutée avec succès !");
        break;

      case 2:
        print("Voici toutes les tâches : ");
        await service.getAlltasks().then((tasks) {
          for (var task in tasks) {
            print(task.display());
          }
        });
        break;

      case 3:
        print("Entrer l'id de la tâche à supprimer : ");
        final deleteId = stdin.readLineSync()!;
        await service.deleteTask(deleteId);
        print("Tache supprimée avec succès !");
        break;

      case 4:
        print("Entrer l'id de la tâche à marquer comme terminée : ");
        final completeId = stdin.readLineSync()!;
        await service.completeTask(completeId);
        print("Tache marquée comme terminée avec succès !");
        break;
      case 5:
        print("Tâches triées par priorité :");
        await service.sortByPriority().then((tasks) {
          for (var task in tasks) {
            print(task.display());
          }
        });
        break;
      case 6:
        print("Tâches triées par date :");
        await service.sortByDate().then((tasks) {
          for (var task in tasks) {
            print(task.display());
          }
        });
        break;
      case 0:
        print("Au revoir !");
        break;
      default:
        print("Choix invalide. Veuillez réessayer.");
    }
  } while (choix != 0);
}
