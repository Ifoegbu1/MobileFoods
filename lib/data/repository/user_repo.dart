import 'package:e_commerce/data/api/api_client.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:get/get.dart';

class UserRepo {
  final ApiClient apiclient;

  UserRepo({required this.apiclient});

  Future<Response> getUserInfo() async {
    return await apiclient.getData(AppConstants.USER_INFO_URI);
  }
}
