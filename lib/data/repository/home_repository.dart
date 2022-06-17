import 'dart:async';
import 'dart:convert';

import 'package:book_hotel/data/service/base_service.dart';
import 'package:book_hotel/data/service/home_service.dart';
import 'package:book_hotel/shared_code/model/category_model.dart';
import 'package:book_hotel/shared_code/model/category_response.dart';
import 'package:book_hotel/shared_code/model/favorite_reponse.dart';
import 'package:book_hotel/shared_code/model/room_model.dart';
import 'package:book_hotel/shared_code/model/room_response.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  final HomeService homeService;

  HomeRepository({required this.homeService});

  // Danh sách loại phòng
  Future<List<CategoryModel>> getCategoryList() async {
    var c = Completer<List<CategoryModel>>();

    try {
      final response = await homeService.fetchCategoryList();

      List<CategoryModel> data = CategoryResponse.fromJson(response.data).data;

      c.complete(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError("Kết nối bị hết hạn");
      }
      c.completeError(e.toString());
    } catch (ex) {
      c.completeError(ex.toString());
    }

    return c.future;
  }

  // Danh sách phòng theo loại
  Future<List<RoomModel>> getRoomByCategory(String id) async {
    var c = Completer<List<RoomModel>>();

    try {
      final response = await homeService.fetchRoomList(id);

      List<RoomModel> data = RoomResponse.fromJson(response.data).rooms;

      c.complete(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError("Kết nối bị hết hạn");
      }
      c.completeError(e.toString());
    } catch (ex) {
      c.completeError(ex.toString());
    }

    return c.future;
  }

  // Lấy số lượng phòng yêu thích
  Future<List<int>> getFavoriteListId() async {
    var c = Completer<List<int>>();

    try {
      final response = await homeService.fetchFavoriteIdList();

      List<int> data = FavoriteResponse.fromJson(response.data).data; //response.data;

          print("Data: ${data.length}");

      c.complete(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError("Kết nối bị hết hạn");
      }
      c.completeError(e.toString());
    } catch (ex) {
      c.completeError(ex.toString());
    }

    return c.future;
  }
}
