// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'base/resizer/fetch_pixels.dart';
// import 'features/auth/screen/login_screen.dart';
// import 'features/home/home_screen.dart';
// import 'firebase_options.dart';
//
// // import 'features/auth/screens/login_screen.dart';
// // import 'features/home/screens/home_screen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('admin_token');
//   // runApp(MyApp(isLoggedIn: token != null));
//   final hasToken = prefs.containsKey('admin_token');
//   // await Firebase.initializeApp();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp(initialRoute: hasToken ? '/home' : '/login'));
// }
//
// class MyApp extends StatelessWidget {
//   // final bool isLoggedIn;
//   // const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);
//   final String initialRoute;
//
//   const MyApp({super.key, required this.initialRoute});
//
//   @override
//   Widget build(BuildContext context) {
//     FetchPixels.init(context);
//     return MaterialApp(
//       // title: 'Admin App',
//       // debugShowCheckedModeBanner: false,
//       // home: isLoggedIn ? const HomeScreen() : LoginScreen(),
//       initialRoute: initialRoute,
//       routes: {
//         '/login': (context) => const LoginScreen(),
//         '/home': (context) => const HomeScreen(),
//       },
//     );
//   }
// }
//
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/app_theme.dart';
// import 'theme/app_theme.dart';
import 'base/resizer/fetch_pixels.dart';
import 'features/auth/screen/login_screen.dart';
import 'features/home/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final hasToken = prefs.containsKey('admin_token');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp(initialRoute: hasToken ? '/home' : '/login'));
}

class MyApp extends StatefulWidget {
  final String initialRoute;
  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(bool isDark) {
    setState(() => _themeMode = isDark ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: widget.initialRoute,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      routes: {
        // '/login': (ctx) => LoginScreen(onToggleTheme: _toggleTheme),
        // '/home':  (ctx) => HomeScreen(onToggleTheme: _toggleTheme),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// import 'base/app_theme.dart';
// import 'firebase_options.dart';
// import 'features/auth/screen/login_screen.dart';
// import 'features/home/home_screen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//   final prefs = await SharedPreferences.getInstance();
//   final hasToken = prefs.containsKey('admin_token');
//
//   runApp(MyApp(initialRoute: hasToken ? '/home' : '/login'));
// }
//
// class MyApp extends StatefulWidget {
//   final String initialRoute;
//   const MyApp({super.key, required this.initialRoute});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   ThemeMode _mode = ThemeMode.system;
//
//   void _toggleTheme() {
//     setState(() {
//       _mode = _mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Admin App',
//       theme: AppTheme.lightTheme,
//       darkTheme: AppTheme.darkTheme,
//       themeMode: _mode,
//
//       initialRoute: widget.initialRoute,
//       routes: {
//         // '/login': (_) => const LoginScreen(),
//         // '/home': (_) => HomeScreen(onToggleTheme: _toggleTheme),
//         '/login': (context) => const LoginScreen(),
//         '/home': (context) => const HomeScreen(),
//         // '/home': (_) => HomeScreen(onToggleTheme: _toggleTheme),
//
//       },
//     );
//   }
// }
