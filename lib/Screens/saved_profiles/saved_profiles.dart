import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foyer/AppStateProvider.dart';
import 'package:foyer/model/DeviceProfileModel.dart';
import 'package:foyer/model/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedProfiles extends ConsumerStatefulWidget {
  const SavedProfiles({Key? key}) : super(key: key);

  @override
  ConsumerState<SavedProfiles> createState() => _SavedProfilesState();
}

class _SavedProfilesState extends ConsumerState<SavedProfiles> {
  Future<Widget> getAllPrefs(WidgetRef ref) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final appState = ref.read(appStateProvider);
    List<Future<DeviceProfileModel>> prefObj = prefs
        .getKeys()
        .map<Future<DeviceProfileModel>>((key) async =>
            await DeviceProfileModel.fromJson(prefs.get(key).toString()))
        .toList(growable: false);
    return ListView.builder(
      itemCount: prefObj.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            FutureBuilder(
                future: prefObj[index],
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Container(child: Text("No Saved Profiles"));
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 3),
                          child: Text(
                            "Profile of Location " +
                                snapshot.data!.latitude.toString() +
                                ", " +
                                snapshot.data!.longitude.toString(),
                            style: GoogleFonts.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                        // height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Text("Latitude:"),
                                //     SizedBox(
                                //       width: 20,
                                //     ),
                                //     Container(
                                //         width:
                                //             MediaQuery.of(context).size.width -
                                //                 220,
                                //         child: Text(snapshot.data!.latitude
                                //             .toString())),
                                //   ],
                                // ),
                                // Divider(
                                //   color: Colors.white54,
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Text("Longitude:"),
                                //     SizedBox(
                                //       width: 20,
                                //     ),
                                //     Text(snapshot.data!.longitude.toString()),
                                //   ],
                                // ),
                                // Divider(
                                //   color: Colors.white54,
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Theme Color:",
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      snapshot.data!.themeColor.toString(),
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.white54,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Text Size:",
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      snapshot.data!.textSize.toString(),
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.white54,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name:",
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                220,
                                        child: Text(
                                          snapshot.data!.name,
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ],
                                ),
                                Divider(
                                  color: Colors.white54,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email:",
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      snapshot.data!.email,
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.white54,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Gender:",
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                220,
                                        child: Text(
                                          snapshot.data!.gender,
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ],
                                ),
                                Divider(
                                  color: Colors.white54,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Phone:",
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                220,
                                        child: Text(
                                          snapshot.data!.phone,
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                }),
          ],
        );
      },
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
                  "Saved Profiles",
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: FutureBuilder<Widget>(
                        future: getAllPrefs(ref),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Container(child: Text("No Saved Profiles"));
                          return Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: snapshot.data,
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.25,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
