import 'package:book_hotel/base/base_event.dart';
import 'package:book_hotel/shared_code/model/room_detail.dart';

class GetRoomDetail extends BaseEvent {
  final RoomDetail roomDetail;

  GetRoomDetail(this.roomDetail);
}
