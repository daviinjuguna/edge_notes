import 'package:flutter/material.dart';

import 'routes/app_router.dart';
import 'utils/app_theme.dart';

class EdgeNotesApp extends StatefulWidget {
  const EdgeNotesApp({super.key});

  @override
  State<EdgeNotesApp> createState() => _EdgeNotesAppState();
}

class _EdgeNotesAppState extends State<EdgeNotesApp> {
  final _navKey = GlobalKey<NavigatorState>();
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(_navKey);
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      routeInformationProvider: _appRouter.routeInfoProvider(),
      theme: ThemeData(
        colorScheme: AppTheme.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: AppTheme.dark,
        useMaterial3: true,
      ),
    );
  }
}
