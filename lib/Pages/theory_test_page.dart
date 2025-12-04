import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Pages/theory_test_category_page.dart';
import 'package:pass_dvla_admin/Pages/theorytest_flagged_questions_page.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class TheoryTestPage extends StatefulWidget {
  const TheoryTestPage({super.key});

  @override
  State<TheoryTestPage> createState() => _TheoryTestPageState();
}

class _TheoryTestPageState extends State<TheoryTestPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const TheoryTestDesktopPage();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return const TheoryTestDesktopPage();
        } else {
          return const TheoryTestMobilePage();
        }
      },
    );
  }
}

class TheoryTestDesktopPage extends StatefulWidget {
  const TheoryTestDesktopPage({super.key});

  @override
  State<TheoryTestDesktopPage> createState() => _TheoryTestDesktopPageState();
}

class _TheoryTestDesktopPageState extends State<TheoryTestDesktopPage> {
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
                  //========== SIDEBAR WIDGET =========== //
                  Expanded(flex: 1, child: DesktopSideBarWidget()),

                  //========== SIDEBAR WIDGET =========== //
                  SizedBox(width: 8),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 0.74 * height,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 40.0,
                          left: 50.0,
                          right: 50.0,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => TheoryTestCategoryPage(),
                                  transition: Transition.noTransition,
                                );
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    "images/theme.png",
                                    height: 0.070 * height,
                                  ),
                                  SizedBox(width: 20.0),
                                  Text(
                                    "Categories",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                              ),
                              child: Container(
                                height: 0.0010 * height,
                                color: Colors.black26,
                                width: width,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => TheorytestFlaggedQuestionsPage(),
                                  transition: Transition.noTransition,
                                );
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    "images/flag.png",
                                    height: 0.070 * height,
                                  ),
                                  SizedBox(width: 20.0),
                                  Text(
                                    "Flagged questions",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                              ),
                              child: Container(
                                height: 0.0010 * height,
                                color: Colors.black26,
                                width: width,
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "images/speedometer.png",
                                  height: 0.070 * height,
                                ),
                                SizedBox(width: 20.0),
                                Text(
                                  "Progress monitor",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //  GridView.count(
                        //   physics: NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   crossAxisCount: 2,
                        //   childAspectRatio: 2 / 1,
                        //   children: [
                        //     InkWell(
                        //       onTap: () {
                        //         Get.to(() => RevisionQuestionsCategoryPage());
                        //       },
                        //       child: Padding(
                        //         padding: const EdgeInsets.only(
                        //           left: 15.0,
                        //           right: 5.0,
                        //         ),
                        //         child: Column(
                        //           children: [
                        //             Container(
                        //               height: 0.25 * height,
                        //               width: width,
                        //               decoration: BoxDecoration(
                        //                 color: Colors.white,
                        //                 borderRadius: BorderRadius.circular(10),
                        //                 boxShadow: [
                        //                   BoxShadow(
                        //                     color: Colors.black12,
                        //                     blurRadius: 7,
                        //                     offset: Offset(1, 2),
                        //                   ),
                        //                 ],
                        //               ),
                        //               alignment: Alignment.center,
                        //               child: Image.asset(
                        //                 "images/reading.png",
                        //                 height: 0.09 * height,
                        //               ),
                        //             ),
                        //             SizedBox(height: 20),
                        //             Text(
                        //               "Revision Questions",
                        //               overflow: TextOverflow.ellipsis,
                        //               textAlign: TextAlign.center,
                        //               style: GoogleFonts.poppins(
                        //                 color: Colors.black,
                        //                 fontSize: 13,
                        //                 fontWeight: FontWeight.w700,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     InkWell(
                        //       onTap: () {
                        //         // Get.to(
                        //         //   () => TheoryMockQuestionsCategoriesPage(),
                        //         // );
                        //       },
                        //       child: Padding(
                        //         padding: const EdgeInsets.only(
                        //           right: 15.0,
                        //           left: 5.0,
                        //         ),
                        //         child: Column(
                        //           children: [
                        //             Container(
                        //               height: 0.25 * height,
                        //               width: width,
                        //               decoration: BoxDecoration(
                        //                 color: Colors.white,
                        //                 borderRadius: BorderRadius.circular(10),
                        //                 boxShadow: [
                        //                   BoxShadow(
                        //                     color: Colors.black12,
                        //                     blurRadius: 7,
                        //                     offset: Offset(1, 2),
                        //                   ),
                        //                 ],
                        //               ),
                        //               alignment: Alignment.center,
                        //               child: Image.asset(
                        //                 "images/test.png",
                        //                 height: 0.080 * height,
                        //               ),
                        //             ),
                        //             SizedBox(height: 20),
                        //             Text(
                        //               "Mock test",
                        //               textAlign: TextAlign.center,
                        //               style: GoogleFonts.poppins(
                        //                 color: Colors.black,
                        //                 fontSize: 13,
                        //                 fontWeight: FontWeight.w700,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     InkWell(
                        //       onTap: () {
                        //         // Get.to(() => TheoryTestProgressIndicatorPage());
                        //       },
                        //       child: Padding(
                        //         padding: const EdgeInsets.only(
                        //           left: 15.0,
                        //           right: 5.0,
                        //         ),
                        //         child: Column(
                        //           children: [
                        //             Container(
                        //               height: 0.25 * height,
                        //               width: width,
                        //               decoration: BoxDecoration(
                        //                 color: Colors.white,
                        //                 borderRadius: BorderRadius.circular(10),
                        //                 boxShadow: [
                        //                   BoxShadow(
                        //                     color: Colors.black12,
                        //                     blurRadius: 7,
                        //                     offset: Offset(1, 2),
                        //                   ),
                        //                 ],
                        //               ),
                        //               alignment: Alignment.center,
                        //               child: Image.asset(
                        //                 "images/speedometer.png",
                        //                 height: 0.090 * height,
                        //               ),
                        //             ),
                        //             SizedBox(height: 20),
                        //             Text(
                        //               "Progress Monitor",
                        //               textAlign: TextAlign.center,
                        //               style: GoogleFonts.poppins(
                        //                 color: Colors.black,
                        //                 fontSize: 13,
                        //                 fontWeight: FontWeight.w700,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     InkWell(
                        //       onTap: () {
                        //         // Get.to(() => TheoryFlaggedQuestionPage());
                        //       },
                        //       child: Padding(
                        //         padding: const EdgeInsets.only(
                        //           right: 15.0,
                        //           left: 5.0,
                        //         ),
                        //         child: Column(
                        //           children: [
                        //             Container(
                        //               height: 0.25 * height,
                        //               width: width,
                        //               decoration: BoxDecoration(
                        //                 color: Colors.white,
                        //                 borderRadius: BorderRadius.circular(10),
                        //                 boxShadow: [
                        //                   BoxShadow(
                        //                     color: Colors.black12,
                        //                     blurRadius: 7,
                        //                     offset: Offset(1, 2),
                        //                   ),
                        //                 ],
                        //               ),
                        //               alignment: Alignment.center,
                        //               child: Image.asset(
                        //                 "images/flag.png",
                        //                 height: 0.10 * height,
                        //               ),
                        //             ),
                        //             SizedBox(height: 20),
                        //             Text(
                        //               "Flagged Questions",
                        //               textAlign: TextAlign.center,
                        //               style: GoogleFonts.roboto(
                        //                 color: Colors.black,
                        //                 fontSize: 13,
                        //                 fontWeight: FontWeight.w700,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
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

class TheoryTestMobilePage extends StatefulWidget {
  const TheoryTestMobilePage({super.key});

  @override
  State<TheoryTestMobilePage> createState() => _TheoryTestMobilePageState();
}

class _TheoryTestMobilePageState extends State<TheoryTestMobilePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //========== HEADER WIDGET =========== //
            HeaderMobileWidget(),
            //========== HEADER WIDGET =========== //
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 2 / 2.3,
              children: [
                InkWell(
                  onTap: () {
                    // Get.to(() => PracticeRevisionQuestions());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 5.0),
                    child: Column(
                      children: [
                        Container(
                          height: 0.25 * height,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 7,
                                offset: Offset(1, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            "images/reading.png",
                            height: 0.09 * height,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Revision Questions",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Get.to(
                    //   () => TheoryMockQuestionsCategoriesPage(),
                    // );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 5.0),
                    child: Column(
                      children: [
                        Container(
                          height: 0.25 * height,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 7,
                                offset: Offset(1, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            "images/test.png",
                            height: 0.080 * height,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Mock test",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Get.to(() => TheoryTestProgressIndicatorPage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 5.0),
                    child: Column(
                      children: [
                        Container(
                          height: 0.25 * height,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 7,
                                offset: Offset(1, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            "images/speedometer.png",
                            height: 0.090 * height,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Progress Monitor",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Get.to(() => TheoryFlaggedQuestionPage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 5.0),
                    child: Column(
                      children: [
                        Container(
                          height: 0.25 * height,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 7,
                                offset: Offset(1, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            "images/flag.png",
                            height: 0.10 * height,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Flagged Questions",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterWidget(),
    );
  }
}
