import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foyer/model/DeviceProfileModel.dart';
import 'package:foyer/model/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rounded_modal/rounded_modal.dart';

import '../../AppStateProvider.dart';

class CreateProfile extends ConsumerStatefulWidget {
  final double latitude;
  final double longitude;
  const CreateProfile(
      {Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  ConsumerState createState() => _CreateProfileState(latitude, longitude);
}

class _CreateProfileState extends ConsumerState<CreateProfile> {
  TextEditingController theme = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  final double latitude;
  final double longitude;

  _CreateProfileState(this.latitude, this.longitude);
  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  Future<void> _saveDeviceProfile(BuildContext context) async {
    final appState = ref.read(appStateProvider);
    await appState.createProfile(
      _getLocationKey(widget.latitude, widget.longitude),
      DeviceProfileModel(
          email: email.text,
          themeColor: ref.read(selectedThemeColorProvider),
          phone: phone.text,
          dateInput: dateInput.text,
          gender: gender.text,
          name: name.text,
          textSize: ref.read(selectedTextSizeProvider),
          latitude: latitude,
          longitude: longitude),
    );
    ref.refresh(appStateProvider);
    ref.refresh(selectedThemeColorProvider);
    ref.refresh(enteredNameProvider);
    ref.refresh(enteredDOBProvider);
    ref.refresh(enteredGenderProvider);
    ref.refresh(enteredEmailProvider);
    ref.refresh(enteredPhoneProvider);
    ref.refresh(selectedTextSizeProvider);

    Navigator.of(context).pop();
  }

  String _getLocationKey(double latitude, double longitude) {
    return '$latitude-$longitude';
  }

  @override
  Widget build(BuildContext context) {
    final selectedThemeColor = ref.watch(selectedThemeColorProvider);
    final selectedTextSize = ref.watch(selectedTextSizeProvider);
    final enteredName = ref.watch(enteredNameProvider);

    return Container(
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      // ),
      color: const Color.fromARGB(255, 244, 242, 242),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "SignUp",
            style: GoogleFonts.openSans(
                color: Colors.black, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Theme(
          data: ThemeData(
            primaryColor:
                selectedThemeColor, // Example: Set the primary color to red
            // Add any other customizations to the theme for this page
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(
                  top: 50, right: 15, left: 15, bottom: 70),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.topCenter,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 20),
                        child: Text(
                          "Hello, " + enteredName,
                          style: GoogleFonts.openSans(
                              fontSize: selectedTextSize,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: Text(
                            "LATITUDE",
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 47,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: TextField(
                            readOnly: true,
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
                                borderSide: BorderSide(
                                  color: selectedThemeColor,
                                  width: 2,
                                ),
                              ),
                              hintStyle: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                              hintText: latitude.toString(),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: Text(
                            "LONGITUDE",
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 47,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: TextField(
                            readOnly: true,
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
                                borderSide: BorderSide(
                                  color: selectedThemeColor,
                                  width: 2,
                                ),
                              ),
                              hintStyle: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                              hintText: longitude.toString(),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: Text(
                            "THEME COLOR",
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 47,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: TextField(
                            controller: theme,
                            cursorHeight: 18,
                            cursorColor: AppColors.primaryColor,
                            readOnly: true,
                            style: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            onTap: () {
                              showModalBottomSheet<dynamic>(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  // radius: 20,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    List<Color> values = [
                                      Colors.red,
                                      Colors.blue,
                                      AppColors.primaryColor
                                    ];
                                    List<String> options = [
                                      "Red",
                                      "Blue",
                                      "Default"
                                    ];
                                    var selectedIndex;
                                    return Container(
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(25.0),
                                          topRight: const Radius.circular(25.0),
                                        ),
                                      ),
                                      height: options.length * 90 + 70,
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        150.0,
                                                        10.0,
                                                        150.0,
                                                        20.0),
                                                child: Container(
                                                  height: 8.0,
                                                  width: 120.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  8))),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  "Select Theme Color",
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              const Divider(),
                                            ],
                                          ),
                                          StatefulBuilder(builder:
                                              (BuildContext context,
                                                  StateSetter mystate) {
                                            return Container(
                                              padding: const EdgeInsets.only(
                                                  top: 75, bottom: 50),
                                              child: ListView.builder(
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                            options[index]),
                                                        leading: (selectedIndex ==
                                                                index)
                                                            ? const Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Color(
                                                                    0xFF0D47A1),
                                                              )
                                                            : const Icon(Icons
                                                                .circle_outlined),
                                                        onTap: () {
                                                          ref
                                                              .read(
                                                                  selectedThemeColorProvider
                                                                      .notifier)
                                                              .state = values[index];
                                                          theme.text =
                                                              options[index];
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      const Divider(),
                                                    ],
                                                  );
                                                },
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: selectedThemeColor,
                                  width: 2,
                                ),
                              ),
                              suffixIcon: const Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Colors.black,
                              ),
                              hintStyle: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                              hintText: 'Select Theme',
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 5),
                          child: Text(
                            "TEXT SIZE",
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Slider(
                          value: selectedTextSize,
                          onChanged: (value) {
                            ref.read(selectedTextSizeProvider.notifier).state =
                                value;
                          },
                          activeColor: selectedThemeColor,
                          inactiveColor: Colors.black12,
                          min: 12.0,
                          max: 36.0,
                          divisions: 12,
                          label: selectedTextSize.round().toString(),
                        ),
                      ],
                    ),

                    // ElevatedButton(
                    //   onPressed: () {
                    //     _saveDeviceProfile(context);
                    //   },
                    //   child: Text('Save Profile'),
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: Text(
                            "NAME",
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 47,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: TextField(
                            onChanged: (value) {
                              ref.read(enteredNameProvider.notifier).state =
                                  value;
                            },
                            controller: name,
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
                                borderSide: BorderSide(
                                  color: selectedThemeColor,
                                  width: 2,
                                ),
                              ),
                              hintStyle: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                              hintText: 'Enter name',
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
                        Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: Text(
                            "DATE OF BIRTH",
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 47,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: TextField(
                            controller: dateInput,
                            cursorHeight: 18,
                            cursorColor: AppColors.primaryColor,
                            readOnly: true,
                            style: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                helpText: "Date Of Birth",
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: selectedThemeColor,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  ref.read(enteredDOBProvider.notifier).state =
                                      formattedDate;
                                  dateInput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {}
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: selectedThemeColor,
                                  width: 2,
                                ),
                              ),
                              hintStyle: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                              hintText: 'Choose a date',
                              suffixIcon: const Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Colors.black,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
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
                        Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: Text(
                            "Gender",
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 47,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: TextField(
                            controller: gender,
                            cursorHeight: 18,
                            cursorColor: AppColors.primaryColor,
                            readOnly: true,
                            style: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    List<String> options = ["Male", "Femele"];
                                    var selectedIndex;
                                    return Container(
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(25.0),
                                          topRight: const Radius.circular(25.0),
                                        ),
                                      ),
                                      height: options.length * 90 + 70,
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        150.0,
                                                        10.0,
                                                        150.0,
                                                        20.0),
                                                child: Container(
                                                  height: 8.0,
                                                  width: 80.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  8))),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Text(
                                                  "Enter Gender",
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              const Divider(),
                                            ],
                                          ),
                                          StatefulBuilder(builder:
                                              (BuildContext context,
                                                  StateSetter mystate) {
                                            return Container(
                                              padding: const EdgeInsets.only(
                                                  top: 75, bottom: 50),
                                              child: ListView.builder(
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                            options[index]),
                                                        leading: (selectedIndex ==
                                                                index)
                                                            ? const Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Color(
                                                                    0xFF0D47A1),
                                                              )
                                                            : const Icon(Icons
                                                                .circle_outlined),
                                                        onTap: () {
                                                          gender.text =
                                                              options[index];
                                                          ref
                                                                  .read(enteredGenderProvider
                                                                      .notifier)
                                                                  .state =
                                                              options[index];
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      const Divider()
                                                    ],
                                                  );
                                                },
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: selectedThemeColor,
                                  width: 2,
                                ),
                              ),
                              suffixIcon: const Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Colors.black,
                              ),
                              hintStyle: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                              hintText: 'Select Gender',
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: Text(
                            "Email",
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 47,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: TextField(
                            onChanged: (value) {
                              ref.read(enteredEmailProvider.notifier).state =
                                  value;
                            },
                            controller: email,
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
                                borderSide: BorderSide(
                                  color: selectedThemeColor,
                                  width: 2,
                                ),
                              ),
                              hintStyle: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                              hintText: 'Enter Email',
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
                        Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: Text(
                            "Phone Number",
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 47,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: TextField(
                            controller: phone,
                            cursorHeight: 18,
                            cursorColor: AppColors.primaryColor,
                            style: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            onChanged: (value) {
                              ref.read(enteredPhoneProvider.notifier).state =
                                  value;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: selectedThemeColor,
                                  width: 2,
                                ),
                              ),
                              hintStyle: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                              hintText: 'Enter Phone Number',
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
                      height: 30,
                    ),
                  ]),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey),
            ),
          ),
          child: OutlinedButton(
            onPressed: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => FitSync()));
              _saveDeviceProfile(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: <Color>[
                    selectedThemeColor,
                    selectedThemeColor,
                    selectedThemeColor,
                  ],
                ),
              ),
              margin: EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 5),
              width: MediaQuery.of(context).size.width * 0.85,
              height: 50,
              child: Center(
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
