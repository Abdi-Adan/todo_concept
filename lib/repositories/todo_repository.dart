import 'package:hive_flutter/adapters.dart';
import 'package:todo_concept/domain/models/todo.dart';
import 'package:todo_concept/domain/models/user.dart';

class TodoRepository {
  static const String todoBoxName = 'todos';
  static const String userBoxName = 'user';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoAdapter());
    Hive.registerAdapter(UserAdapter());
    await Hive.openBox<Todo>(todoBoxName);
    await Hive.openBox<User>(userBoxName);
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

  Future<User?> fetchUser() async {
    final box = Hive.box<User>(userBoxName);
    return box.get('user');
  }

  Future<void> saveUser(User user) async {
    final box = Hive.box<User>(userBoxName);
    await box.put('user', user);
  }
}
