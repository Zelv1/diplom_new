part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthCheckCacheEvent extends AuthEvent {
  AuthCheckCacheEvent();
}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;

  AuthLoginEvent({required this.username, required this.password});
}

class AuthFetchEvent extends AuthEvent {
  final String token;

  AuthFetchEvent({required this.token});
}

class AuthLogoutEvent extends AuthEvent {
  AuthLogoutEvent();
}
