// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// // import '../bloc/employee_bloc.dart';
// import '../../../base/widget_utils.dart';
// import '../../../core/api_service.dart';
// import '../employ/employee_bloc.dart';
// import '../employee_repository.dart';
// import 'employee_detail_screen.dart';
// // import 'employee_detail_page.dart';
//
// class EmployeesPage extends StatelessWidget {
//   const EmployeesPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => EmployeeBloc(EmployeeRepository(api: ApiService()))
//         ..add(LoadEmployees()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: getCustomFont(" Employees ", 22, Colors.black, 2,
//               fontWeight: FontWeight.bold),
//           // const Text("📅 Daily Subscription Schedules"),
//           backgroundColor: Colors.white70,
//           // title: const Text("Employees"),
//           // backgroundColor: Colors.indigo,
//         ),
//         body: BlocBuilder<EmployeeBloc, EmployeeState>(
//           builder: (context, state) {
//             if (state is EmployeeLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is EmployeeError) {
//               return Center(child: Text("Error: ${state.message}"));
//             } else if (state is EmployeeLoaded) {
//               if (state.employees.isEmpty) {
//                 return const Center(child: Text("No employees found"));
//               }
//
//               return ListView.builder(
//                 itemCount: state.employees.length,
//                 padding: const EdgeInsets.all(12),
//                 itemBuilder: (context, index) {
//                   final emp = state.employees[index];
//                   return GestureDetector(
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => EmployeeDetailPage(employee: emp),
//                       ),
//                     ),
//                     child: Card(
//                       elevation: 4,
//                       margin: const EdgeInsets.only(bottom: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 30,
//                               backgroundImage: NetworkImage(emp.image),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(emp.name,
//                                       style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold)),
//                                   const SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       const Icon(Icons.phone,
//                                           size: 16, color: Colors.teal),
//                                       const SizedBox(width: 4),
//                                       Text(emp.phone1),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 2),
//                                   Row(
//                                     children: [
//                                       const Icon(Icons.email,
//                                           size: 16, color: Colors.indigo),
//                                       const SizedBox(width: 4),
//                                       Expanded(
//                                           child: Text(emp.email,
//                                               overflow: TextOverflow.ellipsis)),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/api_service.dart';
// import '../../../theme/app_theme.dart';
import '../employ/employee_bloc.dart';
import '../employee_repository.dart';
import 'employee_detail_screen.dart';

class EmployeesPage extends StatelessWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => EmployeeBloc(EmployeeRepository(api: ApiService()))
        ..add(LoadEmployees()),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          title: Text('Employees', style: theme.textTheme.headlineSmall),
        ),
        body: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.secondary,
                ),
              );
            }
            if (state is EmployeeError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: theme.textTheme.bodyMedium,
                ),
              );
            }
            if (state is EmployeeLoaded && state.employees.isEmpty) {
              return Center(
                child: Text(
                  'No employees found',
                  style: theme.textTheme.bodyMedium,
                ),
              );
            }
            if (state is EmployeeLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.employees.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final emp = state.employees[i];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EmployeeDetailPage(employee: emp),
                      ),
                    ),
                    child: Card(
                      color: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundColor:
                              theme.colorScheme.secondary.withOpacity(0.2),
                              backgroundImage: NetworkImage(emp.image),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    emp.name,
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.phone,
                                          size: 16,
                                          color: theme.colorScheme.secondary),
                                      const SizedBox(width: 6),
                                      Text(emp.phone1,
                                          style: theme.textTheme.bodyMedium),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(Icons.email,
                                          size: 16, color: theme.primaryColor),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          emp.email,
                                          style: theme.textTheme.bodyMedium,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
