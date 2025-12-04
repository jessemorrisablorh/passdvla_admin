import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Pages/edit_highway_code_point_page.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class HighwayCodesPointsPage extends StatefulWidget {
  final String id;
  final String docid;
  final String point;
  final String title;
  const HighwayCodesPointsPage({
    super.key,
    required this.id,
    required this.point,
    required this.title,
    required this.docid,
  });

  @override
  State<HighwayCodesPointsPage> createState() => _HighwayCodesPointsPageState();
}

class _HighwayCodesPointsPageState extends State<HighwayCodesPointsPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopHighwayCodePointsPage(
            point: widget.point,
            id: widget.id,
            title: widget.title,
            docid: widget.docid,
          );
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return DesktopHighwayCodePointsPage(
            point: widget.point,
            id: widget.id,
            title: widget.title,
            docid: widget.docid,
          );
        } else {
          return MobileHighwayCodePointsPage(
            point: widget.point,
            id: widget.id,
            title: widget.title,
            docid: widget.docid,
          );
        }
      },
    );
  }
}

class DesktopHighwayCodePointsPage extends StatefulWidget {
  final String id;
  final String docid;
  final String point;
  final String title;

  const DesktopHighwayCodePointsPage({
    super.key,
    required this.id,
    required this.point,
    required this.title,
    required this.docid,
  });

  @override
  State<DesktopHighwayCodePointsPage> createState() =>
      _DesktopHighwayCodePointsPageState();
}

class _DesktopHighwayCodePointsPageState
    extends State<DesktopHighwayCodePointsPage> {
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
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 50.0,
                          right: 50.0,
                          top: 50.0,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "",
                                  //  "Category: ${widget.category.toUpperCase()}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30.0),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.point,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),

                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => EditHighwayCodePointPage(
                                        id: widget.id,
                                        point: widget.point,
                                        title: widget.title,
                                        docid: widget.docid,
                                      ),
                                      transition: Transition.noTransition,
                                    );
                                  },
                                  child: Container(
                                    height: 0.070 * height,
                                    width: 0.20 * width,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 7,
                                          offset: Offset(1, 2),
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20.0,
                                        right: 20.0,
                                      ),
                                      child: Text(
                                        "Edit point",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,

                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15.0),
                                Text(
                                  "",
                                  // widget.correctanswer,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            // Row(
                            //   children: [
                            //     StreamBuilder(
                            //       stream: FirebaseFirestore.instance
                            //           .collection("users")
                            //           .doc(widget.uid)
                            //           .snapshots(),
                            //       builder: (context, asyncSnapshot) {
                            //         if (!asyncSnapshot.hasData) {
                            //           return Text("");
                            //         }
                            //         return InkWell(
                            //           onTap: () {
                            //             // Get.to(
                            //             //   () =>
                            //             //       UserDetailsPage(uid: widget.uid),
                            //             //   transition: Transition.noTransition,
                            //             // );
                            //           },
                            //           child: Text(
                            //             "flagged by ${asyncSnapshot.data?["name"]}",
                            //             style: GoogleFonts.poppins(
                            //               color: Colors.black,
                            //               fontWeight: FontWeight.w600,
                            //             ),
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: 10.0),
                            Row(
                              children: [
                                Text(
                                  "",
                                  // "flagged ${widget.dayflagged} /${widget.monthflagged} / ${widget.yearflagged}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
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

class MobileHighwayCodePointsPage extends StatefulWidget {
  final String id;
  final String docid;
  final String point;
  final String title;
  const MobileHighwayCodePointsPage({
    super.key,
    required this.id,
    required this.point,
    required this.title,
    required this.docid,
  });

  @override
  State<MobileHighwayCodePointsPage> createState() =>
      _MobileHighwayCodePointsPageState();
}

class _MobileHighwayCodePointsPageState
    extends State<MobileHighwayCodePointsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
