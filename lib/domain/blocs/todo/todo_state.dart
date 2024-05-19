import 'package:equatable/equatable.dart';
import 'package:todo_concept/domain/models/todo.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoadInProgress extends TodoState {}

class TodoLoadSuccess extends TodoState {
  final List<Todo> todos;

  TodoLoadSuccess(this.todos);

  @override
  List<Object> get props => [todos];
}

class TodoLoadFailure extends TodoState {
  final String error;

  TodoLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
