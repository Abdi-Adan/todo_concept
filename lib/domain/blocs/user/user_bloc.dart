import 'package:bloc/bloc.dart';
import 'package:todo_concept/domain/blocs/user/user_event.dart';
import 'package:todo_concept/domain/blocs/user/user_state.dart';
import 'package:todo_concept/repositories/todo_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final TodoRepository todoRepository;

  UserBloc({required this.todoRepository}) : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      emit(UserLoadInProgress());
      try {
        final user = await todoRepository.fetchUser();
        if (user != null) {
          emit(UserLoadSuccess(user));
        } else {
          emit(UserInitial());
        }
      } catch (e) {
        emit(UserLoadFailure(e.toString()));
      }
    });

    on<SaveUser>((event, emit) async {
      try {
        await todoRepository.saveUser(event.user);
        emit(UserLoadSuccess(event.user));
      } catch (e) {
        emit(UserLoadFailure(e.toString()));
      }
    });
  }
}
