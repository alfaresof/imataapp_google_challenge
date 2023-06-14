import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imataapp/config/color.dart';
import 'package:imataapp/features/report/domain/report_controller.dart';

class LastReports extends ConsumerStatefulWidget {
  static const String routename = '/LastReports';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routename),
        builder: (context) => const LastReports());
  }

  const LastReports({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LastReportsState();
}

class _LastReportsState extends ConsumerState<LastReports> {
  @override
  Widget build(BuildContext context) {
    final reportsState = ref.watch(nweReportProvider);
    final user = FirebaseAuth.instance.currentUser;
    final reportsController = ref.watch(nweReportProvider.notifier);
    reportsController.getReports(ref);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Last reports',
          style: TextStyle(
            fontSize: 30,
            color: darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Wrap(
          verticalDirection: VerticalDirection.down,
          children: [
            // text of subtitle
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                user!.email.toString(),
                style: TextStyle(
                  fontSize: 10,
                  color: darkGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: reportsState.reports.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: darkGreen,
                        borderRadius: BorderRadius.circular(20)),
                    child: Image.network(
                      '${reportsState.reports[index].path}',
                      fit: BoxFit.scaleDown,
                      width: 300,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
