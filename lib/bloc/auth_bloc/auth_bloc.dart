// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:diplom_new/features/models/user_model/user_model.dart';
import 'package:diplom_new/features/repository/auth_repository/auth_repository.dart';
import 'package:diplom_new/features/repository/get_user_data_repository/get_user_data_repository.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    log('AUTH BLOC');
    AuthMiddleware.authData.listen((event) {
      log('===== event=$event =====');
    });
    AuthMiddleware.user.listen((event) {
      log('===== event=$event =====');
    });

    on<AuthCheckCacheEvent>((event, emit) async {
      emit(AuthLoadingState());
      log('AUTH CHECK CACHE');
      try {
        final token = await authRepositoryGetLocalToken();
        if (token == null) {
          emit(AuthWaitCredentialsState());
        } else {
          AuthMiddleware.saveAuthData(token);
          add(AuthFetchEvent(token: token));
        }
      } catch (e) {
        emit(AuthErrorState());
      }
    });

    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        String _token =
            await authRepositoryAuthorization(event.username, event.password);
        AuthMiddleware.saveAuthData(_token);
        add(AuthFetchEvent(token: _token));
      } catch (e) {
        log(e.toString());
        emit(AuthWaitCredentialsState());
      }
    });

    on<AuthFetchEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final repository = GetUserDataRepository(event.token);
        final user = await repository.getUserData();
        AuthMiddleware.saveUser(user);
        emit(AuthSuccessState(user: user));
      } catch (e) {
        log(e.toString());
        emit(AuthWaitCredentialsState());
      }
    });

    on<AuthLogoutEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        try {
          await deleteLocalToken();
          emit(AuthWaitCredentialsState());
        } catch (e) {
          log(e.toString());
          emit(AuthErrorState());
        }
      },
    );
  }
}

class AuthMiddleware {
  static final StreamController<String?> _authData =
      StreamController<String?>.broadcast();
  static final StreamController<UserModel?> _user =
      StreamController<UserModel?>.broadcast();

  static void saveAuthData(String? authData) {
    log('работает saveData');
    _authData.add(authData);
    log('$authData');
  }

  static void saveUser(UserModel? user) {
    log('работает saveUser');
    _user.add(user);
    log('$user');
  }

  static Stream get authData => _authData.stream;
  static Stream get user => _user.stream;
}
