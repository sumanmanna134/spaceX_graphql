import 'package:flutter/material.dart';
import 'package:spacex/pages/past_launches_page.dart';
import 'package:spacex/pages/upcoming_launches_page.dart';
import 'package:spacex/constants/constant.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentTab = 0;
  final tabs = [
    PastLaunches(),
    UpcomingLaunches(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (index) => setState(()=> currentTab = index),
        backgroundColor: Color(0xff353935),
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "past"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: "upcoming"
          )
        ],
      ),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          Constant.appBarHeading,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: Container(
        child: IndexedStack(
          index: currentTab,
          children: tabs,
        ),
      ),
    );
  }
}
