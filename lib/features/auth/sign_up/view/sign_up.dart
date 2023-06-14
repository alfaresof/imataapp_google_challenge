import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imataapp/config/color.dart';
import 'package:imataapp/features/auth/domain/sign_up_controller.dart';
import 'package:imataapp/features/auth/login/view/login.dart';
import 'package:imataapp/features/auth/login/view/widget/text_field.dart';

import '../../login/view/widget/text.dart';

class SignUp extends ConsumerStatefulWidget {
  static const String routename = '/signup';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routename),
      builder: (context) => const SignUp(),
    );
  }

  const SignUp({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final signUpState = ref.watch(signUpProvider);
    final signUpController = ref.watch(signUpProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/robot.png'),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    text('Sign Up', 30, FontWeight.w900, Colors.black87,
                        TextAlign.left),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 6.0),
                      child: text('Name', 20, FontWeight.bold, blackGreen,
                          TextAlign.left),
                    ),
                    CustomTextFormField(
                      'name',
                      (value) {
                        signUpController.nameChange(value);
                        // context.read<RegisterCubit>().nameChange(value);
                        // print(state.email);
                      },
                      false,
                      signUpState.nameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 6.0),
                      child: text('E-mail', 20, FontWeight.bold, blackGreen,
                          TextAlign.left),
                    ),
                    CustomTextFormField(
                      'email',
                      (value) {
                        signUpController.emailChanged(value);
                      },
                      false,
                      signUpState.emailController,
                    ),
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
                      (value) {},
                      true,
                      signUpState.passwordController,
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
                          print(signUpState.email);
                          signUpController.registerWithCredentials(context);
                          print('nice error');
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LogIn.routename);
                      },
                      child: text('Already have an account ? LogIn', 15,
                          FontWeight.normal, Colors.black87, TextAlign.center),
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
