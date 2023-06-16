import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imataapp/features/auth/domain/sign_up_state.dart';
import 'package:imataapp/features/auth/firebase/firebase_call_auth.dart';
import 'package:imataapp/features/home/view/home.dart';

final signUpProvider =
    StateNotifierProvider<SignUpNotifier, SignUpState>((ref) {
  return SignUpNotifier();
});

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier() : super(SignUpState.initial());

  void emailChanged(String value) {
    state.copyWith(email: value, status: RegisterStatus.initial);
  }

  void passwordChanged(String value) {
    state.copyWith(password: value, status: RegisterStatus.initial);
  }

  void nameChange(String value) {
    state.copyWith(name: value, status: RegisterStatus.initial);
  }

  void registerWithCredentials(BuildContext context) async {
    // if (!state.isValid) return;
    try {
      final result = await AuthRepositry().SignUp(
        name: state.nameController.text,
        email: state.emailController.text,
        password: state.passwordController.text,
      );
      state = state.copyWith(
        id: result!.uid,
        status: RegisterStatus.success,
      );
      if (state.status == RegisterStatus.success) {
        Navigator.pushReplacementNamed(context, HomePage.routename);
      }
    } catch (_) {}
  }
}
