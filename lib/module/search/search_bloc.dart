import 'package:book_hotel/base/base_bloc.dart';
import 'package:book_hotel/base/base_event.dart';
import 'package:book_hotel/data/repository/home_repository.dart';
import 'package:book_hotel/data/repository/search_repository.dart';
import 'package:book_hotel/event/base_event/expired_token_event.dart';
import 'package:book_hotel/event/base_event/no_data_show_event.dart';
import 'package:book_hotel/event/base_event/unknown_error_event.dart';
import 'package:book_hotel/module/home/ui/home_event.dart';
import 'package:book_hotel/module/search/search_event.dart';
import 'package:book_hotel/shared_code/dialog_manager/data_models/type_dialog.dart';
import 'package:book_hotel/shared_code/dialog_manager/locator.dart';
import 'package:book_hotel/shared_code/dialog_manager/services/dialog_service.dart';
import 'package:book_hotel/shared_code/model/category_model.dart';
import 'package:book_hotel/shared_code/model/search_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends BaseBloc with ChangeNotifier {
  final SearchRepository searchRepository;

  final DialogService _dialogService = locator<DialogService>();

  SearchBloc({required this.searchRepository});

  final _listSearchRoom = BehaviorSubject<BaseEvent>();

  Stream<BaseEvent> get listSearchRoom => _listSearchRoom.stream;

  Sink<BaseEvent> get listSearchRoomSink => _listSearchRoom.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case PostSearchRoomEvent:
        handleSearch(event);
        break;
      default:
        break;
    }
  }

  void handleSearch(BaseEvent event) {
    final e = event as PostSearchRoomEvent;
    loadListRoomByCategory(e.query, e.idCategory);
  }

  Stream<BaseEvent> loadListRoomByCategory(String query, int idCategory) {
    getRoom(query, idCategory);
    return listSearchRoom;
  }

  getRoom(String query, int idCategory) {
    searchRepository.getAllResultSearch(query, idCategory).then(
      (result) async {
        print("Seacrh success: ${result.length}");
        listSearchRoomSink.add(GetSearchRoomEvent(result));

        loadingSink.add(false); // hide loading
      },
      onError: (e) {
        loadingSink.add(false); // hide loading
        print(e);
        if (e == 401 || e == 'unauthorized') {
          doShowDialog(
            description: "???? h???t phi??n ????ng nh???p. Vui l??ng ????ng nh???p l???i.",
            event: ExpiredTokenEvent(),
            typeDialog: ERROR_DIALOG,
          );
        } else {
          doShowDialog(
            description: "X???y ra l???i kh??ng x??c ?????nh trong qu?? tr??nh th???c thi",
            event: UnknownErrorEvent(
                message: "X???y ra l???i kh??ng x??c ?????nh trong qu?? tr??nh th???c thi"),
            typeDialog: ERROR_DIALOG,
          );
        }
      },
    );
  }

  Future<void> doShowDialog(
      {required String description,
      required BaseEvent event,
      String title = '',
      String typeDialog = ''}) async {
    final dialogResult = await _dialogService.showDialog(
      title: title.isNotEmpty ? title : "Th??ng tin",
      description: description,
      typeDialog: typeDialog.isEmpty ? typeDialog : DIALOG_ONE_BUTTON,
    );

    if (dialogResult.confirmed) {
      // Check event
      handleEventDialog(event);
    } else {
      //print('User do not logout!');
    }
  }

  void handleEventDialog(BaseEvent event) {
    switch (event.runtimeType) {
      case ExpiredTokenEvent:
        processEventSink.add(ExpiredTokenEvent()); // Notify ExpiredToken
        break;
      case NoDataShowEvent:
        processEventSink.add(NoDataShowEvent());
        break;
      case UnknownErrorEvent:
        final e = event as UnknownErrorEvent;
        processEventSink.add(UnknownErrorEvent(message: e.message));
        break;
      default:
        break;
    }
  }
}
