import 'package:e_commerce/data/api/api_client.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    //pass end-point of uri to getData
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
 