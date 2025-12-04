import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class EditRoadSignPage extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String description;
  final String category;
  final String subcategory;
  const EditRoadSignPage({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.category,
    required this.subcategory,
  });

  @override
  State<EditRoadSignPage> createState() => _EditRoadSignPageState();
}

class _EditRoadSignPageState extends State<EditRoadSignPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopEditRoadSignPage(
            id: widget.id,
            name: widget.name,
            image: widget.image,
            category: widget.category,
            subcategory: widget.subcategory,
            description: widget.description,
          );
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return DesktopEditRoadSignPage(
            id: widget.id,
            name: widget.name,
            image: widget.image,
            category: widget.category,
            subcategory: widget.subcategory,
            description: widget.description,
          );
        } else {
          return MobileEditRoadSignPage(
            id: widget.id,
            name: widget.name,
            image: widget.image,
            category: widget.category,
            subcategory: widget.subcategory,
            description: widget.description,
          );
        }
      },
    );
  }
}

class DesktopEditRoadSignPage extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String description;
  final String category;
  final String subcategory;
  const DesktopEditRoadSignPage({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.category,
    required this.subcategory,
  });

  @override
  State<DesktopEditRoadSignPage> createState() =>
      _DesktopEditRoadSignPageState();
}

class _DesktopEditRoadSignPageState extends State<DesktopEditRoadSignPage> {
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
            .collection("road_signs")
            .doc(widget.id)
            .update({
              "image": downloadUrl,
              "name": name.text.isEmpty || name.text == ""
                  ? widget.name
                  : name.text.trim(),
              "description": description.text.isEmpty || description.text == ""
                  ? widget.description
                  : description.text.trim(),
              "category": selectedcat == "Select category"
                  ? widget.category
                  : selectedName,
              "sub_category": selectedsub == "Select sub category"
                  ? widget.subcategory
                  : selectedsub,
            })
            .then((value) {
              setState(() {
                loading = false;
                _imageBytes = null;
                name.clear();
                description.clear();
              });
              Get.back();
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
                  "Road sign edited successfully",
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
    } else {
      try {
        setState(() {
          loading = true;
        });
        await FirebaseFirestore.instance
            .collection("road_signs")
            .doc(widget.id)
            .update({
              "name": name.text.isEmpty || name.text == ""
                  ? widget.name
                  : name.text.trim(),
              "description": description.text.isEmpty || description.text == ""
                  ? widget.description
                  : description.text.trim(),
              "category": selectedcat == "Select category"
                  ? widget.category
                  : selectedName,
              "sub_category": selectedsub == "Select sub category"
                  ? widget.subcategory
                  : selectedsub,
            })
            .then((value) {
              setState(() {
                loading = false;
                _imageBytes = null;
                name.clear();
                description.clear();
              });
              Get.back();
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
                  "Road sign edited successfully",
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
  TextEditingController description = TextEditingController();
  bool loading = false;
  final formkey = GlobalKey<FormState>();
  String? selectedSubCategoryValue;
  bool newcategoryselected = false;
  bool categoryerror = false;
  String selectedsub = "Select sub category";
  String selectedcat = "Select category";
  String? selectedDocId; // 👈 store selected document ID here
  String? selectedName; // optional: store selected document name
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
                          padding: const EdgeInsets.only(
                            left: 50.0,
                            right: 50.0,
                            top: 80.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 10.0,
                                    ),
                                    child: Text(
                                      widget.name,
                                      overflow: TextOverflow.ellipsis,

                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
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
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: Image.network(
                                                  widget.image,
                                                  height: 0.40 * height,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 50),
                                            SizedBox(width: 50),
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
                                                    color: Colors.black,
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
                                ],
                              ),
                              SizedBox(width: 50),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 55.0,
                                        bottom: 10.0,
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
                                              hintText: "Name",
                                              hintStyle: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              errorStyle: TextStyle(
                                                fontSize: 0.010,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10.0,
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
                                            left: 15.0,
                                            right: 15.0,
                                          ),
                                          child: StreamBuilder<QuerySnapshot>(
                                            // 👇 Change "cities" to your Firestore collection name
                                            stream: FirebaseFirestore.instance
                                                .collection(
                                                  'road_signs_categories',
                                                )
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const CircularProgressIndicator();
                                              }

                                              if (!snapshot.hasData ||
                                                  snapshot.data!.docs.isEmpty) {
                                                return const Text(
                                                  "No data found",
                                                );
                                              }

                                              // Extract list of values
                                              // Build list of DropdownMenuItems
                                              List<DropdownMenuItem<String>>
                                              items = snapshot.data!.docs.map((
                                                doc,
                                              ) {
                                                return DropdownMenuItem<String>(
                                                  value: doc
                                                      .id, // store doc ID as value
                                                  child: Text(
                                                    doc['name'],
                                                  ), // show field "name"
                                                );
                                              }).toList();

                                              return DropdownButtonFormField<
                                                String
                                              >(
                                                dropdownColor: Colors.white,
                                                decoration: InputDecoration(
                                                  labelText: selectedcat,
                                                  border: InputBorder
                                                      .none, // 👈 removes border
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                ),

                                                initialValue: selectedDocId,
                                                hint: Text(
                                                  widget.category,
                                                  style: GoogleFonts.poppins(
                                                    color: categoryerror
                                                        ? Colors.red
                                                        : Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                isExpanded: true,
                                                items: items,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedDocId =
                                                        newValue!; // save doc ID
                                                    // also get the corresponding name (optional)
                                                    selectedName = snapshot
                                                        .data!
                                                        .docs
                                                        .firstWhere(
                                                          (doc) =>
                                                              doc.id ==
                                                              newValue,
                                                        )['name'];
                                                    newcategoryselected = true;
                                                    selectedsub =
                                                        widget.subcategory;
                                                    selectedcat = newValue;
                                                  });

                                                  // 👇 Example: print selected ID
                                                  if (kDebugMode) {
                                                    print(
                                                      "Selected docId: $selectedDocId",
                                                    );
                                                  }
                                                  if (kDebugMode) {
                                                    print(
                                                      "Selected name: $selectedName",
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),

                                    if (newcategoryselected == true)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 10.0,
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
                                              left: 15.0,
                                              right: 15.0,
                                            ),
                                            child: StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection(
                                                    'road_signs_categories',
                                                  )
                                                  .doc(selectedDocId)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const CircularProgressIndicator();
                                                }

                                                if (!snapshot.hasData) {
                                                  return const Text(
                                                    "No data found",
                                                  );
                                                }

                                                // Get array field

                                                List<dynamic> subCategories =
                                                    snapshot
                                                        .data!['sub_categories'] ??
                                                    [];

                                                List<String> items =
                                                    subCategories
                                                        .map(
                                                          (e) => e.toString(),
                                                        )
                                                        .toList();

                                                return DropdownButtonFormField<
                                                  String
                                                >(
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        widget.subcategory,
                                                    border: InputBorder
                                                        .none, // 👈 removes border
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                  ),
                                                  validator: (value) =>
                                                      value == null
                                                      ? "Please select a sub category"
                                                      : null,
                                                  dropdownColor: Colors.white,

                                                  initialValue:
                                                      selectedSubCategoryValue,
                                                  hint: Text(
                                                    selectedsub,
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  isExpanded: true,
                                                  items: items.map((
                                                    String value,
                                                  ) {
                                                    return DropdownMenuItem<
                                                      String
                                                    >(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                            ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      selectedsub = newValue!;
                                                    });
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 15.0,
                                      ),
                                      child: Container(
                                        height: 0.15 * height,
                                        width: 0.35 * width,
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
                                            maxLines: 10,

                                            controller: description,
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            cursorHeight: 14,
                                            cursorColor: Colors.black,
                                            cursorErrorColor: Colors.black,
                                            decoration: InputDecoration(
                                              hintText: "Description",
                                              hintStyle: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              errorStyle: TextStyle(
                                                fontSize: 0.010,
                                              ),
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
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: loading
                                            ? SizedBox(
                                                height: 13,
                                                width: 13,
                                                child:
                                                    CircularProgressIndicator(
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
                                  ],
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
      ),
    );
  }
}

class MobileEditRoadSignPage extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String description;
  final String category;
  final String subcategory;
  const MobileEditRoadSignPage({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.category,
    required this.subcategory,
  });

  @override
  State<MobileEditRoadSignPage> createState() => _MobileEditRoadSignPageState();
}

class _MobileEditRoadSignPageState extends State<MobileEditRoadSignPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
