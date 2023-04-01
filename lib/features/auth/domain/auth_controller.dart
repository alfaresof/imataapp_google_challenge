import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imataapp/features/auth/domain/auth_state.dart';
import 'package:imataapp/features/auth/firebase/firebase_call_auth.dart';

final logInProvider = StateNotifierProvider<LogInNotifier, LogInState>((ref) {
  return LogInNotifier();
});

class LogInNotifier extends StateNotifier<LogInState> {
  LogInNotifier() : super(LogInState.initial());

  void emailChanged(String value) {
    state = state.copyWith(email: value, status: LogInStatus.initial);
  }

  void passwordChanged(String value) {
    state = state.copyWith(password: value, status: LogInStatus.initial);
  }

  void logInWithCredentials() async {
    if (!state.isValid) return;
    try {
      var result = await AuthRepositry()
          .LogIn(email: state.email, password: state.password);
      print('sssssssssssssssssssssssssssssssssssssssss');
      print('id : ${result!.uid}');
      state = state.copyWith(id: result!.uid);
      state = state.copyWith(status: LogInStatus.success);
    } catch (e) {
      print('nice error');
    }
  }
}
