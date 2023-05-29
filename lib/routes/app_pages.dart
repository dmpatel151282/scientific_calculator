import 'package:get/get.dart';
import 'package:scientific_calculator/modules/calculator/views/scientific_calculator_screen.dart';
import 'package:scientific_calculator/modules/general/views/splash_screen.dart';
import 'package:scientific_calculator/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.root,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.scientificCalculator,
      page: () => const ScientificCalculatorScreen(),
    ),
  ];
}
