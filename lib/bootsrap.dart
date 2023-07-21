import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:edge_notes/di/injection.dart';
import 'package:flutter/material.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    log('onClose(${bloc.runtimeType})');
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    log('onCreate(${bloc.runtimeType})');
    super.onCreate(bloc);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await configureInjection(environment: Env.dev);
      runApp(await builder());
    },
    (error, stackTrace) =>
        log(error.toString(), stackTrace: stackTrace, error: error),
  );
}
