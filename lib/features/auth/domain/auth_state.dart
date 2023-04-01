import 'package:flutter/cupertino.dart';

enum LogInStatus { auth, initial, unauth, success, error }

class LogInState {
  final String email;
  final String password;
  final String id;
  final LogInStatus status;

  final TextEditingController passwordController;
  final TextEditingController emailController;

  const LogInState(
      {required this.id,
      required this.email,
      required this.password,
      required this.status,
      required this.emailController,
      required this.passwordController});

  factory LogInState.initial() {
    return LogInState(
      id: '',
      email: '',
      password: '',
      status: LogInStatus.initial,
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
    );
  }

  LogInState copyWith({
    String? email,
    String? password,
    String? name,
    String? id,
    LogInStatus? status,
    TextEditingController? nameController,
    TextEditingController? emailController,
  }) {
    return LogInState(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        passwordController: nameController ?? this.passwordController,
        emailController: emailController ?? this.emailController);
  }

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  @override
  List<Object> get props => [email, password, status];
}
