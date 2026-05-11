import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meme_app/Home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
 State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFD400),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// 🔥 Meme Face
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(35),
              ),
              child: const Center(
                child: Text(
                  "🔥",
                  style: TextStyle(fontSize: 70),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// 🔥 App Name
            const Text(
              "MEME",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 10),

            /// ✨ Tagline
            const Text(
              "SCROLL • LAUGH • REPEAT",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 50),

            /// ⚡ Loading Indicator
            const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}