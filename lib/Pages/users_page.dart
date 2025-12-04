import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_dvla_admin/Pages/loading_page.dart';
import 'package:pass_dvla_admin/Pages/user_details_page.dart';
import 'package:pass_dvla_admin/Widgets/footer_widget.dart';
import 'package:pass_dvla_admin/Widgets/header_widget.dart';
import 'package:pass_dvla_admin/Widgets/sidebar_widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const UsersDesktopPage();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return const UsersDesktopPage();
        } else {
          return const UsersMobilePage();
        }
      },
    );
  }
}

class UsersDesktopPage extends StatefulWidget {
  const UsersDesktopPage({super.key});

  @override
  State<UsersDesktopPage> createState() => _UsersDesktopPageState();
}

class _UsersDesktopPageState extends State<UsersDesktopPage> {
  int currentPage = 0;
  final int itemsPerPage = 5;
  final int maxVisibleButtons = 4;
  String searchQuery = '';
  final TextEditingController search = TextEditingController();
  final roles = <String>['All roles', 'Admin', 'User'];
  String? selectedValue;
  bool roleselected = false;

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
                        stream: roleselected == false
                            ? FirebaseFirestore.instance
                                  .collection("users")
                                  .orderBy('name')
                                  //.limit(_currentPage * _perPage)
                                  .snapshots()
                            : FirebaseFirestore.instance
                                  .collection("users")
                                  .where(
                                    "role",
                                    isEqualTo: selectedValue!.toLowerCase(),
                                  )
                                  .snapshots(),
                        builder: (context, userssnapshot) {
                          if (!userssnapshot.hasData) {
                            return LoadingPage();
                          }
                          final allDocs = userssnapshot.data!.docs.where((doc) {
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
                                    "No users found.",
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
                                        roleselected = false;
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
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(
                              50.0,
                              50.0,
                              50.0,
                              0,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
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
                                        "Add new user",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Container(
                                      height: 0.065 * height,
                                      width: 0.33 * width,
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
                                    SizedBox(width: 25),
                                    Icon(
                                      Icons.tune_outlined,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 30),
                                    DropdownButton<String>(
                                      dropdownColor: Colors.white,
                                      value: selectedValue,
                                      hint: Text(
                                        "All roles",
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      items: roles.map((item) {
                                        return DropdownMenuItem(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value;
                                          roleselected = true;
                                        });
                                      },
                                    ),
                                    SizedBox(width: 20),
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
                                        "${userssnapshot.data!.docs.length} Users",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 0.070 * height,
                                  color: Colors.grey[200],
                                  width: width,
                                  child: Row(
                                    children: [
                                      SizedBox(width: 20),
                                      ImageIcon(AssetImage("images/user.png")),
                                      SizedBox(width: 35),

                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Role",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Name",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Email",
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
                                SizedBox(height: 10.0),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10.0,
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: visibleDocs.length,
                                      itemBuilder: (context, index) {
                                        final user = visibleDocs[index].data();
                                        return InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => UserDetailsPage(
                                                uid: user["uid"],
                                              ),
                                              transition:
                                                  Transition.noTransition,
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 15.0,
                                            ),
                                            child: Row(
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
                                                      "images/user.png",
                                                      color: Colors.white,
                                                      height: 45,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 30),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    user["role"],
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),

                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    user["name"],
                                                    textAlign: TextAlign.left,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),

                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    user["email"],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
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
                                  padding: const EdgeInsets.only(bottom: 20.0),

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
                                              borderRadius:
                                                  BorderRadius.circular(7),
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
                                              borderRadius:
                                                  BorderRadius.circular(7),
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
                            ),
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

class UsersMobilePage extends StatefulWidget {
  const UsersMobilePage({super.key});

  @override
  State<UsersMobilePage> createState() => _UsersMobilePageState();
}

class _UsersMobilePageState extends State<UsersMobilePage> {
  bool roleselected = false;
  int currentPage = 0;
  final int itemsPerPage = 7;
  final int maxVisibleButtons = 4;
  String searchQuery = '';
  final TextEditingController search = TextEditingController();
  final roles = <String>['All roles', 'Admin', 'User'];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderMobileWidget(),
            StreamBuilder(
              stream: roleselected == false
                  ? FirebaseFirestore.instance
                        .collection("users")
                        .orderBy('name')
                        //.limit(_currentPage * _perPage)
                        .snapshots()
                  : FirebaseFirestore.instance
                        .collection("users")
                        .where("role", isEqualTo: selectedValue!.toLowerCase())
                        .snapshots(),
              builder: (context, userssnapshot) {
                if (!userssnapshot.hasData) {
                  return LoadingPage();
                }
                final allDocs = userssnapshot.data!.docs.where((doc) {
                  final data = doc.data();
                  final name = data['name']?.toString().toLowerCase() ?? '';
                  return name.contains(searchQuery);
                }).toList();

                if (allDocs.isEmpty) {
                  return Container(
                    height: height,
                    width: width,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "No users found.",
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
                              roleselected = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Icon(Icons.refresh, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final totalPages = (allDocs.length / itemsPerPage).ceil();
                currentPage = currentPage.clamp(0, totalPages - 1);

                final startIndex = currentPage * itemsPerPage;
                final endIndex = (startIndex + itemsPerPage).clamp(
                  0,
                  allDocs.length,
                );
                final visibleDocs = allDocs.sublist(startIndex, endIndex);

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
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 20.0,
                      ),
                      child: Container(
                        height: 0.060 * height,
                        width: width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(5),
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
                                  cursorColor: Colors.white,
                                  cursorHeight: 14,
                                  onChanged: (value) => setState(
                                    () => searchQuery = value.toLowerCase(),
                                  ),
                                  controller: search,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search",
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 0.065 * height,
                              width: 0.15 * width,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 7,
                                    offset: Offset(1, 2),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Icon(Icons.search, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20.0,
                        20.0,
                        20.0,
                        20.0,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.tune_outlined, color: Colors.red),
                          SizedBox(width: 30),
                          DropdownButton<String>(
                            dropdownColor: Colors.white,
                            value: selectedValue,
                            hint: Text(
                              "All roles",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            items: roles.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                                roleselected = true;
                              });
                            },
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              height: 0.065 * height,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 7,
                                    offset: Offset(1, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  top: 12.0,
                                  right: 15.0,
                                  bottom: 12.0,
                                ),
                                child: Text(
                                  "${userssnapshot.data!.docs.length} Users",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                      child: SizedBox(
                        height: 0.48 * height,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: visibleDocs.length,
                          itemBuilder: (context, index) {
                            final user = visibleDocs[index].data();
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 0.065 * height,
                                      width: width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        user["name"],
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => UserDetailsPage(uid: user["uid"]),
                                        transition: Transition.noTransition,
                                      );
                                    },
                                    child: Icon(
                                      Icons.edit_note,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),

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
                              onTap: () => setState(() => currentPage--),
                              child: Container(
                                height: 0.060 * height,
                                width: 0.10 * width,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(7),
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
                                onTap: () => setState(() => currentPage = i),
                                child: Container(
                                  height: 0.060 * height,
                                  width: 0.10 * width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                    color: i == currentPage
                                        ? Colors.red
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(7),
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
                              onTap: () => setState(() => currentPage++),
                              child: Container(
                                height: 0.060 * height,
                                width: 0.10 * width,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(7),
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
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: () {},
        label: Text(
          "Add new",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: FooterWidget(),
    );
  }
}
