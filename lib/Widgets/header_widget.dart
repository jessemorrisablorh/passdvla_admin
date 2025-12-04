import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Pages/hazardperception_page.dart';
import 'package:pass_dvla_admin/Pages/highway_code_page.dart';
import 'package:pass_dvla_admin/Pages/home_page.dart';
import 'package:pass_dvla_admin/Pages/login_page.dart';
import 'package:pass_dvla_admin/Pages/profile_page.dart';
import 'package:pass_dvla_admin/Pages/road_signs_page.dart';
import 'package:pass_dvla_admin/Pages/settings_page.dart';
import 'package:pass_dvla_admin/Pages/theory_test_page.dart';
import 'package:pass_dvla_admin/Pages/users_page.dart';

class DesktopHeaderWidget extends StatefulWidget {
  const DesktopHeaderWidget({super.key});

  @override
  State<DesktopHeaderWidget> createState() => _DesktopHeaderWidgetState();
}

class _DesktopHeaderWidgetState extends State<DesktopHeaderWidget> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(user?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 0.15 * height,
            width: width,
            color: Colors.white,
          );
        }
        return Container(
          height: 0.15 * height,
          width: width,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 40),
                  Image.asset("images/appicon.jpg", height: 0.080 * height),
                  SizedBox(width: 20),
                  Text(
                    "Welcome ${snapshot.data?["name"]}",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Get.dialog(
                    Dialog(
                      child: Container(
                        height: 0.40 * height,
                        width: 0.35 * width,
                        decoration: BoxDecoration(color: Colors.white),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 0.070 * height,
                              width: 0.070 * width,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 7,
                                    offset: Offset(1, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ImageIcon(
                                  AssetImage("images/_.png"),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              "You are about signing out\ndo you want to proceed ?",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            InkWell(
                              onTap: () async {
                                await FirebaseAuth.instance.signOut().then((
                                  value,
                                ) {
                                  Get.offAll(
                                    () => LoginPage(),
                                    transition: Transition.noTransition,
                                  );
                                });
                              },
                              child: Container(
                                height: 0.070 * height,
                                width: 0.20 * width,

                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(7),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 7,
                                      offset: Offset(1, 2),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Proceed",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 80.0),
                  child: Row(
                    children: [
                      SizedBox(width: 25),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ImageIcon(
                            AssetImage("images/_.png"),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Sign out",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class HeaderMobileWidget extends StatefulWidget {
  const HeaderMobileWidget({super.key});

  @override
  State<HeaderMobileWidget> createState() => _HeaderMobileWidgetState();
}

class _HeaderMobileWidgetState extends State<HeaderMobileWidget> {
  bool menupressed = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: 0.15 * height,
          width: width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (menupressed == false) {
                          setState(() {
                            menupressed = true;
                          });
                        } else {
                          if (menupressed == true) {
                            setState(() {
                              menupressed = false;
                            });
                          }
                        }
                      },
                      child: Icon(
                        menupressed == true ? Icons.close : Icons.menu,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Welcome Admin",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                InkWell(
                  onTap: () {},
                  child: Image.asset("images/_.png", height: 0.035 * height),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: menupressed == true,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Get.offAll(
                      () => HomePage(),
                      transition: Transition.noTransition,
                    );
                  },
                  child: SizedBox(
                    height: 0.055 * height,
                    width: width,
                    child: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(
                      () => UsersPage(),
                      transition: Transition.noTransition,
                    );
                  },
                  child: SizedBox(
                    height: 0.055 * height,
                    child: Text(
                      "Users",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(
                      () => ProfilePage(),
                      transition: Transition.noTransition,
                    );
                  },
                  child: SizedBox(
                    height: 0.055 * height,
                    child: Text(
                      "Profile",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(
                      () => TheoryTestPage(),
                      transition: Transition.noTransition,
                    );
                  },
                  child: SizedBox(
                    height: 0.055 * height,
                    child: Text(
                      "Theory test",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(
                      () => HighwayCodePage(),
                      transition: Transition.noTransition,
                    );
                  },
                  child: SizedBox(
                    height: 0.055 * height,
                    child: Text(
                      "Highway codes",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(
                      () => RoadSignsPage(),
                      transition: Transition.noTransition,
                    );
                  },
                  child: SizedBox(
                    height: 0.055 * height,
                    child: Text(
                      "Road signs",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(
                      () => HazardperceptionPage(),
                      transition: Transition.noTransition,
                    );
                  },
                  child: SizedBox(
                    height: 0.055 * height,
                    child: Text(
                      "Hazard perception",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(
                      () => SettingsPage(),
                      transition: Transition.noTransition,
                    );
                  },
                  child: SizedBox(
                    height: 0.055 * height,
                    child: Text(
                      "Settings",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
