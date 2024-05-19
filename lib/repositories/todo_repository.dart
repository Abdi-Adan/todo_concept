import 'package:todo_concept/domain/models/todo.dart';

class TodoRepository {
  Future<List<Todo>> fetchTodos() async {
    // Simulating network call
    await Future.delayed(const Duration(seconds: 2));
    ///TODO: Add support for firebase storage and local storage
    return [
      Todo(id: '1', title: 'Todo 1'),
      Todo(id: '2', title: 'Todo 2'),
    ];
  }
}
