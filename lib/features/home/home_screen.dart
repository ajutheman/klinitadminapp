// // // import 'package:flutter/material.dart';
// // //
// // // import '../../base/color_data.dart';
// // // import '../../base/resizer/fetch_pixels.dart';
// // // import '../../base/widget_utils.dart';
// // // import '../orders/screens/orders_screen.dart';
// // //
// // // // import '../../orders/screens/orders_page.dart';
// // //
// // // class HomeScreen extends StatefulWidget {
// // //   const HomeScreen({Key? key}) : super(key: key);
// // //
// // //   @override
// // //   State<HomeScreen> createState() => _HomeScreenState();
// // // }
// // //
// // // class _HomeScreenState extends State<HomeScreen> {
// // //   int _currentIndex = 0;
// // //   final List<Widget> _tabs = [
// // //     const OrdersPage(),
// // //     const Center(child: Text('Employees Page')),
// // //     const Center(child: Text('Profile Page')),
// // //   ];
// // //   int position = 0;
// // //   List<Widget> tabList = [
// // //     const OrdersPage(),
// // //     const Center(child: Text('Employees Page')),
// // //     const Center(child: Text('Profile Page')),
// // //   ];
// // //
// // //   List<String> itemList = [
// // //     "user.svg",
// // //     "documnet.svg",
// // //     "review.svg",
// // //   ];
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: _tabs[_currentIndex],
// // //       bottomNavigationBar: bottomNavigationBar(),
// // //     );
// // //   }
// // //
// // //   Container bottomNavigationBar() {
// // //     return Container(
// // //       padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
// // //       height: FetchPixels.getPixelHeight(100),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         boxShadow: const [
// // //           BoxShadow(
// // //               color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
// // //         ],
// // //       ),
// // //       child: Row(
// // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //         children: List<Widget>.generate(itemList.length, (index) {
// // //           return GestureDetector(
// // //             onTap: () {
// // //               setState(() {
// // //                 position = index;
// // //               });
// // //             },
// // //             child: Container(
// // //               decoration: BoxDecoration(
// // //                   color: position == index ? greenColor : Colors.transparent,
// // //                   shape: BoxShape.circle),
// // //               child: Padding(
// // //                 padding: EdgeInsets.all(FetchPixels.getPixelHeight(13)),
// // //                 child: getSvgImage(itemList[index],
// // //                     width: FetchPixels.getPixelHeight(24),
// // //                     height: FetchPixels.getPixelHeight(24),
// // //                     color: position == index ? Colors.white : null),
// // //               ),
// // //             ),
// // //           );
// // //         }),
// // //       ), // child: BottomNavigationBar(
// // //     );
// // //   }
// // // }
// //
// import 'package:flutter/material.dart';
//
// import '../../base/color_data.dart';
// import '../../base/resizer/fetch_pixels.dart';
// import '../../base/widget_utils.dart';
// import '../orders/screens/ProfilePage.dart';
// import '../orders/screens/SubscriptionSchedulesPage.dart';
// import '../orders/screens/employee_screen.dart';
// import '../orders/screens/orders_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
// // Unread counter that the NotificationsPage will update.
//   final ValueNotifier<int> _unreadCount = ValueNotifier<int>(0);
//
//   final List<Widget> _tabs = [
//     const OrdersPage(),
//     SubscriptionSchedulesPage(), // New tab for subscription schedules
//     // const Center(child: Text('Employees Page')),
//     NotificationsPage(unreadCount: _unreadCount), // NEW
//     const EmployeesPage(),
//
//     // const Center(child: Text('Profile Page')),
//     const ProfilePage(),
//   ];
//
//   final List<String> _icons = [
//     "documnet.svg",
//     // "notification_unselected.svg",
//
//     "review.svg",
//     "notification_unselected.svg", // Notifications
//     // "documnet.svg",
//     "user.svg",
//     "user.svg",
//     // "review.svg",
//   ];
//   @override
//   void dispose() {
//     _unreadCount.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _tabs[_currentIndex],
//       bottomNavigationBar: buildBottomNavigationBar(),
//     );
//   }
//
//   Widget buildBottomNavigationBar() {
//     return Container(
//       height: FetchPixels.getPixelHeight(100),
//       padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: const [
//           BoxShadow(
//               color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: List.generate(_icons.length, (index) {
//           final isSelected = _currentIndex == index;
//
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: isSelected ? greenColor : Colors.transparent,
//                 shape: BoxShape.circle,
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(FetchPixels.getPixelHeight(13)),
//                 child: getSvgImage(
//                   _icons[index],
//                   width: FetchPixels.getPixelHeight(24),
//                   height: FetchPixels.getPixelHeight(24),
//                   color: isSelected ? Colors.white : null,
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// //
// // import '../../base/resizer/fetch_pixels.dart';
// // import '../../base/app_theme.dart';
// // import '../orders/screens/ProfilePage.dart';
// // import '../orders/screens/SubscriptionSchedulesPage.dart';
// // import '../orders/screens/employee_screen.dart';
// // import '../orders/screens/orders_screen.dart';
// //
// // class HomeScreen extends StatefulWidget {
// //   /// Called to flip between light & dark mode
// //   // final VoidCallback onToggleTheme;
// //
// //   const HomeScreen({
// //     Key? key,
// //      // required this.onToggleTheme,
// //   }) : super(key: key);
// //
// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //   int _currentIndex = 0;
// //
// //   late final List<Widget> _tabs;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     // Pass the same toggle callback into ProfilePage
// //     _tabs = [
// //       const OrdersPage(),
// //       const SubscriptionSchedulesPage(),
// //       const EmployeesPage(),
// //       // ProfilePage(onToggleTheme: widget.onToggleTheme),
// //       ProfilePage(),
// //     ];
// //   }
// //
// //   final List<String> _icons = [
// //     "document.svg",
// //     "review.svg",
// //     "user.svg",
// //     "settings.svg",  // e.g. profile icon
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // no AppBar here: each tab handles its own
// //       body: _tabs[_currentIndex],
// //       bottomNavigationBar: _buildBottomNav(context),
// //     );
// //   }
// //
// //   Widget _buildBottomNav(BuildContext context) {
// //     return Container(
// //       height: FetchPixels.getPixelHeight(90),
// //       padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
// //       decoration: BoxDecoration(
// //         color: AppTheme.white,
// //         boxShadow: const [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 8,
// //             offset: Offset(0, -2),
// //           )
// //         ],
// //       ),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: List.generate(_icons.length, (i) {
// //           final selected = i == _currentIndex;
// //           return GestureDetector(
// //             onTap: () => setState(() => _currentIndex = i),
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 color: selected ? AppTheme.aquaBlue : Colors.transparent,
// //                 shape: BoxShape.circle,
// //               ),
// //               padding: EdgeInsets.all(FetchPixels.getPixelHeight(12)),
// //               child: SvgPicture.asset(
// //                 'assets/icons/${_icons[i]}',
// //                 width: FetchPixels.getPixelHeight(24),
// //                 height: FetchPixels.getPixelHeight(24),
// //                 color: selected ? AppTheme.white : AppTheme.softTeal,
// //               ),
// //             ),
// //           );
// //         }),
// //       ),
// //     );
// //   }
// // }


import 'package:flutter/material.dart';

import '../../base/color_data.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';

// Existing tabs
import '../orders/screens/orders_screen.dart';
import '../orders/screens/SubscriptionSchedulesPage.dart';
import '../orders/screens/employee_screen.dart';
import '../orders/screens/ProfilePage.dart';

// New tab
import '../notifications/notifications_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Unread counter that the NotificationsPage will update.
  final ValueNotifier<int> _unreadCount = ValueNotifier<int>(0);

  late final List<Widget> _tabs;

  final List<String> _icons = [
    "documnet.svg",              // Orders
    "notification_unselected.svg", // Notifications
    "review.svg",                // Subscription schedules (keep your asset as-is)
    "user.svg",                  // Employees
    "user.svg",                  // Profile
  ];

  @override
  void initState() {
    super.initState();
    _tabs = [
      const OrdersPage(),
      NotificationsPage(unreadCount: _unreadCount), // NEW
      SubscriptionSchedulesPage(),
      const EmployeesPage(),
      const ProfilePage(),
    ];
  }

  @override
  void dispose() {
    _unreadCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return Container(
      height: FetchPixels.getPixelHeight(100),
      padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_icons.length, (index) {
          final isSelected = _currentIndex == index;

          // Only show badge on Notifications tab (index 1)
          final showBadge = index == 1;

          Widget icon = Container(
            decoration: BoxDecoration(
              color: isSelected ? greenColor : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(FetchPixels.getPixelHeight(13)),
              child: getSvgImage(
                _icons[index],
                width: FetchPixels.getPixelHeight(24),
                height: FetchPixels.getPixelHeight(24),
                color: isSelected ? Colors.white : null,
              ),
            ),
          );

          if (showBadge) {
            icon = ValueListenableBuilder<int>(
              valueListenable: _unreadCount,
              builder: (_, count, child) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    child!,
                    if (count > 0)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                          child: Text(
                            count > 99 ? "99+" : "$count",
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                  ],
                );
              },
              child: icon,
            );
          }

          return GestureDetector(
            onTap: () => setState(() => _currentIndex = index),
            child: icon,
          );
        }),
      ),
    );
  }
}
