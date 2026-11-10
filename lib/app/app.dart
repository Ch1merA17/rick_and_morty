import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app/app_assembly.dart';
import 'package:rick_and_morty/app/app_router.dart';
import 'package:rick_and_morty/app/route_generator.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme.dart';
import 'package:rick_and_morty/common/ui/themes/app_theme_cubit.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({
    super.key,
    required this.appAssembly,
    required this.routeGenerator,
  });

  final AppAssembly appAssembly;
  final RouteGenerator routeGenerator;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(create: (_) => AppRouter()),
        BlocProvider(create: (_) => appAssembly.createAppThemeCubit()),
      ],
      child: BlocBuilder<AppThemeCubit, ThemeMode>(
        builder: (context, themeMode) => MaterialApp(
          title: 'Rick and Morty',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: themeMode,
          navigatorKey: AppRouter.of(context).navigatorKey,
          initialRoute: AppRoutes.root,
          onGenerateRoute: routeGenerator.generateRoute,
        ),
      ),
    );
  }
}
