import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Pages/add_road_sign_page.dart';
import 'package:pass_dvla_admin/Pages/flagged_road_signs_page.dart';
import 'package:pass_dvla_admin/Pages/hazard_perception_introduction_video_page.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class HazardperceptionPage extends StatefulWidget {
  const HazardperceptionPage({super.key});

  @override
  State<HazardperceptionPage> createState() => _HazardperceptionPageState();
}

class _HazardperceptionPageState extends State<HazardperceptionPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const HazardPerceptionDesktopPage();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return const HazardPerceptionDesktopPage();
        } else {
          return const HazardPercetionMobilePage();
        }
      },
    );
  }
}

class HazardPerceptionDesktopPage extends StatefulWidget {
  const HazardPerceptionDesktopPage({super.key});

  @override
  State<HazardPerceptionDesktopPage> createState() =>
      _HazardPerceptionDesktopPageState();
}

class _HazardPerceptionDesktopPageState
    extends State<HazardPerceptionDesktopPage> {
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
                                  () => HazardPerceptionIntroductionVideoPage(),
                                  transition: Transition.noTransition,
                                );
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    "images/video.png",
                                    height: 0.070 * height,
                                  ),
                                  SizedBox(width: 20.0),
                                  Text(
                                    "introduction video",
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
                                // Get.to(
                                //   () => FlaggedRoadSignsPage(),
                                //   transition: Transition.noTransition,
                                // );
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    "images/video.png",
                                    height: 0.070 * height,
                                  ),
                                  SizedBox(width: 20.0),
                                  Text(
                                    "Short clips",
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
                                // Get.to(
                                //   () => AddRoadSignPage(),
                                //   transition: Transition.noTransition,
                                // );
                              },
                              child: Row(
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
    );
  }
}

class HazardPercetionMobilePage extends StatefulWidget {
  const HazardPercetionMobilePage({super.key});

  @override
  State<HazardPercetionMobilePage> createState() =>
      _HazardPercetionMobilePageState();
}

class _HazardPercetionMobilePageState extends State<HazardPercetionMobilePage> {
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
                            "images/barrier.png",
                            height: 0.09 * height,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Introduction",
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
                            "images/video.png",
                            height: 0.080 * height,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Prctice video clips",
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
                            "images/quiz.png",
                            height: 0.090 * height,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Quiz",
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
                            "images/speedometer.png",
                            height: 0.10 * height,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Progress monitor",
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
