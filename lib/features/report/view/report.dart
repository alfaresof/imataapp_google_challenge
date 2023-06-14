import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imataapp/config/color.dart';
import 'package:imataapp/features/auth/domain/auth_controller.dart';
import 'package:imataapp/features/auth/domain/sign_up_controller.dart';
import 'package:imataapp/features/auth/login/view/widget/text.dart';
import 'package:imataapp/features/report/view/new.dart';
import 'package:imataapp/shared/dialog.dart';

class Report extends ConsumerStatefulWidget {
  const Report({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ReportState();
}

class _ReportState extends ConsumerState<Report> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    final loginState = ref.watch(logInProvider);
    final signUpState = ref.watch(signUpProvider);
    return Scaffold(
      appBar: AppBar(
        title: text(
            'Explore', 30, FontWeight.bold, Colors.black87, TextAlign.center),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: text('report', 25, FontWeight.normal, Colors.black87,
                  TextAlign.left),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                width: width / 1.2,
                height: height / 1.45,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    color: lightGreen, borderRadius: BorderRadius.circular(20)),
                child: Stack(children: [
                  Center(child: Image.asset('assets/3d_hand.png')),
                  Padding(
                    padding:
                        EdgeInsets.only(top: height / 8, left: width / 3.5),
                    child: Image.asset('assets/rubbish.png'),
                  ),
                  ClipRect(
                    clipBehavior: Clip.hardEdge,
                    child: OverflowBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: width / 1,
                            height: height / 6.3,
                            decoration: BoxDecoration(
                                color: darkGrey.withOpacity(0.6),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: Column(
                              children: <Widget>[
                                text(
                                    'Help us spot the plump trash by scanning it!',
                                    20,
                                    FontWeight.normal,
                                    Colors.white,
                                    TextAlign.center),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: darkGreen,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.fromLTRB(
                                        60, 10, 60, 10),
                                  ),
                                  child: text('try it !', 20, FontWeight.bold,
                                      Colors.white, TextAlign.center),
                                  onPressed: () {
                                    if (loginState.id.isNotEmpty ||
                                        signUpState.id.isNotEmpty) {
                                      Navigator.pushNamed(
                                          context, NewReport.routename);
                                    } else {
                                      dialogBuilder(context);
                                    }
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
