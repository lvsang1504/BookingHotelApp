import 'package:book_hotel/base/base_event.dart';

class NoImageShowEvent extends BaseEvent {
  NoImageShowEvent({required this.message});

  final String message;
}
