import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class HwcaddPintPage extends StatefulWidget {
  final String caption;
  final String title;
  const HwcaddPintPage({super.key, required this.caption, required this.title});

  @override
  State<HwcaddPintPage> createState() => _HwcaddPintPageState();
}

class _HwcaddPintPageState extends State<HwcaddPintPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopHwcAddPointPAGE(
            title: widget.title,
            caption: widget.caption,
          );
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return DesktopHwcAddPointPAGE(
            title: widget.title,
            caption: widget.caption,
          );
        } else {
          return MobileHwcAddPointPage(
            title: widget.title,
            caption: widget.caption,
          );
        }
      },
    );
  }
}

class DesktopHwcAddPointPAGE extends StatefulWidget {
  final String caption;
  final String title;
  const DesktopHwcAddPointPAGE({
    super.key,
    required this.caption,
    required this.title,
  });

  @override
  State<DesktopHwcAddPointPAGE> createState() => _DesktopHwcAddPointPAGEState();
}

class _DesktopHwcAddPointPAGEState extends State<DesktopHwcAddPointPAGE> {
  TextEditingController point = TextEditingController();

  bool loading = false;
  bool deleting = false;
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("OK NOW THIS IS THE CAPTION :: ${widget.caption}");
      print("OK NOW THIS IS THE DOC TITLE :: ${widget.title}");
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
                                  "Add point",
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
                                      DocumentReference documentReference =
                                          FirebaseFirestore.instance
                                              .collection("highwaycodesbook")
                                              .doc(widget.title)
                                              .collection(widget.caption)
                                              .doc();
                                      await documentReference
                                          .set({
                                            "caption": widget.caption,
                                            "datecreated": DateTime.now(),
                                            "id": documentReference.id,
                                            "image": "",
                                            "number": 0,
                                            "point": point.text.trim(),
                                          })
                                          .then((value) {
                                            setState(() {
                                              loading = false;
                                            });
                                            Get.close(1);
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

class MobileHwcAddPointPage extends StatefulWidget {
  final String caption;
  final String title;
  const MobileHwcAddPointPage({
    super.key,
    required this.caption,
    required this.title,
  });

  @override
  State<MobileHwcAddPointPage> createState() => _MobileHwcAddPointPageState();
}

class _MobileHwcAddPointPageState extends State<MobileHwcAddPointPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
