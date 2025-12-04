import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pass_dvla_admin/Pages/screen_controller_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const LoginDesktopPage();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth > 1200) {
          return const LoginDesktopPage();
        } else {
          return const LoginMobilePage();
        }
      },
    );
  }
}

class LoginDesktopPage extends StatefulWidget {
  const LoginDesktopPage({super.key});

  @override
  State<LoginDesktopPage> createState() => _LoginDesktopPageState();
}

class _LoginDesktopPageState extends State<LoginDesktopPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  String emailhint = "Email";
  String passwordhint = "Password";
  bool emailerror = false;
  bool passworderror = false;
  bool loading = false;
  bool hidepassword = true;

  void login(BuildContext context) {
    final box = GetStorage();
    box.write('isLoggedIn', true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ScreenControllerPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formkey,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/login_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            height: height,
            width: width,
            color: Colors.black45,
            alignment: Alignment.center,

            child: Container(
              height: 500,
              width: 450,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                border: Border.all(
                  color: Colors.red,
                  width: 5,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 7,
                    offset: Offset(1, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("images/appicon.jpg", height: 0.10 * height),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30.0,
                      left: 50.0,
                      right: 50.0,
                      bottom: 20.0,
                    ),
                    child: Container(
                      height: 0.060 * height,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(width: 15),
                          Image.asset(
                            "images/email.png",
                            height: 0.025 * height,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: TextFormField(
                              onTap: () {
                                if (emailerror == true) {
                                  setState(() {
                                    emailhint = "Required";
                                    emailerror = false;
                                  });
                                }
                              },
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                              cursorColor: Colors.black,
                              cursorErrorColor: Colors.black,
                              cursorHeight: 15,
                              controller: email,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: emailhint,
                                hintStyle: TextStyle(
                                  color: emailerror ? Colors.red : Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                                errorStyle: TextStyle(fontSize: 0.01),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  emailhint = "Required";
                                  emailerror = true;
                                  return "Required";
                                } else {
                                  if (email.text.isEmail == false) {
                                    email.clear();
                                    emailhint = "Invalid email";
                                    emailerror = true;
                                    return "Invalid email";
                                  }
                                }
                                return null;
                              },
                            ),
                          ),

                          SizedBox(width: 15),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 50.0,
                      right: 50.0,
                      bottom: 20.0,
                    ),
                    child: Container(
                      height: 0.060 * height,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(width: 15),
                          Image.asset(
                            "images/password.png",
                            height: 0.025 * height,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: TextFormField(
                              onTap: () {
                                if (passworderror == true) {
                                  setState(() {
                                    passworderror = false;
                                    passwordhint = "Password";
                                  });
                                }
                              },
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                              obscureText: hidepassword,
                              cursorColor: Colors.black,
                              cursorErrorColor: Colors.black,
                              cursorHeight: 15,
                              controller: password,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: passwordhint,
                                hintStyle: TextStyle(
                                  color: passworderror
                                      ? Colors.red
                                      : Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                                errorStyle: TextStyle(fontSize: 0.01),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  setState(() {
                                    passwordhint = "Required";
                                    passworderror = true;
                                  });
                                  return "Required";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              if (hidepassword == true) {
                                setState(() {
                                  hidepassword = false;
                                });
                              } else {
                                if (hidepassword == false) {
                                  setState(() {
                                    hidepassword = true;
                                  });
                                }
                              }
                            },
                            child: ImageIcon(
                              AssetImage(
                                hidepassword
                                    ? "images/view.png"
                                    : "images/hide.png",
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                        ],
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
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: email.text.trim(),
                                password: password.text.trim(),
                              )
                              .then((value) {
                                setState(() {
                                  loading = false;
                                  email.clear();
                                  password.clear();
                                });
                                Get.offAll(
                                  () => ScreenControllerPage(),
                                  transition: Transition.noTransition,
                                );
                              });
                        } catch (e) {
                          Get.snackbar(
                            "",
                            "",
                            borderWidth: 450,
                            backgroundColor: Colors.red,
                            titleText: Text(
                              "Error!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            messageText: Text(
                              "Please try again",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                          setState(() {
                            loading = false;
                          });
                        }
                      }
                    },
                    child: Container(
                      height: 55,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(7),
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
                              "Sign in",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginMobilePage extends StatefulWidget {
  const LoginMobilePage({super.key});

  @override
  State<LoginMobilePage> createState() => _LoginMobilePageState();
}

class _LoginMobilePageState extends State<LoginMobilePage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  String emailhint = "Email";
  String passwordhint = "Password";
  bool emailerror = false;
  bool passworderror = false;
  bool loading = false;
  bool hidepassword = true;

  void login(BuildContext context) {
    final box = GetStorage();
    box.write('isLoggedIn', true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ScreenControllerPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formkey,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/login_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),

          child: Container(
            height: height,
            width: width,
            color: Colors.black45,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Container(
                height: 0.50 * height,
                width: 450,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.red,
                    width: 5,
                    style: BorderStyle.solid,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 7,
                      offset: Offset(1, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("images/appicon.jpg", height: 0.10 * height),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30.0,
                        left: 25.0,
                        right: 25.0,
                        bottom: 15.0,
                      ),
                      child: Container(
                        height: 0.060 * height,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Image.asset(
                              "images/email.png",
                              height: 0.025 * height,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: TextFormField(
                                onTap: () {
                                  if (emailerror == true) {
                                    setState(() {
                                      emailhint = "Required";
                                      emailerror = false;
                                    });
                                  }
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                                cursorColor: Colors.black,
                                cursorErrorColor: Colors.black,
                                cursorHeight: 15,
                                controller: email,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: emailhint,
                                  hintStyle: TextStyle(
                                    color: emailerror
                                        ? Colors.red
                                        : Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  errorStyle: TextStyle(fontSize: 0.01),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    emailhint = "Required";
                                    emailerror = true;
                                    return "Required";
                                  } else {
                                    if (email.text.isEmail == false) {
                                      email.clear();
                                      emailhint = "Invalid email";
                                      emailerror = true;
                                      return "Invalid email";
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 15),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25.0,
                        bottom: 15.0,
                      ),
                      child: Container(
                        height: 0.060 * height,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Image.asset(
                              "images/password.png",
                              height: 0.025 * height,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: TextFormField(
                                onTap: () {
                                  if (passworderror == true) {
                                    setState(() {
                                      passworderror = false;
                                      passwordhint = "Password";
                                    });
                                  }
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                                obscureText: hidepassword,
                                cursorColor: Colors.black,
                                cursorErrorColor: Colors.black,
                                cursorHeight: 15,
                                controller: password,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: passwordhint,
                                  hintStyle: TextStyle(
                                    color: passworderror
                                        ? Colors.red
                                        : Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  errorStyle: TextStyle(fontSize: 0.01),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      passwordhint = "Required";
                                      passworderror = true;
                                    });
                                    return "Required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 15),
                            InkWell(
                              onTap: () {
                                if (hidepassword == true) {
                                  setState(() {
                                    hidepassword = false;
                                  });
                                } else {
                                  if (hidepassword == false) {
                                    setState(() {
                                      hidepassword = true;
                                    });
                                  }
                                }
                              },
                              child: ImageIcon(
                                AssetImage(
                                  hidepassword
                                      ? "images/view.png"
                                      : "images/hide.png",
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                          ],
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
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                  email: email.text.trim(),
                                  password: password.text.trim(),
                                )
                                .then((value) {
                                  setState(() {
                                    loading = false;
                                    email.clear();
                                    password.clear();
                                  });
                                  Get.offAll(
                                    () => ScreenControllerPage(),
                                    transition: Transition.noTransition,
                                  );
                                });
                          } catch (e) {
                            Get.snackbar(
                              "",
                              "",
                              borderWidth: 450,
                              backgroundColor: Colors.red,
                              titleText: Text(
                                "Error!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              messageText: Text(
                                "Please try again",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                            setState(() {
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Container(
                          height: 0.060 * height,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(7),
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
                                  "Sign in",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
