import 'package:task_manager/exceptions/task_exception.dart';
import 'package:task_manager/repositories/task_repository.dart';

import '../models/task.dart';

class TaskService {
  TaskRepository taskRepository = TaskRepository();

  Future<void> init() async {
    await taskRepository.init();
  }

  Future<void> addTask(Task task) async {
    await taskRepository.add(task);
  }

  Future<List<Task>> getAlltasks() async {
    return await taskRepository.getAll();
  }

  Future<void> deleteTask(String id) async {
    final tasks = await taskRepository.getAll();
    if (!tasks.any((t) => t.id == id)) {
      throw TaskNotFoundException("Tache $id introuvable");
    }
    await taskRepository.delete(id);
  }

  Future<void> completeTask(String id) async {
    final tasks = await taskRepository.getAll();
    final index = tasks.indexWhere((t) => t.id == id);
    if (index == -1) throw TaskNotFoundException("Tache $id introuvable");
    tasks[index].isCompleted = true;
    await taskRepository.update(tasks[index]);
  }

  Future<List<Task>> sortByPriority() async {
    final tasks = await taskRepository.getAll();
    tasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
    return tasks;
  }

  Future<List<Task>> sortByDate() async {
    final tasks = await taskRepository.getAll();
    tasks.sort((a, b) {
      if (a.deadline == null) {
        return 1;
      } else if (b.deadline == null) {
        return -1;
      } else {
        return a.deadline!.compareTo(b.deadline!);
      }
    });
    return tasks;
  }
}
