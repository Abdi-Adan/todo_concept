import 'package:bloc/bloc.dart';
import 'package:todo_concept/domain/bloc/todo_event.dart';
import 'package:todo_concept/domain/bloc/todo_state.dart';
import 'package:todo_concept/domain/models/todo.dart';
import 'package:todo_concept/repositories/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc({required this.todoRepository}) : super(TodoInitial()) {
    on<LoadTodos>((event, emit) async {
      emit(TodoLoadInProgress());
      try {
        final todos = await todoRepository.fetchTodos();
        emit(TodoLoadSuccess(todos));
      } catch (e) {
        emit(TodoLoadFailure(e.toString()));
      }
    });

    on<AddTodo>((event, emit) async {
      if (state is TodoLoadSuccess) {
        final List<Todo> updatedTodos =
            List.from((state as TodoLoadSuccess).todos)..add(event.todo);
        emit(TodoLoadSuccess(updatedTodos));
      }
    });

    on<UpdateTodo>((event, emit) async {
      if (state is TodoLoadSuccess) {
        final List<Todo> updatedTodos = (state as TodoLoadSuccess)
            .todos
            .map((todo) => todo.id == event.todo.id ? event.todo : todo)
            .toList();
        emit(TodoLoadSuccess(updatedTodos));
      }
    });

    on<DeleteTodo>((event, emit) async {
      if (state is TodoLoadSuccess) {
        final updatedTodos = (state as TodoLoadSuccess)
            .todos
            .where((todo) => todo.id != event.id)
            .toList();
        emit(TodoLoadSuccess(updatedTodos));
      }
    });
  }
}
