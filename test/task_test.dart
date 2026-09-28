import 'package:task_manager/exceptions/task_exception.dart';
import 'package:task_manager/models/priority.dart';
import 'package:task_manager/models/task.dart';
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

  test("Tache non trouvé fonctionne", () {
    expect(
      () => throw TaskNotFoundException("tache non trouvé"),
      throwsA(isA<TaskNotFoundException>()),
    );
  });
}
