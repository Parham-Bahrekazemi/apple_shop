import 'package:apple_shop/bloc/authentication/authentication_event.dart';
import 'package:apple_shop/bloc/authentication/authentication_state.dart';

import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:apple_shop/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IAuthenticationRepository _repository = locator.get();
  AuthenticationBloc() : super(AuthenticationInitState()) {
    on<AuthenticationLoginEvent>(
      (event, emit) async {
        emit(AuthenticationLoadingState());

        Either<String, String> response =
            await _repository.login(event.username, event.password);

        emit(AuthenticationResponseState(response));
      },
    );
    on<AuthenticationRegisterEvent>(
      (event, emit) async {
        emit(AuthenticationLoadingState());

        Either<String, String> response = await _repository.register(
          event.username,
          event.password,
          event.passwordConfirm,
        );

        emit(AuthenticationResponseState(response));
      },
    );
  }
}
