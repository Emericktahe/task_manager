import 'package:task_manager/exceptions/task_exception.dart';
import 'package:task_manager/interfaces/repository.dart';
import 'package:task_manager/models/priority.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/storage/json_storage.dart';

class TaskRepository implements Repository<Task> {
  final JsonStorage _storage = JsonStorage();
  final List<Task> _tasks = [];

  Future<void> init() async {
    _tasks.clear();
    final data = await _storage.load();
    final List<Task> tasks = data.map((item) {
      return UrgentTask(
        id: item['id'],
        title: item['title'],
        priority: Priority.values[item['priority']],
        isCompleted: item['isCompleted'],
        deadline: DateTime.tryParse(item['deadline'] ?? ''),
      );
    }).toList();
    _tasks.addAll(tasks);
  }

  @override
  Future<void> add(Task data) async {
    if (_tasks.any((t) => t.title == data.title)) {
      throw DuplicateTaskException("Tache en double");
    }
    _tasks.add(data);
    await _storage.save(_tasks);
  }

  @override
  Future<List<Task>> getAll() async {
    try {
      return _tasks;
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  @override
  Future<void> update(Task data) async {
    try {
      final index = _tasks.indexWhere((t) => t.id == data.id);
      if (index != -1) {
        _tasks[index] = data;
        await _storage.save(_tasks);
      }
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      _tasks.removeWhere((t) => t.id == id);
      await _storage.save(_tasks);
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}
