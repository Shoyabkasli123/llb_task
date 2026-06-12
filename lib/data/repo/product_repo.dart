import 'package:get/get.dart';
import 'package:llb_task/data/api/api_client.dart';
import 'package:llb_task/utils/app_constant.dart';

class ProductRepo {
  final ApiClient apiClient;

  ProductRepo({required this.apiClient});

  Future<Response> getAllProductList({
    required int limit,
    required int skip,
  }) async {
    return apiClient.getData(
      '${AppConstant.getProductsList}?limit=$limit&skip=$skip',
    );
  }
}
