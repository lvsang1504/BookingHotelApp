import 'package:book_hotel/base/base_event.dart';

class SignUpFailEvent extends BaseEvent {
  SignUpFailEvent(this.errMessage);

  final String errMessage;
}
