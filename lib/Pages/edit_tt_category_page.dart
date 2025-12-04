import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class EditTtCategoryPage extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  const EditTtCategoryPage({
    super.key,
    required this.id,
    required this.image,
    required this.name,
  });

  @override
  State<EditTtCategoryPage> createState() => _EditTtCategoryPageState();
}

class _EditTtCategoryPageState extends State<EditTtCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopEditTTCategory(
            id: widget.id,
            image: widget.image,
            name: widget.name,
          );
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return DesktopEditTTCategory(
            id: widget.id,
            image: widget.image,
            name: widget.name,
          );
        } else {
          return MobileEditTTCategory(
            id: widget.id,
            image: widget.image,
            name: widget.name,
          );
        }
      },
    );
  }
}

class DesktopEditTTCategory extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  const DesktopEditTTCategory({
    super.key,
    required this.id,
    required this.image,
    required this.name,
  });

  @override
  State<DesktopEditTTCategory> createState() => _DesktopEditTTCategoryState();
}

class _DesktopEditTTCategoryState extends State<DesktopEditTTCategory> {
  Uint8List? _imageBytes;
  String? _fileName;
  bool newimageselected = false;
  // bool _isUploading = false;

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _imageBytes = result.files.single.bytes;
        _fileName = result.files.single.name;
        newimageselected = true;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (newimageselected == true) {
      setState(() {
        loading = true;
      });
      try {
        final ref = FirebaseStorage.instance.ref().child("uploads/$_fileName");
        await ref.putData(
          _imageBytes!,
          SettableMetadata(contentType: "image/png"),
        );
        final downloadUrl = await ref.getDownloadURL();

        // Save URL in Firestore
        await FirebaseFirestore.instance
            .collection("theory_Test_revision_question_category")
            .doc(widget.id)
            .update({
              "image": downloadUrl,
              "name": name.text.isEmpty || name.text == ""
                  ? widget.name
                  : name.text.trim(),
            })
            .then((value) {
              setState(() {
                loading = false;
                _imageBytes = null;
                name.clear();
              });
              Get.back();
              Get.snackbar(
                maxWidth: 450,
                "",
                "",
                backgroundColor: Colors.green,
                titleText: Text(
                  "Success!",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                messageText: Text(
                  "Category edited successfully",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            });
      } catch (e) {
        Get.snackbar(
          maxWidth: 450,
          "",
          "",
          backgroundColor: Colors.red,
          titleText: Text(
            "Error!",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          messageText: Text(
            "Try again later",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
        // ScaffoldMessenger.of(
        //   context,
        // ).showSnackBar(SnackBar(content: Text("Error: $e")));
      } finally {
        setState(() {
          //loading = false;
          loading = false;
        });
      }
    } else {
      try {
        setState(() {
          loading = true;
        });
        await FirebaseFirestore.instance
            .collection("theory_Test_revision_question_category")
            .doc(widget.id)
            .update({
              "name": name.text.isEmpty || name.text == ""
                  ? widget.name
                  : name.text.trim(),
            })
            .then((value) {
              setState(() {
                loading = false;
                _imageBytes = null;
                name.clear();
              });
              Get.back();
              Get.snackbar(
                maxWidth: 450,
                "",
                "",
                backgroundColor: Colors.green,
                titleText: Text(
                  "Success!",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                messageText: Text(
                  "Category edited successfully",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            });
      } catch (e) {
        Get.snackbar(
          maxWidth: 450,
          "",
          "",
          backgroundColor: Colors.red,
          titleText: Text(
            "Error!",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          messageText: Text(
            "Try again later",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

  TextEditingController name = TextEditingController();
  String nametitle = "Name";
  bool nameerror = false;
  bool loading = false;
  bool deleting = false;
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
                            _imageBytes != null
                                ? Container(
                                    height: 0.40 * height,
                                    width: 0.22 * width,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.memory(
                                        _imageBytes!,
                                        height: 0.40 * height,
                                      ),
                                    ),
                                  )
                                : Stack(
                                    children: [
                                      Container(
                                        height: 0.40 * height,
                                        width: 0.22 * width,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(50.0),
                                          child: Image.network(
                                            widget.image,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 15.0,
                                        ),
                                        child: InkWell(
                                          onTap: _pickImage,
                                          child: Container(
                                            height: 0.070 * height,
                                            width: 0.070 * width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.image,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text(
                                widget.name,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
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
                                  child: TextField(
                                    onTap: () {
                                      if (nameerror == true) {
                                        setState(() {
                                          nameerror = false;
                                          nametitle = "Name";
                                        });
                                      }
                                    },
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
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     setState(() {
                                    //       name.clear();
                                    //       nameerror = true;
                                    //       nametitle = "Required";
                                    //     });
                                    //     return "Required";
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
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
                                    _uploadImage();
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
                                            "Save category",
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
                                                          color: Colors.black26,
                                                          blurRadius: 7,
                                                          offset: Offset(1, 2),
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
                                                    "You are about deleting category\ndo you want to proceed ?",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
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
                                                        if (deleting == true) {
                                                          deleting = false;
                                                        }
                                                      }
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                            "theory_Test_revision_question_category",
                                                          )
                                                          .doc(widget.id)
                                                          .delete()
                                                          .then((value) {
                                                            Get.close(1);
                                                            Get.back();
                                                          });
                                                    },
                                                    child: Container(
                                                      height: 0.070 * height,
                                                      width: 0.20 * width,

                                                      decoration: BoxDecoration(
                                                        color: Colors.redAccent,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              7,
                                                            ),
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
                                                      alignment:
                                                          Alignment.center,
                                                      child: deleting
                                                          ? SizedBox(
                                                              height: 13,
                                                              width: 13,
                                                              child:
                                                                  CircularProgressIndicator(
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
                                      "Delete category",
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

class MobileEditTTCategory extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  const MobileEditTTCategory({
    super.key,
    required this.id,
    required this.image,
    required this.name,
  });

  @override
  State<MobileEditTTCategory> createState() => _MobileEditTTCategoryState();
}

class _MobileEditTTCategoryState extends State<MobileEditTTCategory> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
