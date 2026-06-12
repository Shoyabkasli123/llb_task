import 'dart:io';

import 'package:llb_task/controller/localisation_controller.dart';
import 'package:llb_task/themes/light.dart';
import 'package:llb_task/utils/app_constant.dart';
import 'package:llb_task/utils/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase/firebase.dart';
import 'helper/get_di.dart' as di;
import 'helper/routes_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Map<String, Map<String, String>> languages = await di.init();
  runApp(MyApp(languages: languages));
}

class MyApp extends StatefulWidget {
  final Map<String, Map<String, String>> languages;

  const MyApp({super.key, required this.languages});
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localisationController) {
        return GetMaterialApp(
          theme: light,
          getPages: RoutesHelper.routes,
          initialRoute: RoutesHelper.getSplashRoute(),
          defaultTransition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
          title: AppConstant.appName,
          locale: localisationController.locale,
          debugShowCheckedModeBanner: false,
          translations: Messages(languages: widget.languages),
          fallbackLocale: Locale(
            AppConstant.languages[0].languageCode!,
            AppConstant.languages[0].countryCode,
          ),
        );
      },
    );
  }
}
