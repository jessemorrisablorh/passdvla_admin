import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class HwcAddContentPage extends StatefulWidget {
  const HwcAddContentPage({super.key});

  @override
  State<HwcAddContentPage> createState() => _HwcAddContentPageState();
}

class _HwcAddContentPageState extends State<HwcAddContentPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const DesktopHWCAddContent();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return const DesktopHWCAddContent();
        } else {
          return const MobileHWCAddContent();
        }
      },
    );
  }
}

class DesktopHWCAddContent extends StatefulWidget {
  const DesktopHWCAddContent({super.key});

  @override
  State<DesktopHWCAddContent> createState() => _DesktopHWCAddContentState();
}

class _DesktopHWCAddContentState extends State<DesktopHWCAddContent> {
  TextEditingController name = TextEditingController();
  String nametitle = "Name";
  bool nameerror = false;
  bool loading = false;
  final formkey = GlobalKey<FormState>();
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                              ),
                              child: Container(
                                height: 0.070 * height,
                                width: 0.35 * width,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                ),
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                  ),
                                  child: TextFormField(
                                    controller: name,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    cursorHeight: 14,
                                    cursorColor: Colors.black,
                                    cursorErrorColor: Colors.black,
                                    decoration: InputDecoration(
                                      hintText: nametitle,
                                      hintStyle: GoogleFonts.poppins(
                                        color: nameerror
                                            ? Colors.red
                                            : Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      errorStyle: TextStyle(fontSize: 0.010),
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        setState(() {
                                          nameerror = true;
                                          nametitle = "Required";
                                        });
                                        return "Required";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (formkey.currentState!.validate()) {
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
                                      .doc(name.text)
                                      .set({
                                        "id": name.text,
                                        "datecreated": DateTime.now(),
                                        "daycreated": DateTime.now().day,
                                        "monthcreated": DateTime.now().month,
                                        "yearcreated": DateTime.now().year,
                                      })
                                      .then((value) {
                                        setState(() {
                                          loading = false;
                                        });
                                        Get.back();
                                        Get.snackbar(
                                          "",
                                          "",
                                          backgroundColor: Colors.green,
                                          titleText: Text(
                                            "Success!",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                          messageText: Text(
                                            "New content added",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                        );
                                      });
                                }
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
                                        "Add content",
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

class MobileHWCAddContent extends StatefulWidget {
  const MobileHWCAddContent({super.key});

  @override
  State<MobileHWCAddContent> createState() => _MobileHWCAddContentState();
}

class _MobileHWCAddContentState extends State<MobileHWCAddContent> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
