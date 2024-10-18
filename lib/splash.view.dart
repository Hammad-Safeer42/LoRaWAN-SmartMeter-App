import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_v101/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.AUTH); // Navigate to the login page using GetX
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 1.sw,
              height: 0.25.sh,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("imgs/splash_top.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 100),
            Expanded(
              child: Container(
                width: 245,
                height: 227,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("imgs/logo.png"),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 1.sw,
                height: 0.45.sh,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("imgs/splash_bottom.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'App Version 1.01',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        color: Color(0xFF616161),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
