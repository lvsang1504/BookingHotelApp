import 'package:book_hotel/base/base_event.dart';

class SignUpSuccessEvent extends BaseEvent {
  SignUpSuccessEvent({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}
