import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_concept/domain/blocs/todo/todo_bloc.dart';
import 'package:todo_concept/domain/blocs/todo/todo_state.dart';
import 'package:todo_concept/domain/blocs/user/user_bloc.dart';
import 'package:todo_concept/domain/blocs/user/user_state.dart';
import 'package:todo_concept/domain/shared/app_assets.dart';
import 'package:todo_concept/presentation/molecular/todo_item.dart';
import 'package:todo_concept/presentation/pages/add_todo.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoadSuccess) {
                  return Container(
                    width: double.infinity,
                    height: 123,
                    alignment: Alignment.center,
                    color: const Color(0xff3556ab),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: Color(0xff3556ab),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Hello, ${state.user.name}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                state.user.email,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w100,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            Container(
              width: double.infinity,
              height: 116,
              color: const Color(0xffCDE53D),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.championIcon),
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Go Pro (No Ads)',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff071D55),
                          ),
                        ),
                        Text(
                          'No fuss, no ads, for only \$1 a month',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff0D2972),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        color: const Color(0xff071D55),
                        alignment: Alignment.center,
                        child: const Text(
                          "\$1",
                          style: TextStyle(
                            color: Color(0xffF2C94C),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTodoPage()),
            );
          },
          shape: const CircleBorder(),
          backgroundColor: const Color(0xff123EB1),
          child: const Icon(
            Icons.add,
            size: 36,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
