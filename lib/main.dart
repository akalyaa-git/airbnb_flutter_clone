import 'package:airbnb_flutter_clone/airbnb_clone/core/app_routes.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/core/app_theme.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/notifier/authentication_provider.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/notifier/property_provider.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/features/notifier/wishlist_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // To get these values,
    // 1. Go to firebase console and go to the particular project
    // 2. Left side panel -> Settings -> General -> Scroll down, select the web app
    // 3. Select the Config, there you can find these props
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "",
        authDomain: "",
        projectId: "",
        storageBucket: "",
        messagingSenderId: "",
        appId: "",
        measurementId: "",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => PropertyProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
