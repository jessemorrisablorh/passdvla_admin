import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Pages/user_details_page.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class FlaggedRoadSignsDetailsPage extends StatefulWidget {
  final String id;
  final String uid;
  final String name;
  final int daycreated;
  final int monthcreated;
  final int yearcreated;
  final String image;
  final String description;
  final String category;
  final String subcategory;

  const FlaggedRoadSignsDetailsPage({
    super.key,
    required this.id,
    required this.uid,
    required this.name,
    required this.daycreated,
    required this.monthcreated,
    required this.yearcreated,
    required this.category,
    required this.image,
    required this.subcategory,
    required this.description,
  });

  @override
  State<FlaggedRoadSignsDetailsPage> createState() =>
      _FlaggedRoadSignsDetailsPageState();
}

class _FlaggedRoadSignsDetailsPageState
    extends State<FlaggedRoadSignsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopFlaggedRoadSignsDetails(
            id: widget.id,
            uid: widget.uid,
            name: widget.name,
            daycreated: widget.daycreated,
            monthcreated: widget.monthcreated,
            yearcreated: widget.yearcreated,
            category: widget.category,
            subcategory: widget.subcategory,
            image: widget.image,
            description: widget.description,
          );
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return DesktopFlaggedRoadSignsDetails(
            id: widget.id,
            uid: widget.uid,
            name: widget.name,
            daycreated: widget.daycreated,
            monthcreated: widget.monthcreated,
            yearcreated: widget.yearcreated,
            category: widget.category,
            subcategory: widget.subcategory,
            image: widget.image,
            description: widget.description,
          );
        } else {
          return MobileFlaggedRoadSignsDetails(
            id: widget.id,
            uid: widget.uid,
            name: widget.name,
            daycreated: widget.daycreated,
            monthcreated: widget.monthcreated,
            yearcreated: widget.yearcreated,
            category: widget.category,
            subcategory: widget.subcategory,
            image: widget.image,
            description: widget.description,
          );
        }
      },
    );
  }
}

class DesktopFlaggedRoadSignsDetails extends StatefulWidget {
  final String id;
  final String uid;
  final String name;
  final int daycreated;
  final int monthcreated;
  final int yearcreated;
  final String image;
  final String description;
  final String category;
  final String subcategory;
  const DesktopFlaggedRoadSignsDetails({
    super.key,
    required this.id,
    required this.uid,
    required this.name,
    required this.daycreated,
    required this.monthcreated,
    required this.yearcreated,
    required this.category,
    required this.image,
    required this.subcategory,
    required this.description,
  });

  @override
  State<DesktopFlaggedRoadSignsDetails> createState() =>
      _DesktopFlaggedRoadSignsDetailsState();
}

class _DesktopFlaggedRoadSignsDetailsState
    extends State<DesktopFlaggedRoadSignsDetails> {
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
                                  "Category: ${widget.category.toUpperCase()}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: [
                                Text(
                                  "Sub Category: ${widget.subcategory.toUpperCase()}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              widget.name,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              height: 0.40 * height,
                              width: 0.22 * width,
                              decoration: BoxDecoration(color: Colors.red),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  widget.image,
                                  height: 0.40 * height,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
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
                                      () => UserDetailsPage(uid: widget.uid),
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
                            SizedBox(height: 10.0),
                            Text(
                              "flagged ${widget.daycreated} /${widget.monthcreated} / ${widget.yearcreated}",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
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

class MobileFlaggedRoadSignsDetails extends StatefulWidget {
  final String id;
  final String uid;
  final String name;
  final int daycreated;
  final int monthcreated;
  final int yearcreated;
  final String image;
  final String description;
  final String category;
  final String subcategory;
  const MobileFlaggedRoadSignsDetails({
    super.key,
    required this.id,
    required this.uid,
    required this.name,
    required this.daycreated,
    required this.monthcreated,
    required this.yearcreated,
    required this.category,
    required this.image,
    required this.subcategory,
    required this.description,
  });

  @override
  State<MobileFlaggedRoadSignsDetails> createState() =>
      _MobileFlaggedRoadSignsDetailsState();
}

class _MobileFlaggedRoadSignsDetailsState
    extends State<MobileFlaggedRoadSignsDetails> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
