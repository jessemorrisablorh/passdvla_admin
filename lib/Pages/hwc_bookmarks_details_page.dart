import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Pages/user_details_page.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class HwcBookmarksDetailsPage extends StatefulWidget {
  final String id;
  final String uid;
  final String caption;
  final String pagename;
  final int dayadded;
  final int monthadded;
  final int yearadded;
  const HwcBookmarksDetailsPage({
    super.key,
    required this.id,
    required this.uid,
    required this.caption,
    required this.pagename,
    required this.dayadded,
    required this.monthadded,
    required this.yearadded,
  });

  @override
  State<HwcBookmarksDetailsPage> createState() =>
      _HwcBookmarksDetailsPageState();
}

class _HwcBookmarksDetailsPageState extends State<HwcBookmarksDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopHWCBDetailsPage(
            id: widget.id,
            uid: widget.uid,
            pagename: widget.pagename,
            caption: widget.caption,
            dayadded: widget.dayadded,
            monthadded: widget.monthadded,
            yearadded: widget.yearadded,
          );
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return DesktopHWCBDetailsPage(
            id: widget.id,
            uid: widget.uid,
            pagename: widget.pagename,
            caption: widget.caption,
            dayadded: widget.dayadded,
            monthadded: widget.monthadded,
            yearadded: widget.yearadded,
          );
        } else {
          return MobileHWCBDetailsPage(
            id: widget.id,
            uid: widget.uid,
            pagename: widget.pagename,
            caption: widget.caption,
            dayadded: widget.dayadded,
            monthadded: widget.monthadded,
            yearadded: widget.yearadded,
          );
        }
      },
    );
  }
}

class DesktopHWCBDetailsPage extends StatefulWidget {
  final String id;
  final String uid;
  final String caption;
  final String pagename;
  final int dayadded;
  final int monthadded;
  final int yearadded;
  const DesktopHWCBDetailsPage({
    super.key,
    required this.id,
    required this.uid,
    required this.caption,
    required this.pagename,
    required this.dayadded,
    required this.monthadded,
    required this.yearadded,
  });

  @override
  State<DesktopHWCBDetailsPage> createState() => _DesktopHWCBDetailsPageState();
}

class _DesktopHWCBDetailsPageState extends State<DesktopHWCBDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
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
                                  "Caption: ${widget.caption.toUpperCase()}",
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
                                Text(
                                  "Page name:\n${widget.pagename}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 20.0),
                            Row(
                              children: [
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(widget.uid)
                                      .snapshots(),
                                  builder: (context, asyncSnapshot) {
                                    if (!asyncSnapshot.hasData) {
                                      return Text("");
                                    }
                                    return InkWell(
                                      onTap: () {
                                        Get.to(
                                          () =>
                                              UserDetailsPage(uid: widget.uid),
                                          transition: Transition.noTransition,
                                        );
                                      },
                                      child: Text(
                                        "bookmarked by ${asyncSnapshot.data?["name"]}",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: [
                                Text(
                                  "bookmarked ${widget.dayadded} /${widget.monthadded} / ${widget.yearadded}",
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

class MobileHWCBDetailsPage extends StatefulWidget {
  final String id;
  final String uid;
  final String caption;
  final String pagename;
  final int dayadded;
  final int monthadded;
  final int yearadded;
  const MobileHWCBDetailsPage({
    super.key,
    required this.id,
    required this.uid,
    required this.caption,
    required this.pagename,
    required this.dayadded,
    required this.monthadded,
    required this.yearadded,
  });

  @override
  State<MobileHWCBDetailsPage> createState() => _MobileHWCBDetailsPageState();
}

class _MobileHWCBDetailsPageState extends State<MobileHWCBDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
