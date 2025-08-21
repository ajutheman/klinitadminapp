// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // import 'base/resizer/fetch_pixels.dart';
// // import 'features/auth/screen/login_screen.dart';
// // import 'features/home/home_screen.dart';
// // import 'firebase_options.dart';
// //
// // // import 'features/auth/screens/login_screen.dart';
// // // import 'features/home/screens/home_screen.dart';
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   final prefs = await SharedPreferences.getInstance();
// //   final token = prefs.getString('admin_token');
// //   // runApp(MyApp(isLoggedIn: token != null));
// //   final hasToken = prefs.containsKey('admin_token');
// //   // await Firebase.initializeApp();
// //   await Firebase.initializeApp(
// //     options: DefaultFirebaseOptions.currentPlatform,
// //   );
// //   runApp(MyApp(initialRoute: hasToken ? '/home' : '/login'));
// // }
// //
// // class MyApp extends StatelessWidget {
// //   // final bool isLoggedIn;
// //   // const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);
// //   final String initialRoute;
// //
// //   const MyApp({super.key, required this.initialRoute});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     FetchPixels.init(context);
// //     return MaterialApp(
// //       // title: 'Admin App',
// //       // debugShowCheckedModeBanner: false,
// //       // home: isLoggedIn ? const HomeScreen() : LoginScreen(),
// //       initialRoute: initialRoute,
// //       routes: {
// //         '/login': (context) => const LoginScreen(),
// //         '/home': (context) => const HomeScreen(),
// //       },
// //     );
// //   }
// // }
// //
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'base/app_theme.dart';
// // import 'theme/app_theme.dart';
// import 'base/resizer/fetch_pixels.dart';
// import 'features/auth/screen/login_screen.dart';
// import 'features/home/home_screen.dart';
// import 'firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// // Initialize Flutter Local Notifications plugin
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// /// Handle background messages
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   _showNotification(message);
// }
//
// /// Display local notification
// void _showNotification(RemoteMessage message) {
//   final notification = message.notification;
//   final android = notification?.android;
//
//   if (notification != null && android != null) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'default_channel',
//           'Default Notifications',
//           channelDescription: 'This channel is used for default notifications.',
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//       ),
//     );
//   }
// }
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   final hasToken = prefs.containsKey('admin_token');
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//   runApp(MyApp(initialRoute: hasToken ? '/home' : '/login'));
// }
//
// class MyApp extends StatefulWidget {
//   final String initialRoute;
//   const MyApp({Key? key, required this.initialRoute}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   ThemeMode _themeMode = ThemeMode.system;
//
//   void _toggleTheme(bool isDark) {
//     setState(() => _themeMode = isDark ? ThemeMode.dark : ThemeMode.light);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     FetchPixels.init(context);
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: widget.initialRoute,
//       theme: AppTheme.lightTheme,
//       darkTheme: AppTheme.darkTheme,
//       themeMode: _themeMode,
//       routes: {
//         // '/login': (ctx) => LoginScreen(onToggleTheme: _toggleTheme),
//         // '/home':  (ctx) => HomeScreen(onToggleTheme: _toggleTheme),
//         '/login': (context) => const LoginScreen(),
//         '/home': (context) => const HomeScreen(),
//       },
//     );
//   }
// }
// //
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:firebase_core/firebase_core.dart';
// //
// // import 'base/app_theme.dart';
// // import 'firebase_options.dart';
// // import 'features/auth/screen/login_screen.dart';
// // import 'features/home/home_screen.dart';
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// //
// //   final prefs = await SharedPreferences.getInstance();
// //   final hasToken = prefs.containsKey('admin_token');
// //
// //   runApp(MyApp(initialRoute: hasToken ? '/home' : '/login'));
// // }
// //
// // class MyApp extends StatefulWidget {
// //   final String initialRoute;
// //   const MyApp({super.key, required this.initialRoute});
// //
// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }
// //
// // class _MyAppState extends State<MyApp> {
// //   ThemeMode _mode = ThemeMode.system;
// //
// //   void _toggleTheme() {
// //     setState(() {
// //       _mode = _mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Admin App',
// //       theme: AppTheme.lightTheme,
// //       darkTheme: AppTheme.darkTheme,
// //       themeMode: _mode,
// //
// //       initialRoute: widget.initialRoute,
// //       routes: {
// //         // '/login': (_) => const LoginScreen(),
// //         // '/home': (_) => HomeScreen(onToggleTheme: _toggleTheme),
// //         '/login': (context) => const LoginScreen(),
// //         '/home': (context) => const HomeScreen(),
// //         // '/home': (_) => HomeScreen(onToggleTheme: _toggleTheme),
// //
// //       },
// //     );
// //   }
// // }

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/app_theme.dart';
import 'base/resizer/fetch_pixels.dart';
import 'features/auth/screen/login_screen.dart';
import 'features/home/home_screen.dart';
import 'firebase_options.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_new_badger/flutter_new_badger.dart';
// Initialize Flutter Local Notifications plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// Handle background messages
@pragma('vm:entry-point') // <-- ADD THIS
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  _showNotification(message);
}

/// Display local notification

void _showNotification(RemoteMessage message) async {
  final notification = message.notification;
  final android = notification?.android;

  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'default_channel',
          'Default Notifications',
          importance: Importance.max,
          priority: Priority.high,
          channelShowBadge: true,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  await _incrementBadgeCount(); // ✅ Your own function
}
Future<void> _incrementBadgeCount() async {
  await FlutterNewBadger.incrementBadgeCount();
}
Future<void> _resetBadgeCount() async {
  await FlutterNewBadger.removeBadge();
}

// /// Increment badge count
// void _incrementBadgeCount() async {
//   final prefs = await SharedPreferences.getInstance();
//   int count = prefs.getInt('badge_count') ?? 0;
//   count++;
//   prefs.setInt('badge_count', count);
//
//   if (await FlutterAppBadger.isAppBadgeSupported()) {
//     FlutterAppBadger.updateBadgeCount(count);
//   }
// }
//
// /// Reset badge count
// void _resetBadgeCount() async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setInt('badge_count', 0);
//
//   if (await FlutterAppBadger.isAppBadgeSupported()) {
//     FlutterAppBadger.removeBadge();
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Request notification permissions (Android 13+ and iOS)
  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,

  );

  // Get FCM token (for testing or server registration)
  final token = await messaging.getToken();
  print("FCM Token: $token");

  // Initialize local notifications
  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const initSettings = InitializationSettings(android: androidSettings);
  await flutterLocalNotificationsPlugin.initialize(initSettings);

  final prefs = await SharedPreferences.getInstance();
  final hasToken = prefs.containsKey('admin_token');

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
  void initState() {
    super.initState();
    _resetBadgeCount(); // Reset badge on app open
    // Foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    // Notification tap handler
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _resetBadgeCount(); // Reset badge on notification tap
      final screen = message.data['screen'];
      if (screen == 'home') {
        Navigator.pushNamed(context, '/home');
      } else if (screen == 'login') {
        Navigator.pushNamed(context, '/login');
      }
    });
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
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
