import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imataapp/features/auth/domain/auth_state.dart';
import 'package:imataapp/features/auth/firebase/firebase_call_auth.dart';

class LogInNotifier extends StateNotifier<LogInState> {
  LogInNotifier() : super(LogInState.initial());

  void emailChanged(String value) {
    state = state.copyWith(email: value, status: LogInStatus.initial);
  }

  void passwordChanged(String value) {
    state = state.copyWith(password: value, status: LogInStatus.initial);
  }

  Future<bool> logInWithCredentials() async {
    if (!state.isValid) return false;
    var isLogIn = false;
    await AuthRepositry()
        .LogIn(email: state.email, password: state.password)
        .then((value) {
      state = state.copyWith(id: value?.uid);
      state = state.copyWith(status: LogInStatus.success);
      isLogIn = true;
    }).catchError((e) {
      state = state.copyWith(status: LogInStatus.error);
    });
    return isLogIn;
  }
}

final logInProvider =
    StateNotifierProvider<LogInNotifier, LogInState>((ref) => LogInNotifier());
