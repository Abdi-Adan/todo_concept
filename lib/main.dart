import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_concept/domain/bloc/todo_bloc.dart';
import 'package:todo_concept/domain/bloc/todo_event.dart';
import 'package:todo_concept/domain/entities/app_constants.dart';
import 'package:todo_concept/presentation/pages/todo_concept_app.dart';
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
  runApp(TodoApp(todoRepository: todoRepository));
}

class TodoApp extends StatelessWidget {
  final TodoRepository todoRepository;

  const TodoApp({super.key, required this.todoRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) =>
            TodoBloc(todoRepository: todoRepository)..add(LoadTodos()),
        child: TodoPage(),
      ),
    );
  }
}
