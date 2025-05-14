
import 'package:flutter/material.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(Widget screen) {
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}