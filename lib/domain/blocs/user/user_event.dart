import 'package:equatable/equatable.dart';
import 'package:todo_concept/domain/models/user.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUser extends UserEvent {}

class SaveUser extends UserEvent {
  final User user;

  SaveUser(this.user);

  @override
  List<Object> get props => [user];
}
