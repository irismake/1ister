import 'package:flutter/material.dart';

class CustomRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _saveScreenView(
      {PageRoute<dynamic>? oldRoute,
      PageRoute<dynamic>? newRoute,
      String? routeType}) {
    RouteState().currentRoute = newRoute?.settings.name;
  }

  PageRoute? checkPageRoute(Route<dynamic>? route) {
    return (route is PageRoute) ? route : null;
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _saveScreenView(
      newRoute: checkPageRoute(route),
      oldRoute: checkPageRoute(previousRoute),
      routeType: 'push',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _saveScreenView(
      newRoute: checkPageRoute(newRoute),
      oldRoute: checkPageRoute(oldRoute),
      routeType: 'replace',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _saveScreenView(
      newRoute: checkPageRoute(previousRoute),
      oldRoute: checkPageRoute(route),
      routeType: 'pop',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _saveScreenView(
      newRoute: checkPageRoute(route),
      oldRoute: checkPageRoute(previousRoute),
      routeType: 'remove',
    );
  }
}

class RouteState {
  static final RouteState _instance = RouteState._internal();
  factory RouteState() => _instance;
  RouteState._internal();

  String? _currentRoute;
  set currentRoute(String? value) {
    _currentRoute = value;
  }

  int? get onCurrentRouteChanged {
    switch (_currentRoute) {
      case '/':
        return 0;
      case '/search':
        return 1;
      case '/edit':
        return 2;
      case '/bookmark':
        return 3;
      case '/user':
        return 4;
      default:
        return null;
    }
  }
}
