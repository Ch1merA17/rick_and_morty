import 'package:flutter/widgets.dart';
import 'package:rick_and_morty/app/app.dart';
import 'package:rick_and_morty/app/app_assembly.dart';
import 'package:rick_and_morty/app/route_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appAssembly = AppAssembly();
  await appAssembly.init();
  final routeGenerator = RouteGenerator.create(assembly: appAssembly);

  runApp(
    RickAndMortyApp(appAssembly: appAssembly, routeGenerator: routeGenerator),
  );
}
