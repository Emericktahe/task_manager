import 'dart:convert';
import 'dart:io';

class JsonStorage {
  List data = [];
  final String filePath = 'lib/data/tasks.json';

  Future<void> save(List data) async {
    final file = File(filePath);
    await file.parent.create(recursive: true);
    final jsonList = data.map((e) => e.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  Future<List> load() async {
    try {
      if (!File(filePath).existsSync()) {
        return [];
      } else {
        return jsonDecode(await File(filePath).readAsString());
      }
    } catch (e) {
      return [];
    }
  }
}
