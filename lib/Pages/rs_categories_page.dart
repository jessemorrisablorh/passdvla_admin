import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Pages/loading_page.dart';
import 'package:pass_dvla_admin/Pages/rs_sub_categories_page.dart';
import 'package:pass_dvla_admin/Pages/theorytest_create_category_page.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class RsCategoriesPage extends StatefulWidget {
  const RsCategoriesPage({super.key});

  @override
  State<RsCategoriesPage> createState() => _RsCategoriesPageState();
}

class _RsCategoriesPageState extends State<RsCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const DesktopRsCategoryPage();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return const DesktopRsCategoryPage();
        } else {
          return const MobileRsCategoryPage();
        }
      },
    );
  }
}

class DesktopRsCategoryPage extends StatefulWidget {
  const DesktopRsCategoryPage({super.key});

  @override
  State<DesktopRsCategoryPage> createState() => _DesktopRsCategoryPageState();
}

class _DesktopRsCategoryPageState extends State<DesktopRsCategoryPage> {
  int currentPage = 0;
  final int itemsPerPage = 5;
  final int maxVisibleButtons = 4;
  String searchQuery = '';
  final TextEditingController search = TextEditingController();
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
                  //========== SIDEBAR WIDGET ========== //
                  Expanded(flex: 1, child: DesktopSideBarWidget()),

                  //========== SIDEBAR WIDGET ========== //
                  SizedBox(width: 8.0),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 0.74 * height,
                      color: Colors.white,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("road_signs_categories")
                            .orderBy("name", descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return LoadingPage();
                          }
                          final allDocs = snapshot.data!.docs.where((doc) {
                            final data = doc.data();
                            final name =
                                data['name']?.toString().toLowerCase() ?? '';
                            return name.contains(searchQuery);
                          }).toList();

                          if (allDocs.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "No category found.",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        search.clear();
                                        searchQuery = "";
                                        // roleselected = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Icon(
                                          Icons.refresh,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          final totalPages = (allDocs.length / itemsPerPage)
                              .ceil();
                          currentPage = currentPage.clamp(0, totalPages - 1);

                          final startIndex = currentPage * itemsPerPage;
                          final endIndex = (startIndex + itemsPerPage).clamp(
                            0,
                            allDocs.length,
                          );
                          final visibleDocs = allDocs.sublist(
                            startIndex,
                            endIndex,
                          );

                          // Adjust page buttons
                          int startBtn = 0;
                          int endBtn = totalPages;
                          if (totalPages > maxVisibleButtons) {
                            if (currentPage <= 1) {
                              startBtn = 0;
                              endBtn = maxVisibleButtons;
                            } else if (currentPage >= totalPages - 2) {
                              startBtn = totalPages - maxVisibleButtons;
                              endBtn = totalPages;
                            } else {
                              startBtn = currentPage - 1;
                              endBtn = currentPage + 3;
                            }
                          }
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  50.0,
                                  50.0,
                                  50.0,
                                  0,
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => TheorytestCreateCategoryPage(),
                                          transition: Transition.noTransition,
                                        );
                                      },
                                      child: Container(
                                        height: 0.065 * height,
                                        width: 0.13 * width,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(
                                            7,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 7,
                                              offset: Offset(1, 2),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          "Add new category",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Container(
                                      height: 0.065 * height,
                                      width: 0.35 * width,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.circular(7),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 7,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 15.0,
                                                right: 15.0,
                                              ),
                                              child: TextField(
                                                onChanged: (value) => setState(
                                                  () => searchQuery = value
                                                      .toLowerCase(),
                                                ),
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                cursorColor: Colors.white,
                                                cursorHeight: 14,
                                                controller: search,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "Search",
                                                  hintStyle:
                                                      GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 0.065 * height,
                                            width: 0.055 * width,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 7,
                                                  offset: Offset(1, 2),
                                                ),
                                              ],
                                            ),
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.search,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 150),
                                    Container(
                                      height: 0.065 * height,
                                      width: 0.13 * width,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(7),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 7,
                                            offset: Offset(1, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        "${snapshot.data!.docs.length} Categories",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  50.0,
                                  0.0,
                                  50.0,
                                  10.0,
                                ),
                                child: Container(
                                  height: 0.070 * height,
                                  color: Colors.grey[200],
                                  width: width,
                                  child: Row(
                                    children: [
                                      SizedBox(width: 10),
                                      ImageIcon(AssetImage("IMAGES/THEME.PNG")),
                                      SizedBox(width: 30),

                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Category",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),

                                      Icon(Icons.edit_note, color: Colors.red),
                                      SizedBox(width: 15),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    50.0,
                                    0.0,
                                    50.0,
                                    10.0,
                                  ),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: visibleDocs.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.to(
                                            () => RsSubCategoriesPage(
                                              name: visibleDocs[index]["name"],
                                              subcategories:
                                                  visibleDocs[index]["sub_categories"],
                                              categoory:
                                                  visibleDocs[index]["name"],
                                            ),
                                            transition: Transition.noTransition,
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 15.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            8.0,
                                                          ),
                                                      child: Image.asset(
                                                        "images/theme.png",
                                                        color: Colors.white,
                                                        height: 45,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 20),
                                                  Text(
                                                    visibleDocs[index]["name"],
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 50.0,
                                  bottom: 20.0,
                                ),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${currentPage + 1} / $totalPages",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: 30.0),
                                    if (currentPage > 0)
                                      InkWell(
                                        onTap: () =>
                                            setState(() => currentPage--),
                                        child: Container(
                                          height: 0.060 * height,
                                          width: 0.035 * width,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              7,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 7,
                                                offset: Offset(2, 3),
                                              ),
                                            ],
                                          ),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.arrow_left,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),

                                    //===
                                    for (int i = startBtn; i < endBtn; i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        child: InkWell(
                                          onTap: () =>
                                              setState(() => currentPage = i),
                                          child: Container(
                                            height: 0.060 * height,
                                            width: 0.035 * width,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.red,
                                                width: 1,
                                                style: BorderStyle.solid,
                                              ),
                                              color: i == currentPage
                                                  ? Colors.red
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //     color:
                                              //         Colors
                                              //             .black12,
                                              //     blurRadius: 7,
                                              //     offset: Offset(
                                              //       2,
                                              //       3,
                                              //     ),
                                              //   ),
                                              // ],
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${i + 1}",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: i == currentPage
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    SizedBox(width: 5),
                                    if (currentPage < totalPages - 1)
                                      InkWell(
                                        onTap: () =>
                                            setState(() => currentPage++),
                                        child: Container(
                                          height: 0.060 * height,
                                          width: 0.035 * width,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              7,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 7,
                                                offset: Offset(2, 3),
                                              ),
                                            ],
                                          ),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.arrow_right,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
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

class MobileRsCategoryPage extends StatefulWidget {
  const MobileRsCategoryPage({super.key});

  @override
  State<MobileRsCategoryPage> createState() => _MobileRsCategoryPageState();
}

class _MobileRsCategoryPageState extends State<MobileRsCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
