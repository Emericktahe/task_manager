class TaskNotFoundException implements Exception {
  final String message;

  TaskNotFoundException(this.message);

  @override
  String toString() => "Tache non trouvée: $message";
}

class DuplicateTaskException implements Exception {
  final String message;

  DuplicateTaskException(this.message);

  @override
  String toString() => "Tache en double: $message";
}
