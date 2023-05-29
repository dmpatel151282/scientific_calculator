import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scientific_calculator/routes/app_pages.dart';
import 'package:scientific_calculator/routes/app_routes.dart';
import 'package:scientific_calculator/utils/constants.dart';
import 'package:scientific_calculator/utils/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) {
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return ScreenUtilInit(
      designSize: const Size(411, 731),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('en', 'US'),
          initialRoute: AppRoutes.root,
          title: "Scientific Calculator",
          theme: ThemeData(
            primarySwatch: kPrimarySwatch,
            primaryColor: kPrimaryColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: kPrimaryColor,
              surfaceTintColor: kPrimaryColor,
            ),
            textTheme: Typography.englishLike2018.apply(
              fontFamily: fontFamily,
              fontSizeFactor: 1.0.sp,
              bodyColor: Colors.black,
            ),
          ),
          getPages: AppPages.pages,
        );
      },
    );
  }
}
