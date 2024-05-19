import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_concept/domain/blocs/todo/todo_bloc.dart';
import 'package:todo_concept/domain/blocs/todo/todo_event.dart';
import 'package:todo_concept/domain/blocs/user/user_bloc.dart';
import 'package:todo_concept/domain/blocs/user/user_state.dart';
import 'package:todo_concept/domain/models/todo.dart';
import 'package:todo_concept/domain/shared/app_strings.dart';
import 'package:todo_concept/presentation/pages/todo_page.dart';

class AddTodoPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();

  AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const Icon(Icons.list, color: Colors.white),
          backgroundColor: const Color(0xff3556ab),
          title: const Text(
            AppStrings.addTodoTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoadSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TodoPage()),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  child: Text(
                    AppStrings.addTodoPrompt,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.enterTaskPrompt,
                      border: OutlineInputBorder(),
                    ),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final newTodo = Todo(
                          id: DateTime.now().toString(),
                          title: _titleController.text,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TodoPage()),
                        );
                        context.read<TodoBloc>().add(AddTodo(newTodo));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff3556ab),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5.0), // Add rounded corners
                        ),
                      ),
                      child: const Text(
                        AppStrings.doneText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
