import 'package:book_hotel/base/base_event.dart';
import 'package:book_hotel/shared_code/model/favorite_model.dart';

class FavoriteLoadData extends BaseEvent {
  final List<Favorite> listFavorite;

  FavoriteLoadData(this.listFavorite);
}
