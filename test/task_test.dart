import 'package:task_manager/exceptions/task_exception.dart';
import 'package:task_manager/models/priority.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/repositories/task_repository.dart';
import 'package:task_manager/services/task_service.dart';
import 'package:test/test.dart';

void main() {
  test("Urgent task a le bon titre", () {
    final task = UrgentTask(
      id: "1",
      title: "Titre de la tâche urgente",
      priority: Priority.high,
    );
    expect(task.title, "Titre de la tâche urgente");
  });

  test("Normal task a le bon titre", () {
    final task = NormalTask(
      id: "1",
      title: "Titre de la tâche normale",
      priority: Priority.medium,
    );
    expect(task.title, "Titre de la tâche normale");
  });

  test("isCompleted est false par défaut", () {
    final task = UrgentTask(id: "1", title: "Test", priority: Priority.high);
    expect(task.isCompleted, false);
  });

  test("display contient le titre", () {
    final task = UrgentTask(id: "1", title: "Test", priority: Priority.high);
    expect(task.display(), contains("Test"));
  });

  test("toJson retourne bien une map", () {
    final task = UrgentTask(id: "1", title: "Test", priority: Priority.high);
    final json = task.toJson();
    expect(json['id'], "1");
    expect(json['title'], "Test");
  });

  test("toJson NormalTask retourne bien une map", () {
    final task = NormalTask(id: "1", title: "Test", priority: Priority.medium);
    final json = task.toJson();
    expect(json['id'], "1");
    expect(json['title'], "Test");
  });

  test("Tache non trouvé fonctionne", () {
    expect(
      () => throw TaskNotFoundException("tache non trouvé"),
      throwsA(isA<TaskNotFoundException>()),
    );
  });

  test("Tache dupliqué", () {
    expect(
      () => throw DuplicateTaskException("tache dupliqué"),
      throwsA(isA<DuplicateTaskException>()),
    );
  });

  test("ajouter task dans la liste", () async {
    final repo = TaskRepository();
    await repo.add(UrgentTask(id: "1", title: "Test", priority: Priority.high));
    final tasks = await repo.getAll();
    expect(tasks.length, 1);
  });

  test("Titre en double", () async {
    final repo = TaskRepository();
    await repo.add(UrgentTask(id: "1", title: "Test", priority: Priority.high));
    expect(
      () async => await repo.add(
        UrgentTask(id: "2", title: "Test", priority: Priority.high),
      ),
      throwsA(isA<DuplicateTaskException>()),
    );
  });

  test("Tache n'existe pas", () async {
    final service = TaskService();
    expect(
      () async => await service.deleteTask("id-inexistant"),
      throwsA(isA<TaskNotFoundException>()),
    );
  });
}
