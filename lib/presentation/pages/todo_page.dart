import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_concept/domain/blocs/todo/todo_bloc.dart';
import 'package:todo_concept/domain/blocs/todo/todo_event.dart';
import 'package:todo_concept/domain/blocs/todo/todo_state.dart';
import 'package:todo_concept/domain/blocs/user/user_bloc.dart';
import 'package:todo_concept/domain/blocs/user/user_state.dart';
import 'package:todo_concept/domain/models/todo.dart';
import 'package:todo_concept/presentation/molecular/todo_item.dart';

///TODO: Handle To do list scrolling
///TODO: Improve UI Code to follow clean code principles
class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Column(
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoadSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${state.user.name}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Email: ${state.user.email}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
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
                  return Center(
                      child: Text('Failed to load todos: ${state.error}'));
                } else {
                  return const Center(child: Text('No Todos'));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ///TODO: Handle adding new todo
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
