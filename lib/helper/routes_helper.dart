// import 'package:llb_task/view/screens/home_screen/home_screen.dart';
import 'package:llb_task/view/screens/Product/product_screen.dart';
import 'package:llb_task/view/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class RoutesHelper {
  static const String splash = '/splash';
  static const String homeScreen = '/homeScreen';

  static String getSplashRoute() => splash;
  static String gethomeScreenRoute() => homeScreen;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: homeScreen, page: () => const ProductScreen()),
  ];
}
