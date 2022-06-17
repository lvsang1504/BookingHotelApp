import 'package:book_hotel/api/app_client.dart';
import 'package:dio/dio.dart';

class RegisterService {
  final String tagRegister = "/auth/register";
  final String tagGender = "/user/sex";
  Future<Response> register({required Map<String, dynamic> data}) async {
    return AppClient.instance.dio.post(tagRegister, data: data);
  }

  Future<Response> getGender() async {
    return AppClient.instance.dio.get(tagGender);
  }
}
