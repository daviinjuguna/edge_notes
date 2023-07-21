import 'package:auto_route/auto_route.dart';
import 'package:edge_notes/models/notes_model.dart';
import 'package:edge_notes/ui/note_holder_route.dart';
import 'package:edge_notes/ui/notes_details_page.dart';
import 'package:edge_notes/ui/notes_page.dart';
import 'package:edge_notes/ui/splash_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
// extend the generated private router
class AppRouter extends _$AppRouter {
  AppRouter([GlobalKey<NavigatorState>? navKey]) : super(navigatorKey: navKey);

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(
      page: NotesRoute.page,
      children: [
        AutoRoute(page: NotesListRoute.page, path: ''),
        AutoRoute(page: NotesDetailRoute.page, path: ':id'),
        RedirectRoute(path: '*', redirectTo: '')
      ],
    ),
  ];
}
