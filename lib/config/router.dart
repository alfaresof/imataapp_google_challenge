import 'package:flutter/material.dart';
import 'package:imataapp/features/auth/login/view/login.dart';
import 'package:imataapp/features/auth/sign_up/view/sign_up.dart';
import 'package:imataapp/features/home/view/home.dart';
import 'package:imataapp/features/report/view/new.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const HomePage(),
        );
      case SignUp.routename:
        return SignUp.route();
      case LogIn.routename:
        return LogIn.route();
      case HomePage.routename:
        return HomePage.route();
      case NewReport.routename:
        return NewReport.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('error'),
        ),
      ),
      settings: const RouteSettings(name: '/error'),
    );
  }
}
