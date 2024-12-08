import 'package:equatable/equatable.dart';

class Status<Type> extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialStatus<Type> extends Status<Type> {
  final Type value;
  InitialStatus({
    required this.value,
  });

  @override
  List<Object?> get props => [value as Object?];
}

class InProgress<Type> extends Status<Type>  {}

class Failed<Type> extends Status<Type>  {
  final String message;
  Failed({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class Done<Type> extends Status<Type>  {
  final Type value;
  Done({
    required this.value,
  });

  @override
  List<Object?> get props => [value as Object?];
}
