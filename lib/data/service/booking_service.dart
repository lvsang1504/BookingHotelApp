import 'package:book_hotel/api/app_client.dart';
import 'package:dio/dio.dart';

class BookingService {
  Future<Response> pushCreateBooking(
      String idRoom, String checkIn, String checkOut, int numberOfDays) {
    return AppClientCookie.instance.dio.get(
        "/booking/$idRoom/create?checkin=$checkIn&checkout=$checkOut&numberOfDays=$numberOfDays&clientMessage=any");
  }

  Future<Response> getAllBookingHistory() {
    return AppClientCookie.instance.dio.get("/user/booked-rooms?query=");
  }

  Future<Response> cancleBooking(String id) {
    return AppClientCookie.instance.dio.put("/booking/" + id + "/user/canceled");
  }
}
