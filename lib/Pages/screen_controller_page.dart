import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pass_dvla_admin/Pages/access_denied_page.dart';
import 'package:pass_dvla_admin/Pages/home_page.dart';
import 'package:pass_dvla_admin/Pages/loading_page.dart';

class ScreenControllerPage extends StatefulWidget {
  const ScreenControllerPage({super.key});

  @override
  State<ScreenControllerPage> createState() => _ScreenControllerPageState();
}

class _ScreenControllerPageState extends State<ScreenControllerPage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(user?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingPage();
        }
        return snapshot.data?["role"] == "admin"
            ? HomePage()
            : AccessDeniedPage();
      },
    );
  }
}
