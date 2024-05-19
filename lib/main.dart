import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_concept/domain/blocs/todo/todo_bloc.dart';
import 'package:todo_concept/domain/blocs/todo/todo_event.dart';
import 'package:todo_concept/domain/blocs/user/user_bloc.dart';
import 'package:todo_concept/domain/blocs/user/user_event.dart';
import 'package:todo_concept/domain/blocs/user/user_state.dart';
import 'package:todo_concept/domain/shared/app_constants.dart';
import 'package:todo_concept/presentation/pages/todo_page.dart';
import 'package:todo_concept/presentation/pages/user_page.dart';
import 'package:todo_concept/repositories/todo_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Handle platform specific errors during initialization
  try {
    await SystemChannels.platform.invokeMethod<void>('setMethod');
  } on PlatformException catch (e) {
    logger.w(e.toString());
  }

  // Lock application orientation to portait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final TodoRepository todoRepository = TodoRepository();
  await todoRepository.init();

  runApp(TodoApp(todoRepository: todoRepository));
}

class TodoApp extends StatelessWidget {
  final TodoRepository todoRepository;

  const TodoApp({super.key, required this.todoRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TodoBloc(todoRepository: todoRepository)..add(LoadTodos()),
        ),
        BlocProvider(
          create: (context) =>
              UserBloc(todoRepository: todoRepository)..add(LoadUser()),
        ),
      ],
      child: MaterialApp(
        home: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadInProgress) {
              return const CircularProgressIndicator();
            } else if (state is UserLoadSuccess) {
              return const TodoPage();
            } else {
              return UserPage();
            }
          },
        ),
      ),
    );
  }
}
