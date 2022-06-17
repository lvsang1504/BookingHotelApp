import 'package:book_hotel/api/app_client.dart';
import 'package:book_hotel/shared_code/model/user_send.dart';
import 'package:dio/dio.dart';

class SignUpService {
  final String tagLogin = "/auth/register";

  Future<Response> signUpService({required UserSend userSend}) async {
    return AppClient.instance.dio.post(tagLogin, data: userSend.toJson());
  }
 
}
