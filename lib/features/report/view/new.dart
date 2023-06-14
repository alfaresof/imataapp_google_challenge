import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imataapp/config/color.dart';
import 'package:imataapp/features/auth/login/view/widget/text.dart';
import 'package:imataapp/features/home/view/home.dart';
import 'package:imataapp/features/report/domain/report_controller.dart';
import 'package:imataapp/shared/textfield.dart';

class NewReport extends ConsumerStatefulWidget {
  static const String routename = '/new_report';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routename),
        builder: (context) => const NewReport());
  }

  const NewReport({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _NewReportState();
}

class _NewReportState extends ConsumerState<NewReport> {
  @override
  Widget build(BuildContext context) {
    final newReportState = ref.watch(nweReportProvider);
    final newReportController = ref.read(nweReportProvider.notifier);
    newReportController.loadModel();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, bottom: 6.0, top: 50),
                    child: text('Description', 25, FontWeight.bold,
                        Colors.black, TextAlign.left),
                  ),
                  BigCustomTextFormField(
                    'hint',
                    (value) => null,
                    false,
                    newReportState.description,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (newReportState.output.isNotEmpty)
                    Text(
                      newReportState.output[0]['label'] == '0 Full'
                          ? 'it\' full !'
                          : 'Change the photo',
                      style: TextStyle(
                        fontSize: 20,
                        color: newReportState.output[0]['label'] == '0 Full'
                            ? darkGreen
                            : Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: darkGreen),
                      ),
                      padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                    ),
                    child: Row(
                      children: [
                        text(
                            newReportState.file.path.isNotEmpty
                                ? newReportState.file.path.substring(
                                    newReportState.file.path.length - 20,
                                    newReportState.file.path.length)
                                : "Add Image",
                            20,
                            FontWeight.bold,
                            darkGreen,
                            TextAlign.start),
                        Icon(
                          Icons.image,
                          color: darkGreen,
                        )
                      ],
                    ),
                    onPressed: () async {
                      final result = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      newReportController.setImage(result!.path);
                      newReportController.classifyImage();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                    ),
                    child: text('Report', 20, FontWeight.bold, Colors.white,
                        TextAlign.center),
                    onPressed: () async {
                      if (newReportState.file.path.isNotEmpty) {
                        await newReportController
                            .uploadImageAndSetReport(ref)
                            .whenComplete(() {
                          ref.read(nweReportProvider.notifier).reset();
                          Navigator.pushReplacementNamed(
                              context, HomePage.routename);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please add an image'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
