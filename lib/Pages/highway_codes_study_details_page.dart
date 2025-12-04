import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Pages/highway_code_study_pages_page.dart';
import 'package:pass_dvla_admin/Pages/hwc_add_subcontent_page.dart';
import 'package:pass_dvla_admin/Pages/loading_page.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class HighwayCodesStudyDetailsPage extends StatefulWidget {
  final String title;
  const HighwayCodesStudyDetailsPage({super.key, required this.title});

  @override
  State<HighwayCodesStudyDetailsPage> createState() =>
      _HighwayCodesStudyDetailsPageState();
}

class _HighwayCodesStudyDetailsPageState
    extends State<HighwayCodesStudyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopHCStudyDetailsPage(title: widget.title);
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return DesktopHCStudyDetailsPage(title: widget.title);
        } else {
          return MobileHWCStudyDetailsPage(title: widget.title);
        }
      },
    );
  }
}

class DesktopHCStudyDetailsPage extends StatefulWidget {
  final String title;
  const DesktopHCStudyDetailsPage({super.key, required this.title});

  @override
  State<DesktopHCStudyDetailsPage> createState() =>
      _DesktopHCStudyDetailsPageState();
}

class _DesktopHCStudyDetailsPageState extends State<DesktopHCStudyDetailsPage> {
  int currentPage = 0;
  final int itemsPerPage = 5;
  final int maxVisibleButtons = 4;
  String searchQuery = '';
  bool deleting = false;
  final TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("KWE3 KW3 KW3${widget.title}");
  }

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
                            .collection("highwaycodesbook")
                            .doc(widget.title)
                            .collection("titles")
                            .orderBy("datecreated")
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
                                    "No content found.",
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
                                  SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => HwcAddSubcontentPage(
                                          title: widget.title,
                                        ),
                                        transition: Transition.noTransition,
                                      );
                                    },
                                    child: Container(
                                      height: 0.065 * height,
                                      width: 0.15 * width,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Add content",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
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
                                          () => HwcAddSubcontentPage(
                                            title: widget.title,
                                          ),
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
                                          "Add new content",
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
                                        "${snapshot.data!.docs.length} Contents",
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
                                          "Contents",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
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
                                          if (kDebugMode) {
                                            print(
                                              "Then this is the title :: ${widget.title}",
                                            );
                                            print(
                                              "Then this is the new doc id :: ${visibleDocs[index]["id"]}",
                                            );
                                          }
                                          Get.to(
                                            () => HighwayCodeStudyPagesPage(
                                              title: widget.title,
                                              id: visibleDocs[index]["id"],
                                              docid: visibleDocs[index]["id"],
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
                                                    visibleDocs[index]["id"]
                                                        .toString()
                                                        .capitalizeFirst
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.dialog(
                                                    StatefulBuilder(
                                                      builder: (context, setState) {
                                                        return Dialog(
                                                          child: Container(
                                                            height:
                                                                0.40 * height,
                                                            width: 0.35 * width,
                                                            decoration:
                                                                BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  height:
                                                                      0.070 *
                                                                      height,
                                                                  width:
                                                                      0.070 *
                                                                      width,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .black26,
                                                                        blurRadius:
                                                                            7,
                                                                        offset:
                                                                            Offset(
                                                                              1,
                                                                              2,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .delete_forever,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 30.0,
                                                                ),
                                                                Text(
                                                                  "You are about deleting content\ndo you want to proceed ?",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 30.0,
                                                                ),
                                                                InkWell(
                                                                  onTap: () async {
                                                                    if (deleting ==
                                                                        false) {
                                                                      setState(() {
                                                                        deleting =
                                                                            true;
                                                                      });
                                                                    } else {
                                                                      if (deleting ==
                                                                          true) {
                                                                        deleting =
                                                                            false;
                                                                      }
                                                                    }
                                                                    //********************************************************/

                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                          "highwaycodesbook",
                                                                        )
                                                                        .doc(
                                                                          widget
                                                                              .title,
                                                                        )
                                                                        .collection(
                                                                          "titles",
                                                                        )
                                                                        .doc(
                                                                          visibleDocs[index]["id"],
                                                                        )
                                                                        .delete()
                                                                        .then((
                                                                          value,
                                                                        ) {
                                                                          setState(
                                                                            () {
                                                                              deleting = false;
                                                                            },
                                                                          );
                                                                          Get.close(
                                                                            1,
                                                                          );
                                                                        });
                                                                    //********************************************************/
                                                                  },
                                                                  child: Container(
                                                                    height:
                                                                        0.070 *
                                                                        height,
                                                                    width:
                                                                        0.20 *
                                                                        width,

                                                                    decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .redAccent,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            7,
                                                                          ),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color:
                                                                              Colors.black26,
                                                                          blurRadius:
                                                                              7,
                                                                          offset: Offset(
                                                                            1,
                                                                            2,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        deleting
                                                                        ? SizedBox(
                                                                            height:
                                                                                13,
                                                                            width:
                                                                                13,
                                                                            child: CircularProgressIndicator(
                                                                              color: Colors.white,
                                                                              strokeWidth: 3,
                                                                            ),
                                                                          )
                                                                        : Text(
                                                                            "Proceed",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: GoogleFonts.poppins(
                                                                              color: Colors.white,
                                                                              fontSize: 13,
                                                                              fontWeight: FontWeight.w500,
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
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.black,
                                                ),
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

class MobileHWCStudyDetailsPage extends StatefulWidget {
  final String title;
  const MobileHWCStudyDetailsPage({super.key, required this.title});

  @override
  State<MobileHWCStudyDetailsPage> createState() =>
      _MobileHWCStudyDetailsPageState();
}

class _MobileHWCStudyDetailsPageState extends State<MobileHWCStudyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
