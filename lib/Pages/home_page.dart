import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Pages/users_page.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const DesktopHomePage();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return const DesktopHomePage();
        } else {
          return const MobileHomePage();
        }
      },
    );
  }
}

class DesktopHomePage extends StatefulWidget {
  const DesktopHomePage({super.key});

  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {
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
                  SizedBox(width: 8.0),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 0.74 * height,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30.0,
                          top: 80.0,
                          right: 30.0,
                          bottom: 50.0,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ImageIcon(AssetImage("images/group.png")),
                                SizedBox(width: 15),
                                Text(
                                  "Users",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            Row(
                              children: [
                                Expanded(
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("users")
                                        .where("role", isEqualTo: "user")
                                        .snapshots(),
                                    builder: (context, userssnapshot) {
                                      if (!userssnapshot.hasData) {
                                        return Container(
                                          height: 0.25 * height,
                                          width: width,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 7,
                                                offset: Offset(2, 3),
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "0",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.white,
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                    Text(
                                                      "Users",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 15.0,
                                                  left: 15.0,
                                                ),
                                                child: Image.asset(
                                                  "images/user.png",
                                                  height: 0.15 * height,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return InkWell(
                                        onTap: () {
                                          Get.to(
                                            () => UsersPage(),
                                            transition: Transition.noTransition,
                                          );
                                        },
                                        child: Container(
                                          height: 0.25 * height,
                                          width: width,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 7,
                                                offset: Offset(2, 3),
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${userssnapshot.data!.docs.length}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.white,
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                    Text(
                                                      "Users",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 15.0,
                                                  left: 15.0,
                                                ),
                                                child: Image.asset(
                                                  "images/user.png",
                                                  height: 0.15 * height,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 15.0),
                                Expanded(
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("users")
                                        .where("role", isEqualTo: "admin")
                                        .snapshots(),
                                    builder: (context, adminssnapshot) {
                                      if (!adminssnapshot.hasData) {
                                        return Container(
                                          height: 0.25 * height,
                                          width: width,
                                          decoration: BoxDecoration(
                                            color: Colors.brown,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 7,
                                                offset: Offset(2, 3),
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "0",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.white,
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                    Text(
                                                      "Admins",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 15.0,
                                                  left: 15.0,
                                                ),
                                                child: Image.asset(
                                                  "images/user.png",
                                                  height: 0.15 * height,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return InkWell(
                                        onTap: () {
                                          Get.to(
                                            () => UsersPage(),
                                            transition: Transition.noTransition,
                                          );
                                        },
                                        child: Container(
                                          height: 0.25 * height,
                                          width: width,
                                          decoration: BoxDecoration(
                                            color: Colors.brown,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 7,
                                                offset: Offset(2, 3),
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${adminssnapshot.data!.docs.length}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.white,
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                    Text(
                                                      "Admins",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 15.0,
                                                  left: 15.0,
                                                ),
                                                child: Image.asset(
                                                  "images/group.png",
                                                  height: 0.15 * height,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 220),
                          ],
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

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(50),
      //   child: MobileHeaderWidget(),
      // ),
      //  drawer: MobileSideBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderMobileWidget(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where("role", isEqualTo: "user")
                    .snapshots(),
                builder: (context, userssnapshot) {
                  if (!userssnapshot.hasData) {
                    return Container(
                      height: 0.25 * height,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 7,
                            offset: Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "0",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Users",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15.0,
                              left: 15.0,
                            ),
                            child: Image.asset(
                              "images/user.png",
                              height: 0.10 * height,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      Get.to(
                        () => UsersPage(),
                        transition: Transition.noTransition,
                      );
                    },
                    child: Container(
                      height: 0.25 * height,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 7,
                            offset: Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${userssnapshot.data!.docs.length}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Users",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15.0,
                              left: 15.0,
                            ),
                            child: Image.asset(
                              "images/user.png",
                              height: 0.10 * height,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where("role", isEqualTo: "admin")
                    .snapshots(),
                builder: (context, adminssnapshot) {
                  if (!adminssnapshot.hasData) {
                    return Container(
                      height: 0.25 * height,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 7,
                            offset: Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "0",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Admins",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15.0,
                              left: 15.0,
                            ),
                            child: Image.asset(
                              "images/group.png",
                              height: 0.10 * height,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      Get.to(
                        () => UsersPage(),
                        transition: Transition.noTransition,
                      );
                    },
                    child: Container(
                      height: 0.25 * height,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 7,
                            offset: Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${adminssnapshot.data!.docs.length}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Admins",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15.0,
                              left: 15.0,
                            ),
                            child: Image.asset(
                              "images/group.png",
                              height: 0.10 * height,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterWidget(),
    );
  }
}
