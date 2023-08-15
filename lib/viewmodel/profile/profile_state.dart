part of 'profile_bloc.dart';

sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class LogoutLoading extends ProfileState {}

class LogoutFailed extends ProfileState {
  final String message;

  LogoutFailed({required this.message});
}

class LogoutSuccess extends ProfileState {}
