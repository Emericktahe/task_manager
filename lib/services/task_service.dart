import 'package:task_manager/repositories/task_repository.dart';

import '../models/task.dart';

class TaskService {
  TaskRepository taskRepository = TaskRepository();
  Future<void> addTask(Task task) async {
    await taskRepository.add(task);
  }

  Future<List<Task>> getAlltasks() async {
    return await taskRepository.getAll();
  }

  Future<void> deleteTask(String id) async {
    await taskRepository.delete(id);
  }

  Future<void> completeTask(String id) async {
    final tasks = await taskRepository.getAll();
    final task = tasks.firstWhere((t) => t.id == id);
    task.isCompleted = true;
    await taskRepository.update(task);
  }

  Future<List<Task>> sortByPriority() async {
    final tasks = await taskRepository.getAll();
    tasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
    return tasks;
  }

  Future<List<Task>> sortByDate() async {
    final tasks = await taskRepository.getAll();
    tasks.sort((a, b) => b.deadline!.compareTo(a.deadline!));
    return tasks;
  }
}
