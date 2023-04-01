import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imataapp/config/color.dart';
import 'package:imataapp/features/auth/domain/auth_controller.dart';
import 'package:imataapp/features/auth/login/view/widget/text.dart';
import 'package:imataapp/features/auth/login/view/widget/text_field.dart';
import 'package:imataapp/features/auth/sign_up/view/sign_up.dart';

class LogIn extends ConsumerStatefulWidget {
  static const String routename = '/login';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routename),
        builder: (context) => const LogIn());
  }

  const LogIn({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LogInState();
}

class _LogInState extends ConsumerState<LogIn> {
  @override
  Widget build(BuildContext context) {
    final loginController = ref.read(logInProvider.notifier);
    final loginState = ref.read(logInProvider);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/robot.png'),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    text('Log In', 30, FontWeight.w900, Colors.black87,
                        TextAlign.left),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      'name',
                      (value) {
                        loginController.passwordChanged(value);
                        print(loginState.email);
                      },
                      false,
                      loginState.emailController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 6.0),
                      child: text('E-mail', 20, FontWeight.bold, blackGreen,
                          TextAlign.left),
                    ),
                    CustomTextFormField('email', (value) {
                      loginController.emailChanged(value);
                      print(loginState.email);
                    }, false, loginState.emailController),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 6.0),
                      child: text('Password', 20, FontWeight.bold, blackGreen,
                          TextAlign.left),
                    ),
                    CustomTextFormField(
                      'password',
                      (value) {
                        loginController.passwordChanged(value);
                        print(loginState.password);
                      },
                      true,
                      loginState.passwordController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                        ),
                        child: text('try it !', 20, FontWeight.bold,
                            Colors.white, TextAlign.center),
                        onPressed: () {
                          // if (state.isValid) {
                          // context
                          //     .read<LogInCubit>()
                          //     .logInWithCredentials();
                          // print(state.id);
                          // print('here');
                          // Navigator.pushNamed(context, HomePage.routename);
                          // if(state.status == LogInStatus.success){
                          //   print('here');

                          // }
                          // } else {
                          // print('nice error');
                          // }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUp.routename);
                      },
                      child: text('new member ? Sign Up', 15, FontWeight.normal,
                          Colors.black87, TextAlign.center),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
