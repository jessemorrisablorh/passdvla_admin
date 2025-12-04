import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 0.060 * height,
          width: 0.060 * width,
          alignment: Alignment.center,
          child: CircularProgressIndicator(color: Colors.red, strokeWidth: 3),
        ),
      ),
    );
  }
}
