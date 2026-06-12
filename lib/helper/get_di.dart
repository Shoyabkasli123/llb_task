import 'dart:convert';

import 'package:llb_task/controller/localisation_controller.dart';
import 'package:llb_task/controller/product_controller.dart';
import 'package:llb_task/data/api/api_client.dart';
import 'package:llb_task/data/repo/localisation_repo.dart';
import 'package:llb_task/data/repo/product_repo.dart';
import 'package:llb_task/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/response/languages_model.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  // repo
  Get.lazyPut(() => LocalisationRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
    () => ApiClient(
      appBaseUrl: AppConstant.appBaseUrl,
      sharedPreferences: Get.find(),
    ),
  );
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));

  // controller
  Get.lazyPut(
    () => LocalizationController(
      sharedPreferences: Get.find(),
      splashRepo: Get.find(),
    ),
  );
  Get.lazyPut(() => ProductController(productRepo: Get.find()));

  Map<String, Map<String, String>> language = {};
  try {
    for (LanguageModel languageModel in AppConstant.languages) {
      String jsonStringsValues = await rootBundle.loadString(
        "assets/languages/${languageModel.languageCode}.json",
      );

      Map<String, dynamic> mappedJson = jsonDecode(jsonStringsValues);
      Map<String, String> json = {};
      mappedJson.forEach((key, value) {
        json[key] = value.toString();
      });
      language['${languageModel.languageCode}_${languageModel.countryCode}'] =
          json;
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return language;
}
