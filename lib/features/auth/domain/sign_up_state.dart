import 'package:flutter/cupertino.dart';

enum RegisterStatus { initial, submitting, success, error }

// extends Equatable
class SignUpState {
  final String name;
  final String email;
  final String password;
  final RegisterStatus status;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String id;

  const SignUpState({
    required this.email,
    required this.password,
    required this.status,
    required this.name,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.id,
  });

  factory SignUpState.initial() {
    return SignUpState(
      email: '',
      password: '',
      name: '',
      status: RegisterStatus.initial,
      emailController: TextEditingController(),
      nameController: TextEditingController(),
      passwordController: TextEditingController(),
      id: '',
    );
  }

  SignUpState copyWith({
    String? email,
    String? password,
    String? name,
    RegisterStatus? status,
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    String? id,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      status: status ?? this.status,
      passwordController: passwordController ?? this.passwordController,
      nameController: nameController ?? this.nameController,
      emailController: emailController ?? this.emailController,
      id: id ?? this.id,
    );
  }

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  @override
  List<Object> get props => [email, password, name, status];
}
