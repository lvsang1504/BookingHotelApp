import 'package:book_hotel/api/app_client.dart';
import 'package:dio/dio.dart';

class LoginService {

  final String tagLogin = "/auth/login";

  Future<Response> loginService({required String username, required String password}) async {
    return AppClient.instance.dio.post(tagLogin, data: {'email': username, 'password': password});
  }
}
