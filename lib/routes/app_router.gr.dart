// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    NotesDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<NotesDetailRouteArgs>(
          orElse: () => NotesDetailRouteArgs(
                  id: pathParams.getString(
                'id',
                'create',
              )));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NotesDetailPage(
          key: args.key,
          id: args.id,
          notes: args.notes,
        ),
      );
    },
    NotesListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NotesPage(),
      );
    },
    NotesRoute.name: (routeData) {
      final args = routeData.argsAs<NotesRouteArgs>(
          orElse: () => const NotesRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NotesHolderRoute(key: args.key),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
  };
}

/// generated route for
/// [NotesDetailPage]
class NotesDetailRoute extends PageRouteInfo<NotesDetailRouteArgs> {
  NotesDetailRoute({
    Key? key,
    String id = 'create',
    NotesModel? notes,
    List<PageRouteInfo>? children,
  }) : super(
          NotesDetailRoute.name,
          args: NotesDetailRouteArgs(
            key: key,
            id: id,
            notes: notes,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'NotesDetailRoute';

  static const PageInfo<NotesDetailRouteArgs> page =
      PageInfo<NotesDetailRouteArgs>(name);
}

class NotesDetailRouteArgs {
  const NotesDetailRouteArgs({
    this.key,
    this.id = 'create',
    this.notes,
  });

  final Key? key;

  final String id;

  final NotesModel? notes;

  @override
  String toString() {
    return 'NotesDetailRouteArgs{key: $key, id: $id, notes: $notes}';
  }
}

/// generated route for
/// [NotesPage]
class NotesListRoute extends PageRouteInfo<void> {
  const NotesListRoute({List<PageRouteInfo>? children})
      : super(
          NotesListRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotesListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NotesHolderRoute]
class NotesRoute extends PageRouteInfo<NotesRouteArgs> {
  NotesRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          NotesRoute.name,
          args: NotesRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'NotesRoute';

  static const PageInfo<NotesRouteArgs> page = PageInfo<NotesRouteArgs>(name);
}

class NotesRouteArgs {
  const NotesRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'NotesRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
