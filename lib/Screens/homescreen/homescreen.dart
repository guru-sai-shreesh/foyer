import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foyer/Screens/dashboard/dashboard.dart';
import 'package:foyer/Screens/profile/profile.dart';
import 'package:foyer/Screens/saved_profiles/saved_profiles.dart';
import 'package:foyer/model/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [Dashboard(), SavedProfiles()];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          selectedItemColor: AppColors.primaryColor,
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
                currentIndex = index;
              }),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: "Dashboard",
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: "Saved",
                backgroundColor: Colors.grey),
          ]),
      body: IndexedStack(
        children: screens,
        index: currentIndex,
      ),
    );
  }
  //   return MaterialApp(
  //     home: Scaffold(
  //         appBar: AppBar(
  //           title: const Text('Health Example'),
  //           actions: <Widget>[
  //             IconButton(
  //               icon: Icon(Icons.file_download),
  //               onPressed: () {
  //                 fetchData();
  //               },
  //             ),
  //             IconButton(
  //               onPressed: () {
  //                 addData();
  //               },
  //               icon: Icon(Icons.add),
  //             ),
  //             IconButton(
  //               onPressed: () {
  //                 fetchStepData();
  //               },
  //               icon: Icon(Icons.nordic_walking),
  //             )
  //           ],
  //         ),
  //         body: Center(
  //           child: _content(),
  //         )),
  //   );
  // }
}
