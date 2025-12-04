import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class HazardPerceptionIntroductionVideoPage extends StatefulWidget {
  const HazardPerceptionIntroductionVideoPage({super.key});

  @override
  State<HazardPerceptionIntroductionVideoPage> createState() =>
      _HazardPerceptionIntroductionVideoPageState();
}

class _HazardPerceptionIntroductionVideoPageState
    extends State<HazardPerceptionIntroductionVideoPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const DesktopHPIntroductionVideoPage();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return const DesktopHPIntroductionVideoPage();
        } else {
          return const MobileHPIntroductionVideoPage();
        }
      },
    );
  }
}

class DesktopHPIntroductionVideoPage extends StatefulWidget {
  const DesktopHPIntroductionVideoPage({super.key});

  @override
  State<DesktopHPIntroductionVideoPage> createState() =>
      _DesktopHPIntroductionVideoPageState();
}

class _DesktopHPIntroductionVideoPageState
    extends State<DesktopHPIntroductionVideoPage> {
  bool loading = false;
  TextEditingController videoid = TextEditingController();
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
                        padding: const EdgeInsets.only(left: 50.0, top: 50.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Introduction video ID",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("hazardperception")
                                  .doc("introduction")
                                  .snapshots(),
                              builder: (context, asyncSnapshot) {
                                if (!asyncSnapshot.hasData) {
                                  return Text("");
                                }
                                return Row(
                                  children: [
                                    Text(
                                      asyncSnapshot.data?["video"],
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
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
                                                  width: 0.40 * width,
                                                  height: 0.40 * height,
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                              left: 50.0,
                                                              right: 50.0,
                                                              bottom: 30.0,
                                                            ),
                                                        child: TextField(
                                                          controller: videoid,
                                                          style:
                                                              GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                          decoration: InputDecoration(
                                                            hintText:
                                                                "Video ID",
                                                            hintStyle:
                                                                GoogleFonts.poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          if (loading ==
                                                              false) {
                                                            setState(() {
                                                              loading = true;
                                                            });
                                                          } else {
                                                            if (loading ==
                                                                true) {
                                                              setState(() {
                                                                loading = false;
                                                              });
                                                            }
                                                          }
                                                          try {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                  "hazardperception",
                                                                )
                                                                .doc(
                                                                  "introduction",
                                                                )
                                                                .update({
                                                                  "video":
                                                                      videoid
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? videoid
                                                                            .text
                                                                            .trim()
                                                                      : asyncSnapshot
                                                                            .data?["video"],
                                                                })
                                                                .then((value) {
                                                                  setState(() {
                                                                    loading =
                                                                        false;
                                                                    videoid
                                                                        .clear();
                                                                  });
                                                                  Get.snackbar(
                                                                    "",
                                                                    "",
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green,
                                                                    titleText: Text(
                                                                      "Success!",
                                                                      style: GoogleFonts.poppins(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    messageText: Text(
                                                                      "Video id edited successfully",
                                                                      style: GoogleFonts.poppins(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  );
                                                                  Get.close(1);
                                                                });
                                                          } catch (e) {
                                                            print(e.toString());
                                                            setState(() {
                                                              loading = false;
                                                            });
                                                            Get.snackbar(
                                                              "",
                                                              "",
                                                              backgroundColor:
                                                                  Colors.red,
                                                              titleText: Text(
                                                                "Error!",
                                                                style: GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              messageText: Text(
                                                                "Try again later",
                                                                style: GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Container(
                                                          height:
                                                              0.070 * height,
                                                          width: 0.20 * width,
                                                          decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  5,
                                                                ),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: loading
                                                              ? SizedBox(
                                                                  height: 13,
                                                                  width: 13,
                                                                  child: CircularProgressIndicator(
                                                                    color: Colors
                                                                        .white,
                                                                    strokeWidth:
                                                                        3,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "Save id",
                                                                  style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                      child: Icon(
                                        Icons.edit_note,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                );
                              },
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

class MobileHPIntroductionVideoPage extends StatefulWidget {
  const MobileHPIntroductionVideoPage({super.key});

  @override
  State<MobileHPIntroductionVideoPage> createState() =>
      _MobileHPIntroductionVideoPageState();
}

class _MobileHPIntroductionVideoPageState
    extends State<MobileHPIntroductionVideoPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
