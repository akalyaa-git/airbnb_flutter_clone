import 'package:airbnb_flutter_clone/airbnb_clone/notifier/authentication_provider.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/notifier/property_provider.dart';
import 'package:airbnb_flutter_clone/airbnb_clone/presentation/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Airbnb Clone',
        theme: ThemeData(primarySwatch: Colors.red),

        /// Listens to Firebase authentication state changes.
        home: SplashScreen(),
      ),
    );
  }
}

