import 'package:dartz/dartz.dart';

abstract class AuthenticationState {}

class AuthenticationInitState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationResponseState extends AuthenticationState {
  Either<String, String> response;

  AuthenticationResponseState(this.response);
}
