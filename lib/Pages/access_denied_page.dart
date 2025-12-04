import 'package:flutter/material.dart';

class AccessDeniedPage extends StatefulWidget {
  const AccessDeniedPage({super.key});

  @override
  State<AccessDeniedPage> createState() => _AccessDeniedPageState();
}

class _AccessDeniedPageState extends State<AccessDeniedPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("images/road.png", height: 0.15 * height),
            SizedBox(height: 10),
            Text(
              "Access denied!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "This user is not an admin",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
