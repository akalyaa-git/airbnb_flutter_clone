import 'package:airbnb_flutter_clone/airbnb_clone/features/presentation/screens/home/home_screen.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/presentation/screens/nav_screens/messages_screen.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/presentation/screens/nav_screens/profile_screen.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/presentation/screens/nav_screens/trips_screen.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/presentation/screens/nav_screens/wishlists_screen.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/presentation/widgets/auth_screen.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/presentation/widgets/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String wishlists = '/wishlists';
  static const String trips = '/trips';
  static const String messages = '/messages';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case auth:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case wishlists:
        return MaterialPageRoute(builder: (_) => const WishlistsScreen());
      case trips:
        return MaterialPageRoute(builder: (_) => const TripsScreen());
      case messages:
        return MaterialPageRoute(builder: (_) => const MessagesScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No route defined'))),
        );
    }
  }
}
