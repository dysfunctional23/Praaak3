part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoaded extends AuthState {
  AuthLoaded();
}

class NeedRegistrate extends AuthState {}

class AuthAdmin extends AuthState {}
