import 'dart:async';

import 'package:book_hotel/base/base_bloc.dart';
import 'package:book_hotel/base/base_event.dart';
import 'package:book_hotel/data/repository/login_repository.dart';
import 'package:book_hotel/data/shared_preferences/shared_preferences.dart';
import 'package:book_hotel/event/login/login_event.dart';
import 'package:book_hotel/event/login/login_fail_event.dart';
import 'package:book_hotel/event/login/login_success_event.dart';
import 'package:book_hotel/utils/materials/constant.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BaseBloc with ChangeNotifier {
  LoginBloc({required LoginRepository loginRepository}) {
    _loginRepository = loginRepository;
  }

  late LoginRepository _loginRepository;

  final _userNameSubject = BehaviorSubject<String>();

  Stream<String> get userNameStream => _userNameSubject.stream;

  Sink<String> get userNameSink => _userNameSubject.sink;

  final _passwordSubject = BehaviorSubject<String>();

  Stream<String> get passwordStream => _passwordSubject.stream;

  Sink<String> get passwordSink => _passwordSubject.sink;

  final _btnLoginSubject = BehaviorSubject<bool>();

  Stream<bool> get btnLoginStream => _btnLoginSubject.stream;

  Sink<bool> get btnLoginSink => _btnLoginSubject.sink;

  final _strVersionSubject = BehaviorSubject<String>();

  Stream<String> get strVersionStream => _strVersionSubject.stream;

  Sink<String> get strVersionSink => _strVersionSubject.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case LoginEvent:
        final e = event as LoginEvent;
        handleLogin(e);
        break;
    }
  }

  void handleLogin(LoginEvent e) {
    btnLoginSink.add(false); // When Start call api => Disable Login Button
    loadingSink.add(true); // Show loading

    if (e.username.isEmpty) {
      btnLoginSink.add(true); // Result is not null => Enable Button
      loadingSink.add(false); // Hide loading
      processEventSink.add(LoginFailEvent('Please Input User Name'));
    } else if (e.password.isEmpty) {
      btnLoginSink.add(true); // Result is not null => Enable Button
      loadingSink.add(false); // Hide loading
      processEventSink.add(LoginFailEvent('Please Input Password'));
    } else {
      _loginRepository
          .login(username: e.username, password: e.password)
          .asStream()
          .first
          .then(
        (result) {
          if (result.data != null) {
            // Save token
            SPref.instance
                .set(SPrefCache.KEY_ACCESS_TOKEN, result.data!.cookie!);

            print(SPref.instance
                .get(SPrefCache.KEY_ACCESS_TOKEN));
            SPref.instance.set(SPrefCache.USER_NAME, e.username);
            processEventSink
                .add(LoginSuccessEvent(token: result.data!.cookie!));
          } else {
            processEventSink
                .add(LoginFailEvent('Error Login')); // Notify Result
          }
          btnLoginSink.add(true); // Result is not null => Enable Button
          loadingSink.add(false); // Hide loading
        },
        onError: (e) {
          print(e);
          btnLoginSink.add(true); // Result is not null => Enable Button
          loadingSink.add(false); // Hide loading
          processEventSink.add(LoginFailEvent('Error Login')); // Notify Result
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();

    _userNameSubject.close();
    _passwordSubject.close();
    _btnLoginSubject.close();
    _strVersionSubject.close();
  }
}
