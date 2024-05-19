import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_concept/domain/bloc/todo_bloc.dart';
import 'package:todo_concept/domain/bloc/todo_event.dart';
import 'package:todo_concept/domain/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (bool? value) {
          context.read<TodoBloc>().add(
                UpdateTodo(
                  todo.copyWith(isCompleted: value ?? false),
                ),
              );
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          context.read<TodoBloc>().add(DeleteTodo(todo.id));
        },
      ),
    );
  }
}
