// lib/viewmodels/base_viewmodel.dart
import 'package:flutter/material.dart';

enum ViewState { idle, busy, error }

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  String _errorMessage = '';

  ViewState get state => _state;
  String get errorMessage => _errorMessage;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
