
import 'package:get/get.dart';


class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
    } else {
      // showCustomSnackBar(response.statusText!, isError: true);
    }
  }
}
