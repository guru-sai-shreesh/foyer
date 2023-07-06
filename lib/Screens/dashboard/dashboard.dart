import 'dart:async';
import 'dart:ffi';
import 'package:foyer/Screens/dashboard/ProfileCreationPrompt.dart';
import 'package:foyer/Screens/create_profile/create_profile.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

int count = 0;

class _DashboardState extends State<Dashboard> {
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();

  String _getLocationKey(double latitude, double longitude) {
    return '$latitude-$longitude';
  }

  Future<void> _showProfileCreationPrompt(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if ((double.parse(latitude.text) < -90 ||
            double.parse(latitude.text) > 90) ||
        (double.parse(longitude.text) < -90 ||
            double.parse(longitude.text) > 90)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Latitude and longitude are not in range"),
            content: Text("Latitude and longitude are not in range"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (prefs.containsKey(_getLocationKey(
        double.parse(latitude.text), double.parse(longitude.text)))) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Duplicate Data"),
            content: Text(
                "Following coordinates already exist. Change the Coordinates to create a profile!!"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => ProfileCreationPrompt(
          onCreateProfile: () => _navigateToProfileSetup(context),
        ),
      );
    }
  }

  void _navigateToProfileSetup(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateProfile(
            latitude: double.parse(latitude.text),
            longitude: double.parse(longitude.text)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                floating: false,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: 0,
                pinned: true,
                expandedHeight: 70,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  expandedTitleScale: 1.3,
                  titlePadding: EdgeInsets.only(left: 15, bottom: 15),
                  title: Text(
                    "Dashboard",
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications_outlined)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 47,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TextField(
                                controller: latitude,
                                cursorHeight: 18,
                                cursorColor: AppColors.primaryColor,
                                style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 68, 117, 169),
                                      width: 3,
                                    ),
                                  ),
                                  hintStyle: GoogleFonts.openSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Enter Latitude',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 47,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TextField(
                                controller: longitude,
                                cursorHeight: 18,
                                cursorColor: AppColors.primaryColor,
                                style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 68, 117, 169),
                                      width: 3,
                                    ),
                                  ),
                                  hintStyle: GoogleFonts.openSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Enter Longitude',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        print(latitude.text.toString());
                        _showProfileCreationPrompt(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                            top: 20),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 204, 204, 204),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SizedBox(
                          height: 35,
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  "Save",
                                  style: GoogleFonts.openSans(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
