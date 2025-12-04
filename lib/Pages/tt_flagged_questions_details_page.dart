import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Pages/user_details_page.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class TheoryTestFlaggedQuestionsDetailsPage extends StatefulWidget {
  final String id;
  final String uid;
  final String question;
  final List options;
  final String correctanswer;
  final int dayflagged;
  final int monthflagged;
  final int yearflagged;
  final String category;
  const TheoryTestFlaggedQuestionsDetailsPage({
    super.key,
    required this.id,
    required this.uid,
    required this.question,
    required this.options,
    required this.correctanswer,
    required this.dayflagged,
    required this.monthflagged,
    required this.yearflagged,
    required this.category,
  });

  @override
  State<TheoryTestFlaggedQuestionsDetailsPage> createState() =>
      _TheoryTestFlaggedQuestionsDetailsPageState();
}

class _TheoryTestFlaggedQuestionsDetailsPageState
    extends State<TheoryTestFlaggedQuestionsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopTTFlaggedQuestionsDetailsPage(
            id: widget.id,
            uid: widget.uid,
            question: widget.question,
            options: widget.options,
            correctanswer: widget.correctanswer,
            dayflagged: widget.dayflagged,
            monthflagged: widget.monthflagged,
            yearflagged: widget.yearflagged,
            category: widget.category,
          );
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return DesktopTTFlaggedQuestionsDetailsPage(
            id: widget.id,
            uid: widget.uid,
            question: widget.question,
            options: widget.options,
            correctanswer: widget.correctanswer,
            dayflagged: widget.dayflagged,
            monthflagged: widget.monthflagged,
            yearflagged: widget.yearflagged,
            category: widget.category,
          );
        } else {
          return MobileTTFlaggedQuestionsDetailsPage(
            id: widget.id,
            uid: widget.uid,
            question: widget.question,
            options: widget.options,
            correctanswer: widget.correctanswer,
            category: widget.category,
            dayflagged: widget.dayflagged,
            monthflagged: widget.monthflagged,
            yearflagged: widget.yearflagged,
          );
        }
      },
    );
  }
}

class DesktopTTFlaggedQuestionsDetailsPage extends StatefulWidget {
  final String id;
  final String uid;
  final String question;
  final List options;
  final String correctanswer;
  final int dayflagged;
  final int monthflagged;
  final int yearflagged;
  final String category;
  const DesktopTTFlaggedQuestionsDetailsPage({
    super.key,
    required this.id,
    required this.uid,
    required this.question,
    required this.options,
    required this.correctanswer,
    required this.dayflagged,
    required this.monthflagged,
    required this.yearflagged,
    required this.category,
  });

  @override
  State<DesktopTTFlaggedQuestionsDetailsPage> createState() =>
      _DesktopTTFlaggedQuestionsDetailsPageState();
}

class _DesktopTTFlaggedQuestionsDetailsPageState
    extends State<DesktopTTFlaggedQuestionsDetailsPage> {
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
                                  "Category: ${widget.category.toUpperCase()}",
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
                                  "Question:\n${widget.question}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.options.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    "${index + 1}. ${widget.options[index]}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              children: [
                                Container(
                                  height: 0.070 * height,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                    ),
                                    child: Text(
                                      "Correct answer",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,

                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15.0),
                                Text(
                                  widget.correctanswer,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,

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
                                        "flagged by ${asyncSnapshot.data?["name"]}",
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
                                  "flagged ${widget.dayflagged} /${widget.monthflagged} / ${widget.yearflagged}",
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

class MobileTTFlaggedQuestionsDetailsPage extends StatefulWidget {
  final String id;
  final String uid;
  final String question;
  final List options;
  final String correctanswer;
  final int dayflagged;
  final int monthflagged;
  final int yearflagged;
  final String category;
  const MobileTTFlaggedQuestionsDetailsPage({
    super.key,
    required this.id,
    required this.uid,
    required this.question,
    required this.options,
    required this.correctanswer,
    required this.dayflagged,
    required this.monthflagged,
    required this.yearflagged,
    required this.category,
  });

  @override
  State<MobileTTFlaggedQuestionsDetailsPage> createState() =>
      _MobileTTFlaggedQuestionsDetailsPageState();
}

class _MobileTTFlaggedQuestionsDetailsPageState
    extends State<MobileTTFlaggedQuestionsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
