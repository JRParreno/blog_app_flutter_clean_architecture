/// Represents the app routes and their paths.
enum AppRoutes {
  login(
    name: 'login',
    path: '/login',
  ),
  signup(
    name: 'signup',
    path: '/signup',
  ),
  blog(
    name: 'blog',
    path: '/blog',
  ),
  blogAdd(
    name: 'addNewBlog',
    path: 'addNewBlog',
  ),
  blogDetail(
    name: 'blogDetail',
    path: 'blogDetail',
  ),
  foodPanda(
    name: 'foodPanda',
    path: '/food-panda',
  );

  const AppRoutes({
    required this.name,
    required this.path,
  });

  /// Represents the route name
  ///
  /// Example: `AppRoutes.splash.name`
  /// Returns: 'splash'
  final String name;

  /// Represents the route path
  ///
  /// Example: `AppRoutes.splash.path`
  /// Returns: '/splash'
  final String path;

  @override
  String toString() => name;
}
