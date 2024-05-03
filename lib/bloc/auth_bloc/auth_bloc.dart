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
    on<AuthCheckCacheEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final token = await authRepositoryGetLocalToken();
        if (token == null) {
          emit(AuthWaitCredentialsState());
        } else {
          add(AuthFetchEvent(token: token));
        }
      } catch (e) {
        emit(AuthErrorState());
      }
    });

    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        String token =
            await authRepositoryAuthorization(event.username, event.password);
        add(AuthFetchEvent(token: token));
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

    // on<AuthSignInEvent>((event, emit) async {
    //   emit(AuthLoadingState());
    //   AuthRepository repository =
    //       AuthRepository(username: event.username, password: event.password);
    //   try {
    //     String token = await repository.authorization();
    //     emit(AuthLoadedState(token: token));
    //   } catch (e) {
    //     log(e.toString());
    //     emit(AuthErrorState());
    //   }
    // });

    // on<AuthIsLogedEvent>((event, emit) async {
    //   AuthRepository repository = AuthRepository();
    //   try {
    //     String token = await repository.getLocalToken();
    //     emit(AuthLoadedState(token: token));
    //   } catch (e) {
    //     log(e.toString());
    //     emit(AuthErrorState());
    //   }
    // });
  }
}
