import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const SettingsDesktopPage();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return const SettingsDesktopPage();
        } else {
          return const SettingsMobilePage();
        }
      },
    );
  }
}

class SettingsDesktopPage extends StatefulWidget {
  const SettingsDesktopPage({super.key});

  @override
  State<SettingsDesktopPage> createState() => _SettingsDesktopPageState();
}

class _SettingsDesktopPageState extends State<SettingsDesktopPage> {
  TextEditingController chatgptapikey = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController appverion = TextEditingController();
  bool apikeyloading = false;
  bool countryloading = false;
  bool appversionloading = false;
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
                  //========== SIDEBAR WIDGET =========== //
                  Expanded(flex: 1, child: DesktopSideBarWidget()),
                  //========== SIDEBAR WIDGET =========== //
                  SizedBox(width: 8),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 0.74 * height,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30),
                            Text(
                              "API's & Webhooks",
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 30),

                            Row(
                              children: [
                                Text(
                                  "Chat gpt api key",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 20),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("settings")
                                      .doc("apikeys")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container(
                                        height: 0.05 * height,
                                        width: 0.45 * width,

                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 15.0,
                                            right: 15.0,
                                          ),
                                          child: Text(""),
                                        ),
                                      );
                                    }
                                    return Row(
                                      children: [
                                        Container(
                                          height: 0.05 * height,
                                          width: 0.45 * width,

                                          decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                            ),
                                            child: Text(
                                              snapshot.data?["chatgptapikey"],
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
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
                                                            "API's & Webhooks",
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                          SizedBox(height: 30),
                                                          Text(
                                                            "Chat gpt api key",
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                          SizedBox(height: 30),
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
                                                                      chatgptapikey,
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
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "Api key",
                                                                    hintStyle: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 30),
                                                          InkWell(
                                                            onTap: () async {
                                                              if (apikeyloading ==
                                                                  false) {
                                                                setState(() {
                                                                  apikeyloading =
                                                                      true;
                                                                });
                                                              } else {
                                                                if (apikeyloading ==
                                                                    true) {
                                                                  setState(() {
                                                                    apikeyloading =
                                                                        false;
                                                                  });
                                                                }
                                                              }
                                                              try {
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                      "settings",
                                                                    )
                                                                    .doc(
                                                                      "apikeys",
                                                                    )
                                                                    .update({
                                                                      "chatgptapikey":
                                                                          chatgptapikey
                                                                              .text
                                                                              .isEmpty
                                                                          ? "${snapshot.data?["chatgptapikey"]}"
                                                                          : chatgptapikey.text.trim(),
                                                                    })
                                                                    .then((
                                                                      value,
                                                                    ) {
                                                                      setState(() {
                                                                        apikeyloading =
                                                                            false;
                                                                        chatgptapikey
                                                                            .clear();
                                                                      });
                                                                      Get.close(
                                                                        1,
                                                                      );
                                                                    });
                                                              } catch (e) {
                                                                setState(() {
                                                                  apikeyloading =
                                                                      false;
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              height:
                                                                  0.065 *
                                                                  height,
                                                              width:
                                                                  0.15 * width,
                                                              decoration:
                                                                  BoxDecoration(
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
                                                                  apikeyloading
                                                                  ? SizedBox(
                                                                      height:
                                                                          15,
                                                                      width: 15,
                                                                      child: CircularProgressIndicator(
                                                                        color: Colors
                                                                            .white,
                                                                        strokeWidth:
                                                                            3,
                                                                      ),
                                                                    )
                                                                  : Text(
                                                                      "Save details",
                                                                      style: GoogleFonts.poppins(
                                                                        color: Colors
                                                                            .white,
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
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Country",
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "Default country",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 20),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("settings")
                                      .doc("country")
                                      .snapshots(),
                                  builder: (context, countrysnapshot) {
                                    if (!countrysnapshot.hasData) {
                                      return Container(
                                        height: 0.05 * height,
                                        width: 0.45 * width,

                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 15.0,
                                            right: 15.0,
                                          ),
                                          child: Text(""),
                                        ),
                                      );
                                    }
                                    return Row(
                                      children: [
                                        Container(
                                          height: 0.05 * height,
                                          width: 0.25 * width,

                                          decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                            ),
                                            child: Text(
                                              countrysnapshot.data?["name"],
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
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
                                                            "Country",
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                          SizedBox(height: 30),
                                                          Text(
                                                            "Default country",
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                          SizedBox(height: 30),
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
                                                                      country,
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
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "Country",
                                                                    hintStyle: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 30),
                                                          InkWell(
                                                            onTap: () async {
                                                              if (countryloading ==
                                                                  false) {
                                                                setState(() {
                                                                  countryloading =
                                                                      true;
                                                                });
                                                              } else {
                                                                if (countryloading ==
                                                                    true) {
                                                                  setState(() {
                                                                    countryloading =
                                                                        false;
                                                                  });
                                                                }
                                                              }
                                                              try {
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                      "settings",
                                                                    )
                                                                    .doc(
                                                                      "country",
                                                                    )
                                                                    .update({
                                                                      "name":
                                                                          country
                                                                              .text
                                                                              .isEmpty
                                                                          ? "${countrysnapshot.data?["name"]}"
                                                                          : country.text.trim(),
                                                                    })
                                                                    .then((
                                                                      value,
                                                                    ) {
                                                                      setState(() {
                                                                        countryloading =
                                                                            false;
                                                                        country
                                                                            .clear();
                                                                      });
                                                                      Get.close(
                                                                        1,
                                                                      );
                                                                    });
                                                              } catch (e) {
                                                                setState(() {
                                                                  countryloading =
                                                                      false;
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              height:
                                                                  0.065 *
                                                                  height,
                                                              width:
                                                                  0.15 * width,
                                                              decoration:
                                                                  BoxDecoration(
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
                                                                  countryloading
                                                                  ? SizedBox(
                                                                      height:
                                                                          15,
                                                                      width: 15,
                                                                      child: CircularProgressIndicator(
                                                                        color: Colors
                                                                            .white,
                                                                        strokeWidth:
                                                                            3,
                                                                      ),
                                                                    )
                                                                  : Text(
                                                                      "Save details",
                                                                      style: GoogleFonts.poppins(
                                                                        color: Colors
                                                                            .white,
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
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Mobile application",
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "App version",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 20),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("settings")
                                      .doc("userapp")
                                      .snapshots(),
                                  builder: (context, appsnapshot) {
                                    if (!appsnapshot.hasData) {
                                      return Container(
                                        height: 0.05 * height,
                                        width: 0.45 * width,

                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 15.0,
                                            right: 15.0,
                                          ),
                                          child: Text(""),
                                        ),
                                      );
                                    }
                                    return Row(
                                      children: [
                                        Container(
                                          height: 0.05 * height,
                                          width: 0.25 * width,

                                          decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                            ),
                                            child: Text(
                                              appsnapshot
                                                  .data?["onlineversion"],
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
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
                                                            "Mobile application",
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                          SizedBox(height: 30),
                                                          Text(
                                                            "App version",
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                          SizedBox(height: 30),
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
                                                                      appverion,
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
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "App version",
                                                                    hintStyle: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 30),
                                                          InkWell(
                                                            onTap: () async {
                                                              if (appversionloading ==
                                                                  false) {
                                                                setState(() {
                                                                  appversionloading =
                                                                      true;
                                                                });
                                                              } else {
                                                                if (appversionloading ==
                                                                    true) {
                                                                  setState(() {
                                                                    appversionloading =
                                                                        false;
                                                                  });
                                                                }
                                                              }
                                                              try {
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                      "settings",
                                                                    )
                                                                    .doc(
                                                                      "userapp",
                                                                    )
                                                                    .update({
                                                                      "onlineversion":
                                                                          appverion
                                                                              .text
                                                                              .isEmpty
                                                                          ? "${appsnapshot.data?["onlineversion"]}"
                                                                          : appverion.text.trim(),
                                                                    })
                                                                    .then((
                                                                      value,
                                                                    ) {
                                                                      setState(() {
                                                                        appversionloading =
                                                                            false;
                                                                        appverion
                                                                            .clear();
                                                                      });
                                                                      Get.close(
                                                                        1,
                                                                      );
                                                                    });
                                                              } catch (e) {
                                                                setState(() {
                                                                  appversionloading =
                                                                      false;
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              height:
                                                                  0.065 *
                                                                  height,
                                                              width:
                                                                  0.15 * width,
                                                              decoration:
                                                                  BoxDecoration(
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
                                                                  appversionloading
                                                                  ? SizedBox(
                                                                      height:
                                                                          15,
                                                                      width: 15,
                                                                      child: CircularProgressIndicator(
                                                                        color: Colors
                                                                            .white,
                                                                        strokeWidth:
                                                                            3,
                                                                      ),
                                                                    )
                                                                  : Text(
                                                                      "Save details",
                                                                      style: GoogleFonts.poppins(
                                                                        color: Colors
                                                                            .white,
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
                                    );
                                  },
                                ),
                              ],
                            ),
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

class SettingsMobilePage extends StatefulWidget {
  const SettingsMobilePage({super.key});

  @override
  State<SettingsMobilePage> createState() => _SettingsMobilePageState();
}

class _SettingsMobilePageState extends State<SettingsMobilePage> {
  TextEditingController chatgptapikey = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController appverion = TextEditingController();
  bool apikeyloading = false;
  bool countryloading = false;
  bool appversionloading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //========== HEADER WIDGET =========== //
            HeaderMobileWidget(),

            //========== HEADER WIDGET =========== //
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Text(
                "API's & Webhooks",
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: 20.0,
              ),
              child: Text(
                "Chat gpt api key",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: 20.0,
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("settings")
                    .doc("apikeys")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      height: 0.05 * height,
                      width: 0.45 * width,

                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(""),
                      ),
                    );
                  }
                  return Row(
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
                                            "API's & Webhooks",
                                            style: GoogleFonts.poppins(
                                              color: Colors.red,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Chat gpt api key",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 13,
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
                                                  controller: chatgptapikey,
                                                  cursorHeight: 14,
                                                  cursorColor: Colors.black,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Api key",
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 20.0,
                                              right: 20.0,
                                            ),
                                            child: InkWell(
                                              onTap: () async {
                                                if (apikeyloading == false) {
                                                  setState(() {
                                                    apikeyloading = true;
                                                  });
                                                } else {
                                                  if (apikeyloading == true) {
                                                    setState(() {
                                                      apikeyloading = false;
                                                    });
                                                  }
                                                }
                                                try {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("settings")
                                                      .doc("apikeys")
                                                      .update({
                                                        "chatgptapikey":
                                                            chatgptapikey
                                                                .text
                                                                .isEmpty
                                                            ? "${snapshot.data?["chatgptapikey"]}"
                                                            : chatgptapikey.text
                                                                  .trim(),
                                                      })
                                                      .then((value) {
                                                        setState(() {
                                                          apikeyloading = false;
                                                          chatgptapikey.clear();
                                                        });
                                                        Get.close(1);
                                                      });
                                                } catch (e) {
                                                  setState(() {
                                                    apikeyloading = false;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                height: 0.065 * height,

                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                alignment: Alignment.center,
                                                child: apikeyloading
                                                    ? SizedBox(
                                                        height: 15,
                                                        width: 15,
                                                        child:
                                                            CircularProgressIndicator(
                                                              color:
                                                                  Colors.white,
                                                              strokeWidth: 3,
                                                            ),
                                                      )
                                                    : Text(
                                                        "Save details",
                                                        style:
                                                            GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white,
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
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                              ),
                              child: Text(
                                snapshot.data?["chatgptapikey"],
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: 20.0,
              ),
              child: Text(
                "Country",
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: 20.0,
              ),
              child: Text(
                "Default country",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: 20.0,
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("settings")
                    .doc("country")
                    .snapshots(),
                builder: (context, countrysnapshot) {
                  if (!countrysnapshot.hasData) {
                    return Container(
                      height: 0.05 * height,
                      width: 0.45 * width,

                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(""),
                      ),
                    );
                  }
                  return InkWell(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Country",
                                      style: GoogleFonts.poppins(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Default country",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 13,
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
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 15.0,
                                            right: 15.0,
                                          ),
                                          child: TextField(
                                            controller: country,
                                            cursorHeight: 14,
                                            cursorColor: Colors.black,
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Country",
                                              hintStyle: GoogleFonts.poppins(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20.0,
                                        right: 20.0,
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          if (countryloading == false) {
                                            setState(() {
                                              countryloading = true;
                                            });
                                          } else {
                                            if (countryloading == true) {
                                              setState(() {
                                                countryloading = false;
                                              });
                                            }
                                          }
                                          try {
                                            await FirebaseFirestore.instance
                                                .collection("settings")
                                                .doc("country")
                                                .update({
                                                  "name": country.text.isEmpty
                                                      ? "${countrysnapshot.data?["name"]}"
                                                      : country.text.trim(),
                                                })
                                                .then((value) {
                                                  setState(() {
                                                    countryloading = false;
                                                    country.clear();
                                                  });
                                                  Get.close(1);
                                                });
                                          } catch (e) {
                                            setState(() {
                                              countryloading = false;
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 0.065 * height,
                                          width: width,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: countryloading
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
                                                    fontWeight: FontWeight.w600,
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
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(
                          countrysnapshot.data?["name"],
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: 20.0,
              ),
              child: Text(
                "Mobile application",
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: 20.0,
              ),
              child: Text(
                "App version",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: 20.0,
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("settings")
                    .doc("userapp")
                    .snapshots(),
                builder: (context, appsnapshot) {
                  if (!appsnapshot.hasData) {
                    return Container(
                      height: 0.05 * height,
                      width: 0.45 * width,

                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(""),
                      ),
                    );
                  }
                  return InkWell(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Mobile application",
                                      style: GoogleFonts.poppins(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "App version",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 13,
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
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 15.0,
                                            right: 15.0,
                                          ),
                                          child: TextField(
                                            controller: appverion,
                                            cursorHeight: 14,
                                            cursorColor: Colors.black,
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "App version",
                                              hintStyle: GoogleFonts.poppins(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20.0,
                                        right: 20.0,
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          if (appversionloading == false) {
                                            setState(() {
                                              appversionloading = true;
                                            });
                                          } else {
                                            if (appversionloading == true) {
                                              setState(() {
                                                appversionloading = false;
                                              });
                                            }
                                          }
                                          try {
                                            await FirebaseFirestore.instance
                                                .collection("settings")
                                                .doc("userapp")
                                                .update({
                                                  "onlineversion":
                                                      appverion.text.isEmpty
                                                      ? "${appsnapshot.data?["onlineversion"]}"
                                                      : appverion.text.trim(),
                                                })
                                                .then((value) {
                                                  setState(() {
                                                    appversionloading = false;
                                                    appverion.clear();
                                                  });
                                                  Get.close(1);
                                                });
                                          } catch (e) {
                                            setState(() {
                                              appversionloading = false;
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 0.065 * height,
                                          width: width,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: appversionloading
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
                                                    fontWeight: FontWeight.w600,
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
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(
                          appsnapshot.data?["onlineversion"],
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
