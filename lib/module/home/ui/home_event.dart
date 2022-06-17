import 'package:book_hotel/base/base_event.dart';
import 'package:book_hotel/shared_code/model/room_model.dart';

class GetRoomEvent extends BaseEvent {
  List<RoomModel> listRoom = [];
  GetRoomEvent(this.listRoom);
}
