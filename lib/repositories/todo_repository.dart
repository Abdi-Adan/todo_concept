import 'package:hive_flutter/adapters.dart';
import 'package:todo_concept/domain/models/todo.dart';

class TodoRepository {
  static const String todoBoxName = 'todos';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoAdapter());
    await Hive.openBox<Todo>(todoBoxName);
  }

  Future<List<Todo>> fetchTodos() async {
    final box = Hive.box<Todo>(todoBoxName);
    return box.values.toList();
  }

  Future<void> addTodo(Todo todo) async {
    final box = Hive.box<Todo>(todoBoxName);
    await box.put(todo.id, todo);
  }

  Future<void> updateTodo(Todo todo) async {
    final box = Hive.box<Todo>(todoBoxName);
    await box.put(todo.id, todo);
  }

  Future<void> deleteTodo(String id) async {
    final box = Hive.box<Todo>(todoBoxName);
    await box.delete(id);
  }
}
