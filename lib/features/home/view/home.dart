import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imataapp/config/color.dart';
import 'package:imataapp/features/last_report/view/last_report.dart';
import 'package:imataapp/features/report/view/report.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String routename = '/home';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routename),
        builder: (context) => HomePage());
  }

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<Widget> widgets = const [Report(), LastReports()];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(size: 28, Icons.house_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(size: 28, Icons.restore_page_outlined),
            label: '',
          ),
        ],
        selectedItemColor: darkGreen,
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index),
      ),
    );
  }
}
