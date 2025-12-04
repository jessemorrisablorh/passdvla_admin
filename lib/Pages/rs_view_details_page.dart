import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Pages/edit_road_sign_page.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class RsViewDetailsPage extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String category;
  final String description;
  final String subcategory;

  const RsViewDetailsPage({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.description,
    required this.subcategory,
  });

  @override
  State<RsViewDetailsPage> createState() => _RsViewDetailsPageState();
}

class _RsViewDetailsPageState extends State<RsViewDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopRsDetailsPage(
            id: widget.id,
            name: widget.name,
            image: widget.image,
            category: widget.category,
            description: widget.description,
            subcategory: widget.subcategory,
          );
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return DesktopRsDetailsPage(
            id: widget.id,
            name: widget.name,
            image: widget.image,
            category: widget.category,
            description: widget.description,
            subcategory: widget.subcategory,
          );
        } else {
          return MobileRsDetailsPage(
            id: widget.id,
            name: widget.name,
            image: widget.image,
            category: widget.category,
            description: widget.description,
            subcategory: widget.subcategory,
          );
        }
      },
    );
  }
}

class DesktopRsDetailsPage extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String category;
  final String description;
  final String subcategory;
  const DesktopRsDetailsPage({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.description,
    required this.subcategory,
  });

  @override
  State<DesktopRsDetailsPage> createState() => _DesktopRsDetailsPageState();
}

class _DesktopRsDetailsPageState extends State<DesktopRsDetailsPage> {
  bool deleting = false;
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
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 0.40 * height,
                                      width: 0.22 * width,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                          widget.image,
                                          height: 0.40 * height,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.name,
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 30.0),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  widget.description,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => EditRoadSignPage(
                                            id: widget.id,
                                            name: widget.name,
                                            description: widget.description,
                                            category: widget.category,
                                            subcategory: widget.subcategory,
                                            image: widget.image,
                                          ),
                                          transition: Transition.noTransition,
                                        );
                                      },
                                      child: Container(
                                        height: 0.07 * height,
                                        width: 0.22 * width,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 7,
                                              offset: Offset(1, 2),
                                            ),
                                          ],
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Edit road sign",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
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
                                                  width: 0.35 * width,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 0.070 * height,
                                                        width: 0.070 * width,
                                                        decoration:
                                                            BoxDecoration(
                                                              color: Colors
                                                                  .redAccent,
                                                              shape: BoxShape
                                                                  .circle,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black26,
                                                                  blurRadius: 7,
                                                                  offset:
                                                                      Offset(
                                                                        1,
                                                                        2,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                        child: Icon(
                                                          Icons.delete_forever,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      SizedBox(height: 30.0),
                                                      Text(
                                                        "You are about deleting road sign\ndo you want to proceed ?",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                      ),
                                                      SizedBox(height: 30.0),
                                                      InkWell(
                                                        onTap: () async {
                                                          if (deleting ==
                                                              false) {
                                                            setState(() {
                                                              deleting = true;
                                                            });
                                                          } else {
                                                            if (deleting ==
                                                                true) {
                                                              deleting = false;
                                                            }
                                                          }
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                "road_signs",
                                                              )
                                                              .doc(widget.id)
                                                              .delete()
                                                              .then((value) {
                                                                Get.close(1);
                                                                Get.back();
                                                              });
                                                        },
                                                        child: Container(
                                                          height:
                                                              0.070 * height,
                                                          width: 0.20 * width,

                                                          decoration: BoxDecoration(
                                                            color: Colors
                                                                .redAccent,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  7,
                                                                ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black26,
                                                                blurRadius: 7,
                                                                offset: Offset(
                                                                  1,
                                                                  2,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: deleting
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
                                                                  "Proceed",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
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
                                        height: 0.07 * height,
                                        width: 0.22 * width,
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
                                        child: Text(
                                          "Delete road sign",
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
                              ],
                            ),
                            SizedBox(height: 20.0),
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

class MobileRsDetailsPage extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String category;
  final String description;
  final String subcategory;
  const MobileRsDetailsPage({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.description,
    required this.subcategory,
  });

  @override
  State<MobileRsDetailsPage> createState() => _MobileRsDetailsPageState();
}

class _MobileRsDetailsPageState extends State<MobileRsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
