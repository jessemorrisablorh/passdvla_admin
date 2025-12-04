import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Pages/hazardperception_page.dart';
import 'package:pass_dvla_admin/Pages/highway_code_page.dart';
import 'package:pass_dvla_admin/Pages/profile_page.dart';
import 'package:pass_dvla_admin/Pages/road_signs_page.dart';
import 'package:pass_dvla_admin/Pages/screen_controller_page.dart';
import 'package:pass_dvla_admin/Pages/settings_page.dart';
import 'package:pass_dvla_admin/Pages/theory_test_page.dart';
import 'package:pass_dvla_admin/Pages/users_page.dart';

class DesktopSideBarWidget extends StatefulWidget {
  const DesktopSideBarWidget({super.key});

  @override
  State<DesktopSideBarWidget> createState() => _DesktopSideBarWidgetState();
}

class _DesktopSideBarWidgetState extends State<DesktopSideBarWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 0.74 * height,
      width: 0.25 * width,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 15.0),
            child: InkWell(
              onTap: () {
                Get.offAll(
                  () => ScreenControllerPage(),
                  transition: Transition.noTransition,
                );
              },
              child: Row(
                children: [
                  Container(
                    height: 0.055 * height,
                    width: 0.055 * width,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 7,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ImageIcon(
                        AssetImage("images/home.png"),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Home",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () {
              Get.to(() => UsersPage(), transition: Transition.noTransition);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
              child: Row(
                children: [
                  Container(
                    height: 0.055 * height,
                    width: 0.055 * width,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 7,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ImageIcon(
                        AssetImage("images/group.png"),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Users",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => ProfilePage(), transition: Transition.noTransition);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
              child: Row(
                children: [
                  Container(
                    height: 0.055 * height,
                    width: 0.055 * width,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 7,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ImageIcon(
                        AssetImage("images/user.png"),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Profile",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(
                () => TheoryTestPage(),
                transition: Transition.noTransition,
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
              child: Row(
                children: [
                  Container(
                    height: 0.055 * height,
                    width: 0.055 * width,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 7,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ImageIcon(
                        AssetImage("images/right.png"),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Theory test",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(
                () => HighwayCodePage(),
                transition: Transition.noTransition,
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 15.0),
              child: Row(
                children: [
                  Container(
                    height: 0.055 * height,
                    width: 0.055 * width,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 7,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ImageIcon(
                        AssetImage("images/right.png"),

                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Highway codes",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(
                () => RoadSignsPage(),
                transition: Transition.noTransition,
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
              child: Row(
                children: [
                  Container(
                    height: 0.055 * height,
                    width: 0.055 * width,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 7,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ImageIcon(
                        AssetImage("images/right.png"),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Road signs",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(
                () => HazardperceptionPage(),
                transition: Transition.noTransition,
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
              child: Row(
                children: [
                  Container(
                    height: 0.055 * height,
                    width: 0.055 * width,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 7,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ImageIcon(
                        AssetImage("images/right.png"),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Hazard perception",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () {
              Get.to(() => SettingsPage(), transition: Transition.noTransition);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
              child: Row(
                children: [
                  Container(
                    height: 0.055 * height,
                    width: 0.055 * width,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 7,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ImageIcon(
                        AssetImage("images/settings.png"),

                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Settings",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileSideBarWidget extends StatefulWidget {
  const MobileSideBarWidget({super.key});

  @override
  State<MobileSideBarWidget> createState() => _MobileSideBarWidgetState();
}

class _MobileSideBarWidgetState extends State<MobileSideBarWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            height: 0.25 * height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                image: AssetImage("images/appicon.jpg"),
                fit: BoxFit.contain,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 15.0),
            child: InkWell(
              onTap: () {
                Get.offAll(
                  () => ScreenControllerPage(),
                  transition: Transition.noTransition,
                );
              },
              child: Row(
                children: [
                  SizedBox(width: 25),
                  ImageIcon(AssetImage("images/home.png")),
                  SizedBox(width: 15),
                  Text(
                    "Home",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () {
              Get.to(() => UsersPage(), transition: Transition.noTransition);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              child: Row(
                children: [
                  SizedBox(width: 25),
                  ImageIcon(AssetImage("images/group.png")),
                  SizedBox(width: 15),
                  Text(
                    "Users",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => ProfilePage(), transition: Transition.noTransition);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              child: Row(
                children: [
                  SizedBox(width: 25),
                  ImageIcon(AssetImage("images/user.png")),
                  SizedBox(width: 15),
                  Text(
                    "Profile",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => ProfilePage(), transition: Transition.noTransition);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              child: Row(
                children: [
                  SizedBox(width: 25),
                  ImageIcon(AssetImage("images/user.png")),
                  SizedBox(width: 15),
                  Text(
                    "Options",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () {
              Get.to(() => SettingsPage(), transition: Transition.noTransition);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              child: Row(
                children: [
                  SizedBox(width: 25),
                  ImageIcon(AssetImage("images/settings.png")),
                  SizedBox(width: 15),
                  Text(
                    "Settings",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
