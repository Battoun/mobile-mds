// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$dashboardRoute];

RouteBase get $dashboardRoute => GoRouteData.$route(
  path: '/',
  hasOverriddenOnExit: false,
  factory: $DashboardRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'sensor/:id',
      hasOverriddenOnExit: false,
      factory: $SensorDetailRoute._fromState,
    ),
  ],
);

mixin $DashboardRoute on GoRouteData {
  static DashboardRoute _fromState(GoRouterState state) =>
      const DashboardRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SensorDetailRoute on GoRouteData {
  static SensorDetailRoute _fromState(GoRouterState state) =>
      SensorDetailRoute(state.pathParameters['id']!);

  SensorDetailRoute get _self => this as SensorDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/sensor/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
