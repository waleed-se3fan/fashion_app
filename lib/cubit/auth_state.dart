part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class SignupState extends AuthState {}

class SignInSuccesState extends AuthState {}

class UpdateEyeState extends AuthState {}
