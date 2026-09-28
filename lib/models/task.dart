import 'package:task_manager/models/priority.dart';

abstract class Task {
  final String id;
  final String title;
  final Priority priority;
  bool isCompleted;
  final DateTime? deadline;

  Task({
    required this.id,
    required this.title,
    required this.priority,
    this.isCompleted = false,
    this.deadline,
  });

  String display();
}

class UrgentTask extends Task {
  UrgentTask({
    required super.id,
    required super.title,
    required super.priority,
    super.isCompleted,
    super.deadline,
  });
  @override
  String display() => 'Urgent Task: $title (Priority: $priority)';

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'priority': priority.index,
    'isCompleted': isCompleted,
    'deadline': deadline?.toIso8601String(),
  };
}
