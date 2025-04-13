// // abstract class AuthState {}
// //
// // class AuthInitial extends AuthState {}
// //
// // class AuthLoading extends AuthState {}
// //
// // class AuthSuccess extends AuthState {}
// //
// // class AuthFailure extends AuthState {
// //   final String error;
// //   AuthFailure(this.error);
// // }
//
// // login_state.dart
// class LoginInitial extends LoginState {}
//
// class LoginLoading extends LoginState {}
//
// class LoginSuccess extends LoginState {}
//
// class LoginFailure extends LoginState {
//   final String error;
//   LoginFailure(this.error);
// }
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
