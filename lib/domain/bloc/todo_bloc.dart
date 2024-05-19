import 'package:bloc/bloc.dart';
import 'package:todo_concept/domain/bloc/todo_event.dart';
import 'package:todo_concept/domain/bloc/todo_state.dart';
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
        await todoRepository.addTodo(event.todo);
        final updatedTodos = await todoRepository.fetchTodos();
        emit(TodoLoadSuccess(updatedTodos));
      }
    });

    on<UpdateTodo>((event, emit) async {
      if (state is TodoLoadSuccess) {
        await todoRepository.updateTodo(event.todo);
        final updatedTodos = await todoRepository.fetchTodos();
        emit(TodoLoadSuccess(updatedTodos));
      }
    });

    on<DeleteTodo>((event, emit) async {
      if (state is TodoLoadSuccess) {
        await todoRepository.deleteTodo(event.id);
        final updatedTodos = await todoRepository.fetchTodos();
        emit(TodoLoadSuccess(updatedTodos));
      }
    });
  }
}
