import 'package:edge_notes/bloc/theme/theme_cubit.dart';
import 'package:edge_notes/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late final ThemeCubit _themeCubit;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(_navKey);
    _themeCubit = getIt();
  }

  @override
  void dispose() {
    _appRouter.dispose();
    _themeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (create) => _themeCubit),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            routeInformationProvider: _appRouter.routeInfoProvider(),
            themeMode: context.watch<ThemeCubit>().themeMode,
            theme: ThemeData(
              colorScheme: AppTheme.light,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: AppTheme.dark,
              useMaterial3: true,
            ),
          );
        },
      ),
    );
  }
}
