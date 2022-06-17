import 'package:book_hotel/base/base_event.dart';
import 'package:book_hotel/shared_code/model/search_model.dart';

class GetSearchRoomEvent extends BaseEvent {
  List<SearchModel> listRoom = [];
  GetSearchRoomEvent(this.listRoom);
}

class PostSearchRoomEvent extends BaseEvent {
  final String query;
  final int idCategory;

  PostSearchRoomEvent({required this.query, required this.idCategory});
}