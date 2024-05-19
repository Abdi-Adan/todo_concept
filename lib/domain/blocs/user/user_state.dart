import 'package:equatable/equatable.dart';
import 'package:todo_concept/domain/models/user.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoadInProgress extends UserState {}

class UserLoadSuccess extends UserState {
  final User user;

  UserLoadSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserLoadFailure extends UserState {
  final String error;

  UserLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
