import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class EditHighwayCodePointPage extends StatefulWidget {
  final String id;
  final String docid;
  final String point;
  final String title;

  const EditHighwayCodePointPage({
    super.key,
    required this.id,
    required this.point,
    required this.title,
    required this.docid,
  });

  @override
  State<EditHighwayCodePointPage> createState() =>
      _EditHighwayCodePointPageState();
}

class _EditHighwayCodePointPageState extends State<EditHighwayCodePointPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopEditHCPointPage(
            id: widget.id,
            docid: widget.docid,
            point: widget.point,
            title: widget.title,
          );
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return DesktopEditHCPointPage(
            id: widget.id,
            point: widget.point,
            title: widget.title,
            docid: widget.docid,
          );
        } else {
          return MobileEditHCPointPage(
            id: widget.id,
            point: widget.point,
            title: widget.title,
            docid: widget.docid,
          );
        }
      },
    );
  }
}

class DesktopEditHCPointPage extends StatefulWidget {
  final String id;
  final String docid;
  final String point;
  final String title;
  const DesktopEditHCPointPage({
    super.key,
    required this.id,
    required this.point,
    required this.title,
    required this.docid,
  });

  @override
  State<DesktopEditHCPointPage> createState() => _DesktopEditHCPointPageState();
}

class _DesktopEditHCPointPageState extends State<DesktopEditHCPointPage> {
  TextEditingController point = TextEditingController();

  bool loading = false;
  bool deleting = false;
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("OK NOW THIS IS THE ID :: ${widget.id}");
      print("OK NOW THIS IS THE DOC ID :: ${widget.docid}");
      print("OK NOW THIS IS THE POINT :: ${widget.point}");
      print("OK NOW THIS IS THE TITLE :: ${widget.title}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
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
                          padding: const EdgeInsets.all(50.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  widget.point,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 30.0,
                                  bottom: 40.0,
                                ),
                                child: Container(
                                  height: 0.30 * height,
                                  width: 0.50 * width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                      top: 20.0,
                                      bottom: 20.0,
                                    ),
                                    child: TextField(
                                      maxLines: 20,
                                      controller: point,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      cursorHeight: 14,
                                      cursorColor: Colors.black,
                                      cursorErrorColor: Colors.black,
                                      decoration: InputDecoration(
                                        hintText: "Point",
                                        hintStyle: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        errorStyle: TextStyle(fontSize: 0.010),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if (loading == false) {
                                        setState(() {
                                          loading = true;
                                        });
                                      } else {
                                        if (loading == true) {
                                          setState(() {
                                            loading = false;
                                          });
                                        }
                                      }
                                      await FirebaseFirestore.instance
                                          .collection("highwaycodesbook")
                                          .doc(widget.title)
                                          .collection(widget.docid)
                                          .doc(widget.id)
                                          .update({"point": point.text.trim()})
                                          .then((value) {
                                            setState(() {
                                              loading = false;
                                            });
                                            Get.close(1);
                                            Get.back();
                                            Get.back();
                                          });
                                    },
                                    child: Container(
                                      height: 0.070 * height,
                                      width: 0.22 * width,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      alignment: Alignment.center,
                                      child: loading
                                          ? SizedBox(
                                              height: 13,
                                              width: 13,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 3,
                                              ),
                                            )
                                          : Text(
                                              "Save point",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
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
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 0.070 * height,
                                                      width: 0.070 * width,
                                                      decoration: BoxDecoration(
                                                        color: Colors.redAccent,
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black26,
                                                            blurRadius: 7,
                                                            offset: Offset(
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
                                                      "You are about deleting point\ndo you want to proceed ?",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                    SizedBox(height: 30.0),
                                                    InkWell(
                                                      onTap: () async {
                                                        if (deleting == false) {
                                                          setState(() {
                                                            deleting = true;
                                                          });
                                                        } else {
                                                          if (deleting ==
                                                              true) {
                                                            deleting = false;
                                                          }
                                                        }
                                                        //********************************************************/
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                              "highwaycodesbook",
                                                            )
                                                            .doc(widget.title)
                                                            .collection(
                                                              widget.docid,
                                                            )
                                                            .doc(widget.id)
                                                            .delete()
                                                            .then((value) {
                                                              Get.close(1);
                                                              Get.back();
                                                              Get.back();
                                                            });
                                                        //********************************************************/
                                                      },
                                                      child: Container(
                                                        height: 0.070 * height,
                                                        width: 0.20 * width,

                                                        decoration: BoxDecoration(
                                                          color:
                                                              Colors.redAccent,
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
                                                                  fontSize: 13,
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
                                      height: 0.070 * height,
                                      width: 0.22 * width,
                                      decoration: BoxDecoration(
                                        color: Colors.brown,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Delete point",
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
      ),
    );
  }
}

class MobileEditHCPointPage extends StatefulWidget {
  final String id;
  final String docid;
  final String point;
  final String title;
  const MobileEditHCPointPage({
    super.key,
    required this.id,
    required this.point,
    required this.title,
    required this.docid,
  });

  @override
  State<MobileEditHCPointPage> createState() => _MobileEditHCPointPageState();
}

class _MobileEditHCPointPageState extends State<MobileEditHCPointPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
