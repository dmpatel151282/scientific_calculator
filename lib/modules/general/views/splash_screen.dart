import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scientific_calculator/routes/app_routes.dart';
import 'package:scientific_calculator/utils/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Timer(const Duration(seconds: 3), () async {
        Get.offAndToNamed(AppRoutes.scientificCalculator);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodySection(),
    );
  }

  Widget bodySection() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SvgPicture.asset(
              "assets/images/calculator.svg",
              width: 100.w,
            ),
          ),
          SizedBox(height: 50.h),
          Text(
            "Scientific Calculator".toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
