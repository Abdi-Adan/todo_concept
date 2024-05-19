import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_concept/domain/bloc/todo_bloc.dart';
import 'package:todo_concept/domain/bloc/todo_event.dart';
import 'package:todo_concept/domain/bloc/todo_state.dart';
import 'package:todo_concept/domain/models/todo.dart';
import 'package:todo_concept/presentation/molecular/todo_item.dart';

///TODO: Add dialog/page to collect user's name and email
///TODO: Improve UI Code to follow clean code principles
// ignore: use_key_in_widget_constructors
class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoadSuccess) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                return TodoItem(todo: state.todos[index]);
              },
            );
          } else if (state is TodoLoadFailure) {
            return Center(child: Text('Failed to load todos: ${state.error}'));
          } else {
            return const Center(child: Text('No Todos'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle adding new todo
          final newTodo = Todo(
            id: DateTime.now().toString(),
            title: 'New Todo',
          );
          context.read<TodoBloc>().add(AddTodo(newTodo));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
