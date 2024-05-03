part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthWaitCredentialsState extends AuthState {}

class AuthSuccessState extends AuthState {
  final UserModel user;
  AuthSuccessState({required this.user});
}

class AuthErrorState extends AuthState {}
