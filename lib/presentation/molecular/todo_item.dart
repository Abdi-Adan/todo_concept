import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_concept/domain/blocs/todo/todo_bloc.dart';
import 'package:todo_concept/domain/blocs/todo/todo_event.dart';
import 'package:todo_concept/domain/models/todo.dart';
import 'package:todo_concept/domain/shared/app_strings.dart';
import 'package:todo_concept/presentation/pages/edit_todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      leading: Checkbox(
        value: todo.isCompleted,
        activeColor: const Color(0xff53DA69),
        checkColor: const Color(0xff399649),
        shape: const CircleBorder(),
        onChanged: (bool? value) {
          context.read<TodoBloc>().add(
                UpdateTodo(
                  todo.copyWith(isCompleted: value ?? false),
                ),
              );
        },
      ),
      trailing: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditTodoPage(
                      todo: todo,
                    )),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(style: BorderStyle.solid)),
        ),
        child: const Text(
          AppStrings.editText,
          style: TextStyle(
            color: Color(0xff071D55),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
