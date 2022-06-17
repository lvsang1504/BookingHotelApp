import 'package:book_hotel/shared_code/model/search_model.dart';

class SearchResponse {
  bool? success;
  List<SearchModel>? data;
  String? error;

  SearchResponse({this.success, this.data, this.error});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SearchModel>[];
      json['data'].forEach((v) {
        data!.add(SearchModel.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    return data;
  }
}