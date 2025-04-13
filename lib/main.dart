import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/resizer/fetch_pixels.dart';
import 'features/auth/screen/login_screen.dart';
import 'features/home/home_screen.dart';
import 'firebase_options.dart';

// import 'features/auth/screens/login_screen.dart';
// import 'features/home/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('admin_token');
  // runApp(MyApp(isLoggedIn: token != null));
  final hasToken = prefs.containsKey('admin_token');
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(initialRoute: hasToken ? '/home' : '/login'));
}

class MyApp extends StatelessWidget {
  // final bool isLoggedIn;
  // const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    FetchPixels.init(context);
    return MaterialApp(
      // title: 'Admin App',
      // debugShowCheckedModeBanner: false,
      // home: isLoggedIn ? const HomeScreen() : LoginScreen(),
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
