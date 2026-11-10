import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => navigatorKey.currentState!;

  static AppRouter of(BuildContext context) => context.read<AppRouter>();

  Future<T?> push<T>(String name, {Object? arguments}) =>
      _navigator.pushNamed<T>(name, arguments: arguments);

  void back<T extends Object?>([T? result]) => _navigator.pop(result);
}
