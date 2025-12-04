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

class TheorytestCreateCategoryPage extends StatefulWidget {
  const TheorytestCreateCategoryPage({super.key});

  @override
  State<TheorytestCreateCategoryPage> createState() =>
      _TheorytestCreateCategoryPageState();
}

class _TheorytestCreateCategoryPageState
    extends State<TheorytestCreateCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopTTcreateCategory();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return DesktopTTcreateCategory();
        } else {
          return const MobileTTCreateCategory();
        }
      },
    );
  }
}

class DesktopTTcreateCategory extends StatefulWidget {
  const DesktopTTcreateCategory({super.key});

  @override
  State<DesktopTTcreateCategory> createState() =>
      _DesktopTTcreateCategoryState();
}

class _DesktopTTcreateCategoryState extends State<DesktopTTcreateCategory> {
  Uint8List? _imageBytes;
  String? _fileName;
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
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageBytes == null || _fileName == null) return;

    setState(() => loading = true);

    try {
      final ref = FirebaseStorage.instance.ref().child("uploads/$_fileName");
      await ref.putData(
        _imageBytes!,
        SettableMetadata(contentType: "image/png"),
      );
      final downloadUrl = await ref.getDownloadURL();

      // Save URL in Firestore
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("theory_Test_revision_question_category")
          .doc();
      await documentReference
          .set({
            "image": downloadUrl,
            "name": name.text,
            "id": documentReference.id,
          })
          .then((value) {
            setState(() {
              loading = false;
              _imageBytes = null;
              name.clear();
            });
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
                "Category added successfully",
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
  }

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
                                          color: Colors.grey[300],
                                        ),
                                        child: Icon(Icons.image, size: 250),
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
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.image,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                              onTap: () {
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
                                  _uploadImage();
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
                                        "Add category",
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

class MobileTTCreateCategory extends StatefulWidget {
  const MobileTTCreateCategory({super.key});

  @override
  State<MobileTTCreateCategory> createState() => _MobileTTCreateCategoryState();
}

class _MobileTTCreateCategoryState extends State<MobileTTCreateCategory> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
