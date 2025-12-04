import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Pages/loading_page.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class UserDetailsPage extends StatefulWidget {
  final String uid;
  const UserDetailsPage({super.key, required this.uid});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return UserDetailsDesktopPage(uid: widget.uid);
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return UserDetailsDesktopPage(uid: widget.uid);
        } else {
          return UserDetailsMobilePage(uid: widget.uid);
        }
      },
    );
  }
}

class UserDetailsDesktopPage extends StatefulWidget {
  final String uid;
  const UserDetailsDesktopPage({super.key, required this.uid});

  @override
  State<UserDetailsDesktopPage> createState() => _UserDetailsDesktopPageState();
}

class _UserDetailsDesktopPageState extends State<UserDetailsDesktopPage> {
  TextEditingController name = TextEditingController();
  final roles = <String>['Admin', 'User'];
  bool nameloading = false;
  bool roleloading = false;
  bool resetpassword = false;
  bool blockuser = false;
  String? selectedValue;
  bool blocked = false;

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
                  Expanded(flex: 1, child: DesktopSideBarWidget()),
                  SizedBox(width: 8.0),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 0.74 * height,
                      color: Colors.white,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(widget.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return LoadingPage();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 80.0,
                              right: 80.0,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 0.45 * height,
                                  width: 0.23 * width,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name",
                                        style: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data?["name"],
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          InkWell(
                                            onTap: () {
                                              Get.dialog(
                                                StatefulBuilder(
                                                  builder: (context, setState) {
                                                    return Dialog(
                                                      child: Container(
                                                        height: 0.40 * height,
                                                        width: 0.50 * width,
                                                        color: Colors.white,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Name",
                                                              style: GoogleFonts.poppins(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets.only(
                                                                    left: 50.0,
                                                                    right: 50.0,
                                                                  ),
                                                              child: Container(
                                                                width: width,
                                                                height:
                                                                    0.065 *
                                                                    height,
                                                                decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey[300],
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        5,
                                                                      ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets.only(
                                                                        left:
                                                                            15.0,
                                                                        right:
                                                                            15.0,
                                                                      ),
                                                                  child: TextField(
                                                                    controller:
                                                                        name,
                                                                    cursorHeight:
                                                                        14,
                                                                    cursorColor:
                                                                        Colors
                                                                            .black,
                                                                    style: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    decoration: InputDecoration(
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintText:
                                                                          "Name",
                                                                      hintStyle: GoogleFonts.poppins(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            InkWell(
                                                              onTap: () async {
                                                                if (nameloading ==
                                                                    false) {
                                                                  setState(() {
                                                                    nameloading =
                                                                        true;
                                                                  });
                                                                } else {
                                                                  if (nameloading ==
                                                                      true) {
                                                                    setState(() {
                                                                      nameloading =
                                                                          false;
                                                                    });
                                                                  }
                                                                }
                                                                try {
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                        "users",
                                                                      )
                                                                      .doc(
                                                                        widget
                                                                            .uid,
                                                                      )
                                                                      .update({
                                                                        "name":
                                                                            name.text.isEmpty
                                                                            ? "${snapshot.data?["name"]}"
                                                                            : name.text.trim(),
                                                                      })
                                                                      .then((
                                                                        value,
                                                                      ) {
                                                                        setState(() {
                                                                          nameloading =
                                                                              false;
                                                                          name.clear();
                                                                        });
                                                                        Get.close(
                                                                          1,
                                                                        );
                                                                      });
                                                                } catch (e) {
                                                                  setState(() {
                                                                    nameloading =
                                                                        false;
                                                                  });
                                                                }
                                                              },
                                                              child: Container(
                                                                height:
                                                                    0.065 *
                                                                    height,
                                                                width:
                                                                    0.15 *
                                                                    width,
                                                                decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .red,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        5,
                                                                      ),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    nameloading
                                                                    ? SizedBox(
                                                                        height:
                                                                            15,
                                                                        width:
                                                                            15,
                                                                        child: CircularProgressIndicator(
                                                                          color:
                                                                              Colors.white,
                                                                          strokeWidth:
                                                                              3,
                                                                        ),
                                                                      )
                                                                    : Text(
                                                                        "Save details",
                                                                        style: GoogleFonts.poppins(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Edit",
                                              style: GoogleFonts.poppins(
                                                color: Colors.red,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Email",
                                        style: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data?["email"],
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Password",
                                        style: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        snapshot.data?["password"],
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Role",
                                        style: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data?["role"],
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          InkWell(
                                            onTap: () {
                                              Get.dialog(
                                                StatefulBuilder(
                                                  builder: (context, setState) {
                                                    return Dialog(
                                                      child: Container(
                                                        height: 0.40 * height,
                                                        width: 0.50 * width,
                                                        color: Colors.white,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Role",
                                                              style: GoogleFonts.poppins(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            DropdownButton<
                                                              String
                                                            >(
                                                              dropdownColor:
                                                                  Colors.white,
                                                              value:
                                                                  selectedValue,
                                                              hint: Text(
                                                                "All roles",
                                                                style: GoogleFonts.poppins(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              items: roles.map((
                                                                item,
                                                              ) {
                                                                return DropdownMenuItem(
                                                                  value: item,
                                                                  child: Text(
                                                                    item,
                                                                    style: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  selectedValue =
                                                                      value;
                                                                });
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            InkWell(
                                                              onTap: () async {
                                                                if (roleloading ==
                                                                    false) {
                                                                  setState(() {
                                                                    roleloading =
                                                                        true;
                                                                  });
                                                                } else {
                                                                  if (roleloading ==
                                                                      true) {
                                                                    setState(() {
                                                                      roleloading =
                                                                          false;
                                                                    });
                                                                  }
                                                                }
                                                                try {
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                        "users",
                                                                      )
                                                                      .doc(
                                                                        widget
                                                                            .uid,
                                                                      )
                                                                      .update({
                                                                        "role":
                                                                            selectedValue ==
                                                                                ""
                                                                            ? "${snapshot.data?["role"]}"
                                                                            : selectedValue!.toLowerCase(),
                                                                      })
                                                                      .then((
                                                                        value,
                                                                      ) {
                                                                        setState(() {
                                                                          roleloading =
                                                                              false;
                                                                        });
                                                                        Get.close(
                                                                          1,
                                                                        );
                                                                      });
                                                                } catch (e) {
                                                                  setState(() {
                                                                    roleloading =
                                                                        false;
                                                                  });
                                                                }
                                                              },
                                                              child: Container(
                                                                height:
                                                                    0.065 *
                                                                    height,
                                                                width:
                                                                    0.15 *
                                                                    width,
                                                                decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .red,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        5,
                                                                      ),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    roleloading
                                                                    ? SizedBox(
                                                                        height:
                                                                            15,
                                                                        width:
                                                                            15,
                                                                        child: CircularProgressIndicator(
                                                                          color:
                                                                              Colors.white,
                                                                          strokeWidth:
                                                                              3,
                                                                        ),
                                                                      )
                                                                    : Text(
                                                                        "Save details",
                                                                        style: GoogleFonts.poppins(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Edit",
                                              style: GoogleFonts.poppins(
                                                color: Colors.red,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 30),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.dialog(
                                                StatefulBuilder(
                                                  builder: (context, setState) {
                                                    return Dialog(
                                                      child: Container(
                                                        height: 0.40 * height,
                                                        width: 0.50 * width,
                                                        color: Colors.white,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Password reset",
                                                              style: GoogleFonts.poppins(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Text(
                                                              "A password reset link will be sent to ${snapshot.data?["email"]}",
                                                              style: GoogleFonts.poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            InkWell(
                                                              onTap: () async {
                                                                if (resetpassword ==
                                                                    false) {
                                                                  setState(() {
                                                                    resetpassword =
                                                                        true;
                                                                  });
                                                                } else {
                                                                  if (resetpassword ==
                                                                      true) {
                                                                    setState(() {
                                                                      resetpassword =
                                                                          false;
                                                                    });
                                                                  }
                                                                }
                                                                try {
                                                                  await FirebaseAuth
                                                                      .instance
                                                                      .sendPasswordResetEmail(
                                                                        email: snapshot
                                                                            .data?["email"],
                                                                      )
                                                                      .then((
                                                                        value,
                                                                      ) {
                                                                        setState(() {
                                                                          resetpassword =
                                                                              false;
                                                                        });
                                                                        Get.close(
                                                                          1,
                                                                        );
                                                                      });
                                                                } catch (e) {
                                                                  setState(() {
                                                                    resetpassword =
                                                                        false;
                                                                  });
                                                                }
                                                              },
                                                              child: Container(
                                                                height:
                                                                    0.065 *
                                                                    height,
                                                                width:
                                                                    0.15 *
                                                                    width,
                                                                decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .red,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        5,
                                                                      ),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    resetpassword
                                                                    ? SizedBox(
                                                                        height:
                                                                            15,
                                                                        width:
                                                                            15,
                                                                        child: CircularProgressIndicator(
                                                                          color:
                                                                              Colors.white,
                                                                          strokeWidth:
                                                                              3,
                                                                        ),
                                                                      )
                                                                    : Text(
                                                                        "Save reset link",
                                                                        style: GoogleFonts.poppins(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 0.065 * height,
                                              width: 0.15 * width,
                                              decoration: BoxDecoration(
                                                color: Colors.brown,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Reset password",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 15.0),
                                          InkWell(
                                            onTap: () {
                                              Get.dialog(
                                                StatefulBuilder(
                                                  builder: (context, setState) {
                                                    return Dialog(
                                                      child: Container(
                                                        height: 0.40 * height,
                                                        width: 0.50 * width,
                                                        color: Colors.white,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Block user",
                                                              style: GoogleFonts.poppins(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Switch(
                                                              value: blocked,
                                                              onChanged: (value) {
                                                                if (blocked ==
                                                                    false) {
                                                                  setState(() {
                                                                    blocked =
                                                                        true;
                                                                  });
                                                                } else {
                                                                  if (blocked ==
                                                                      true) {
                                                                    setState(() {
                                                                      blocked =
                                                                          false;
                                                                    });
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            InkWell(
                                                              onTap: () async {
                                                                if (blockuser ==
                                                                    false) {
                                                                  setState(() {
                                                                    blockuser =
                                                                        true;
                                                                  });
                                                                } else {
                                                                  if (blockuser ==
                                                                      true) {
                                                                    setState(() {
                                                                      blockuser =
                                                                          false;
                                                                    });
                                                                  }
                                                                }
                                                                try {
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                        "users",
                                                                      )
                                                                      .doc(
                                                                        widget
                                                                            .uid,
                                                                      )
                                                                      .update({
                                                                        "blocked":
                                                                            blocked,
                                                                      })
                                                                      .then((
                                                                        value,
                                                                      ) {
                                                                        setState(() {
                                                                          blockuser =
                                                                              false;
                                                                        });
                                                                        Get.close(
                                                                          1,
                                                                        );
                                                                      });
                                                                } catch (e) {
                                                                  setState(() {
                                                                    blockuser =
                                                                        false;
                                                                  });
                                                                }
                                                              },
                                                              child: Container(
                                                                height:
                                                                    0.065 *
                                                                    height,
                                                                width:
                                                                    0.15 *
                                                                    width,
                                                                decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .red,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        5,
                                                                      ),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: blockuser
                                                                    ? SizedBox(
                                                                        height:
                                                                            15,
                                                                        width:
                                                                            15,
                                                                        child: CircularProgressIndicator(
                                                                          color:
                                                                              Colors.white,
                                                                          strokeWidth:
                                                                              3,
                                                                        ),
                                                                      )
                                                                    : Text(
                                                                        "Save details",
                                                                        style: GoogleFonts.poppins(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 0.065 * height,
                                              width: 0.15 * width,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Block user",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Container(
                                        height: 0.065 * height,
                                        width: 0.15 * width,
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Check progress",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //========== FOOTER ================== //
            FooterWidget(),
            //========== FOOTER ================== //
          ],
        ),
      ),
    );
  }
}

class UserDetailsMobilePage extends StatefulWidget {
  final String uid;
  const UserDetailsMobilePage({super.key, required this.uid});

  @override
  State<UserDetailsMobilePage> createState() => _UserDetailsMobilePageState();
}

class _UserDetailsMobilePageState extends State<UserDetailsMobilePage> {
  TextEditingController name = TextEditingController();
  final roles = <String>['Admin', 'User'];
  bool nameloading = false;
  bool roleloading = false;
  bool resetpassword = false;
  bool blockuser = false;
  String? selectedValue;
  bool blocked = false;

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
                  .doc(widget.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return LoadingPage();
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 0.45 * height,
                        width: width,
                        decoration: BoxDecoration(color: Colors.black),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Name",
                        style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      InkWell(
                        onTap: () {
                          Get.dialog(
                            StatefulBuilder(
                              builder: (context, setState) {
                                return Dialog(
                                  child: Container(
                                    height: 0.40 * height,
                                    width: 0.50 * width,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Name",
                                          style: GoogleFonts.poppins(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 15.0,
                                            right: 15.0,
                                          ),
                                          child: Container(
                                            width: width,
                                            height: 0.065 * height,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 15.0,
                                                right: 15.0,
                                              ),
                                              child: TextField(
                                                controller: name,
                                                cursorHeight: 14,
                                                cursorColor: Colors.black,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "Name",
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        InkWell(
                                          onTap: () async {
                                            if (nameloading == false) {
                                              setState(() {
                                                nameloading = true;
                                              });
                                            } else {
                                              if (nameloading == true) {
                                                setState(() {
                                                  nameloading = false;
                                                });
                                              }
                                            }
                                            try {
                                              await FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(widget.uid)
                                                  .update({
                                                    "name": name.text.isEmpty
                                                        ? "${snapshot.data?["name"]}"
                                                        : name.text.trim(),
                                                  })
                                                  .then((value) {
                                                    setState(() {
                                                      nameloading = false;
                                                      name.clear();
                                                    });
                                                    Get.close(1);
                                                  });
                                            } catch (e) {
                                              setState(() {
                                                nameloading = false;
                                              });
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 20.0,
                                              right: 20.0,
                                            ),
                                            child: Container(
                                              height: 0.065 * height,
                                              width: width,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              alignment: Alignment.center,
                                              child: nameloading
                                                  ? SizedBox(
                                                      height: 15,
                                                      width: 15,
                                                      child:
                                                          CircularProgressIndicator(
                                                            color: Colors.white,
                                                            strokeWidth: 3,
                                                          ),
                                                    )
                                                  : Text(
                                                      "Save details",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.white,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          snapshot.data?["name"],
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Text(
                        "Email",
                        style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            snapshot.data?["email"],
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Password",
                        style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        snapshot.data?["password"],
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Role",
                        style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      InkWell(
                        onTap: () {
                          Get.dialog(
                            StatefulBuilder(
                              builder: (context, setState) {
                                return Dialog(
                                  child: Container(
                                    height: 0.40 * height,
                                    width: 0.50 * width,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Role",
                                          style: GoogleFonts.poppins(
                                            color: Colors.red,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        SizedBox(height: 30),
                                        DropdownButton<String>(
                                          dropdownColor: Colors.white,
                                          value: selectedValue,
                                          hint: Text(
                                            "All roles",
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          items: roles.map((item) {
                                            return DropdownMenuItem(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValue = value;
                                            });
                                          },
                                        ),
                                        SizedBox(height: 30),
                                        InkWell(
                                          onTap: () async {
                                            if (roleloading == false) {
                                              setState(() {
                                                roleloading = true;
                                              });
                                            } else {
                                              if (roleloading == true) {
                                                setState(() {
                                                  roleloading = false;
                                                });
                                              }
                                            }
                                            try {
                                              await FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(widget.uid)
                                                  .update({
                                                    "role": selectedValue == ""
                                                        ? "${snapshot.data?["role"]}"
                                                        : selectedValue!
                                                              .toLowerCase(),
                                                  })
                                                  .then((value) {
                                                    setState(() {
                                                      roleloading = false;
                                                    });
                                                    Get.close(1);
                                                  });
                                            } catch (e) {
                                              setState(() {
                                                roleloading = false;
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: 0.065 * height,
                                            width: 0.15 * width,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            alignment: Alignment.center,
                                            child: roleloading
                                                ? SizedBox(
                                                    height: 15,
                                                    width: 15,
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: Colors.white,
                                                          strokeWidth: 3,
                                                        ),
                                                  )
                                                : Text(
                                                    "Save details",
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          snapshot.data?["role"],
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.dialog(
                                  StatefulBuilder(
                                    builder: (context, setState) {
                                      return Dialog(
                                        child: Container(
                                          height: 0.40 * height,
                                          width: 0.50 * width,
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Password reset",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),

                                              SizedBox(height: 20),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 15.0,
                                                ),
                                                child: Text(
                                                  "A password reset link will be sent to ${snapshot.data?["email"]}",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 30),
                                              InkWell(
                                                onTap: () async {
                                                  if (resetpassword == false) {
                                                    setState(() {
                                                      resetpassword = true;
                                                    });
                                                  } else {
                                                    if (resetpassword == true) {
                                                      setState(() {
                                                        resetpassword = false;
                                                      });
                                                    }
                                                  }
                                                  try {
                                                    await FirebaseAuth.instance
                                                        .sendPasswordResetEmail(
                                                          email: snapshot
                                                              .data?["email"],
                                                        )
                                                        .then((value) {
                                                          setState(() {
                                                            resetpassword =
                                                                false;
                                                          });
                                                          Get.close(1);
                                                        });
                                                  } catch (e) {
                                                    setState(() {
                                                      resetpassword = false;
                                                    });
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        left: 20.0,
                                                        right: 20.0,
                                                      ),
                                                  child: Container(
                                                    height: 0.065 * height,
                                                    width: width,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: resetpassword
                                                        ? SizedBox(
                                                            height: 15,
                                                            width: 15,
                                                            child:
                                                                CircularProgressIndicator(
                                                                  color: Colors
                                                                      .white,
                                                                  strokeWidth:
                                                                      3,
                                                                ),
                                                          )
                                                        : Text(
                                                            "Save reset link",
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                height: 0.065 * height,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Colors.brown,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Reset password",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15.0),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.dialog(
                                  StatefulBuilder(
                                    builder: (context, setState) {
                                      return Dialog(
                                        child: Container(
                                          height: 0.40 * height,
                                          width: 0.50 * width,
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Block user",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),

                                              SizedBox(height: 20),
                                              Switch(
                                                value: blocked,
                                                onChanged: (value) {
                                                  if (blocked == false) {
                                                    setState(() {
                                                      blocked = true;
                                                    });
                                                  } else {
                                                    if (blocked == true) {
                                                      setState(() {
                                                        blocked = false;
                                                      });
                                                    }
                                                  }
                                                },
                                              ),
                                              SizedBox(height: 20),
                                              InkWell(
                                                onTap: () async {
                                                  if (blockuser == false) {
                                                    setState(() {
                                                      blockuser = true;
                                                    });
                                                  } else {
                                                    if (blockuser == true) {
                                                      setState(() {
                                                        blockuser = false;
                                                      });
                                                    }
                                                  }
                                                  try {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection("users")
                                                        .doc(widget.uid)
                                                        .update({
                                                          "blocked": blocked,
                                                        })
                                                        .then((value) {
                                                          setState(() {
                                                            blockuser = false;
                                                          });
                                                          Get.close(1);
                                                        });
                                                  } catch (e) {
                                                    setState(() {
                                                      blockuser = false;
                                                    });
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        left: 20.0,
                                                        right: 20.0,
                                                      ),
                                                  child: Container(
                                                    height: 0.065 * height,
                                                    width: width,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: blockuser
                                                        ? SizedBox(
                                                            height: 15,
                                                            width: 15,
                                                            child:
                                                                CircularProgressIndicator(
                                                                  color: Colors
                                                                      .white,
                                                                  strokeWidth:
                                                                      3,
                                                                ),
                                                          )
                                                        : Text(
                                                            "Save details",
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                height: 0.065 * height,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Block user",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 0.065 * height,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Check progress",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
