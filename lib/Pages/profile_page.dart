import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Pages/loading_page.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const ProfileDesktopPage();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return const ProfileDesktopPage();
        } else {
          return const ProileMobilePage();
        }
      },
    );
  }
}

class ProfileDesktopPage extends StatefulWidget {
  const ProfileDesktopPage({super.key});

  @override
  State<ProfileDesktopPage> createState() => _ProfileDesktopPageState();
}

class _ProfileDesktopPageState extends State<ProfileDesktopPage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            //========== HEADER WIDGET =========== //
            DesktopHeaderWidget(),

            //========== HEADER WIDGET =========== //
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  //========== SIDEBAR WIDGET ========== //
                  Expanded(flex: 1, child: DesktopSideBarWidget()),

                  //========== SIDEBAR WIDGET ========== //
                  SizedBox(width: 8),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 0.74 * height,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          80.0,
                          50.0,
                          80.0,
                          50.0,
                        ),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc(user?.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return LoadingPage();
                            }
                            return Row(
                              children: [
                                Container(
                                  height: 0.45 * height,
                                  width: 0.22 * width,
                                  color: Colors.grey[700],
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 250,
                                  ),
                                ),
                                SizedBox(width: 50),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${snapshot.data?["role"].toString().toUpperCase()}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      height: 1,
                                      width: 100,
                                      color: Colors.black,
                                    ),
                                    SizedBox(height: 40),
                                    Text(
                                      "Date created",
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "${snapshot.data?["daysignup"]} - ${snapshot.data?["monthsignup"]} - ${snapshot.data?["yearsignup"]}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Name",
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      snapshot.data?["name"],
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Email",
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      snapshot.data?["email"],
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 40),
                                    Container(
                                      height: 0.065 * height,
                                      width: 0.13 * width,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                      ),
                                      child: Text(
                                        "Edit profile",
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //================ FOOTER WIDGET =========== //
            FooterWidget(),
            //================ FOOTER WIDGET =========== //
          ],
        ),
      ),
    );
  }
}

class ProileMobilePage extends StatefulWidget {
  const ProileMobilePage({super.key});

  @override
  State<ProileMobilePage> createState() => _ProileMobilePageState();
}

class _ProileMobilePageState extends State<ProileMobilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //========== HEADER WIDGET =========== //
            HeaderMobileWidget(),

            //========== HEADER WIDGET =========== //
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(user?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return LoadingPage();
                }
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                    top: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 0.45 * height,
                        width: width,
                        color: Colors.grey[700],
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 250,
                        ),
                      ),
                      SizedBox(height: 50),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data?["role"].toString().toUpperCase()}",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(height: 1, width: 100, color: Colors.black),
                          SizedBox(height: 40),
                          Text(
                            "Date created",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "${snapshot.data?["daysignup"]} - ${snapshot.data?["monthsignup"]} - ${snapshot.data?["yearsignup"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Name",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            snapshot.data?["name"],
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Email",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            snapshot.data?["email"],
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            height: 0.065 * height,
                            width: width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),

                            child: Text(
                              "Edit profile",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterWidget(),
    );
  }
}
