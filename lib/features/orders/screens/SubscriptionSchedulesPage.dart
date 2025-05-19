// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
//
// import '../../../base/widget_utils.dart';
// import '../../../core/api_service.dart';
// import '../employ/employee_bloc.dart';
// import '../employee_repository.dart';
// import '../models/employee_model.dart';
// import '../subscription_schedule_bloc/subscription_schedule_bloc.dart';
// import '../subscription_schedule_repository.dart';
//
// class SubscriptionSchedulesPage extends StatefulWidget {
//   const SubscriptionSchedulesPage({super.key});
//
//   @override
//   State<SubscriptionSchedulesPage> createState() =>
//       _SubscriptionSchedulesPageState();
// }
//
// class _SubscriptionSchedulesPageState extends State<SubscriptionSchedulesPage>
//     with SingleTickerProviderStateMixin {
//   late final SubscriptionScheduleBloc _bloc;
//   final _repository = SubscriptionScheduleRepository(api: ApiService());
//   late DateTime selectedDate;
//   late AnimationController _animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedDate = DateTime.now();
//     _bloc = SubscriptionScheduleBloc(_repository);
//     _fetchForDate(selectedDate);
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//   }
//
//   void _fetchForDate(DateTime date) {
//     final formatted = DateFormat('yyyy-MM-dd').format(date);
//     _bloc.add(FetchSubscriptionSchedules(formatted));
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now().subtract(const Duration(days: 30)),
//       lastDate: DateTime.now().add(const Duration(days: 30)),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() => selectedDate = picked);
//       _fetchForDate(picked);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<SubscriptionScheduleBloc>.value(value: _bloc),
//         BlocProvider<EmployeeBloc>(
//           create: (_) => EmployeeBloc(EmployeeRepository(api: ApiService()))
//             ..add(LoadEmployees()),
//         ),
//       ],
//       child: Scaffold(
//         appBar: AppBar(
//           title: getCustomFont(" Subscription Schedules", 22, Colors.black, 2,
//               fontWeight: FontWeight.bold),
//           // const Text("📅 Daily Subscription Schedules"),
//           backgroundColor: Colors.white70,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.calendar_month),
//               onPressed: () => _selectDate(context),
//             ),
//           ],
//         ),
//         body: RefreshIndicator(
//           onRefresh: () async => _fetchForDate(selectedDate),
//           child:
//               BlocBuilder<SubscriptionScheduleBloc, SubscriptionScheduleState>(
//             builder: (context, state) {
//               if (state is SubscriptionScheduleLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is SubscriptionScheduleError) {
//                 return Center(child: Text("Error: ${state.message}"));
//               } else if (state is SubscriptionScheduleLoaded) {
//                 if (state.schedules.isEmpty) {
//                   return const Center(child: Text("No schedules found."));
//                 }
//
//                 return BlocSelector<EmployeeBloc, EmployeeState,
//                     List<Employee>>(
//                   selector: (state) =>
//                       state is EmployeeLoaded ? state.employees : [],
//                   builder: (context, employees) {
//                     return ListView.builder(
//                       itemCount: state.schedules.length,
//                       itemBuilder: (context, index) {
//                         final schedule = state.schedules[index];
//                         final animation = Tween<Offset>(
//                           begin: const Offset(1, 0),
//                           end: Offset.zero,
//                         ).animate(CurvedAnimation(
//                           parent: _animationController,
//                           curve: Curves.easeOut,
//                         ));
//                         _animationController.forward();
//
//                         return SlideTransition(
//                           position: animation,
//                           child: Card(
//                             margin: const EdgeInsets.all(12),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             color: Colors.purple.shade50,
//                             elevation: 6,
//                             child: Padding(
//                               padding: const EdgeInsets.all(16),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       const Icon(Icons.assignment_turned_in,
//                                           color: Colors.deepPurple),
//                                       const SizedBox(width: 6),
//                                       Text("Order #${schedule.order.id}",
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 16)),
//                                       const Spacer(),
//                                       Chip(
//                                         label: Text(
//                                             schedule.dayOfWeek.toUpperCase()),
//                                         backgroundColor:
//                                             Colors.deepPurple.shade100,
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                       "🕒 Time: ${DateFormat('hh:mm a').format(DateTime.parse(schedule.date))}"),
//                                   Text("📅 Date: ${schedule.date}"),
//                                   Text("🧾 Status: ${schedule.dayOfWeek}"),
//                                   const Divider(),
//                                   Text(
//                                       "👤 Customer: ${schedule.customer.name}"),
//                                   Text("📞 Phone: ${schedule.customer.phone}"),
//                                   Text(
//                                       "🏠 Address: ${schedule.customer.address}"),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                       "📦 Category: ${schedule.category.name}"),
//                                   Text(
//                                       "📝 Description: ${schedule.category.description}"),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                       "💰 Total: AED ${schedule.order.total.toStringAsFixed(2)}"),
//                                   Text(
//                                       "👥 Required Employees: ${schedule.order.employeeCount}"),
//                                   Text(
//                                       "📋 Schedule ID: ${schedule.scheduleId}"),
//                                   const Divider(),
//                                   const Text("👷 Assigned Employees:",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold)),
//                                   Wrap(
//                                     spacing: 6,
//                                     runSpacing: 4,
//                                     children:
//                                         schedule.assignedEmployees.map((e) {
//                                       return Chip(
//                                         backgroundColor: Colors.green.shade100,
//                                         avatar:
//                                             const Icon(Icons.person, size: 18),
//                                         label: Text('${e.name} (${e.status})'),
//                                         deleteIcon: const Icon(Icons.cancel),
//                                         onDeleted: () {
//                                           _bloc.add(RemoveScheduleEmployee(
//                                             assignmentId: e.id,
//                                             date: schedule.date,
//                                           ));
//                                         },
//                                       );
//                                     }).toList(),
//                                   ),
//                                   const SizedBox(height: 12),
//                                   AnimatedSwitcher(
//                                     duration: const Duration(milliseconds: 400),
//                                     child: ElevatedButton.icon(
//                                       key: ValueKey(schedule.scheduleId),
//                                       icon: const Icon(Icons.person_add_alt_1),
//                                       label: const Text("Assign Employee"),
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.indigo,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                         ),
//                                       ),
//                                       onPressed: () async {
//                                         if (employees.isEmpty) {
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(
//                                             const SnackBar(
//                                                 content: Text(
//                                                     "No employees available.")),
//                                           );
//                                           return;
//                                         }
//                                         final selected =
//                                             await showDialog<Employee?>(
//                                           context: context,
//                                           builder: (_) => _EmployeeDialog(
//                                               employees: employees),
//                                         );
//                                         if (selected != null) {
//                                           final alreadyAssigned = schedule
//                                               .assignedEmployees
//                                               .any((e) =>
//                                                   e.name == selected.name);
//                                           if (alreadyAssigned) {
//                                             ScaffoldMessenger.of(context)
//                                                 .showSnackBar(
//                                               const SnackBar(
//                                                   content: Text(
//                                                       "Employee already assigned.")),
//                                             );
//                                             return;
//                                           }
//                                           final dayOfWeek = DateFormat('EEEE')
//                                               .format(
//                                                   DateTime.parse(schedule.date))
//                                               .toLowerCase();
//                                           _bloc.add(AssignScheduleEmployee(
//                                             scheduleId: schedule.scheduleId,
//                                             employeeId: selected.id,
//                                             workDate: schedule.date,
//                                             dayOfWeek: dayOfWeek,
//                                           ));
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 );
//               }
//               return const SizedBox();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _EmployeeDialog extends StatelessWidget {
//   final List<Employee> employees;
//   const _EmployeeDialog({required this.employees});
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text("👷 Select Employee"),
//       content: SizedBox(
//         height: 300,
//         width: double.maxFinite,
//         child: ListView.builder(
//           itemCount: employees.length,
//           itemBuilder: (_, index) {
//             final emp = employees[index];
//             return ListTile(
//               leading: CircleAvatar(backgroundImage: NetworkImage(emp.image)),
//               title: Text(emp.name),
//               subtitle: Text(emp.email),
//               onTap: () => Navigator.pop(context, emp),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../base/app_theme.dart';
import '../../../core/api_service.dart';
import '../../../base/widget_utils.dart';
// import '../../theme/app_theme.dart';
import '../employ/employee_bloc.dart';
import '../employee_repository.dart';
import '../models/employee_model.dart';
import '../subscription_schedule_bloc/subscription_schedule_bloc.dart';
import '../subscription_schedule_repository.dart';

class SubscriptionSchedulesPage extends StatefulWidget {
  const SubscriptionSchedulesPage({super.key});

  @override
  State<SubscriptionSchedulesPage> createState() =>
      _SubscriptionSchedulesPageState();
}

class _SubscriptionSchedulesPageState extends State<SubscriptionSchedulesPage>
    with SingleTickerProviderStateMixin {
  late final SubscriptionScheduleBloc _bloc;
  late final EmployeeBloc _employeeBloc;
  final _repository = SubscriptionScheduleRepository(api: ApiService());
  late DateTime selectedDate;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _bloc = SubscriptionScheduleBloc(_repository);
    _fetchForDate(selectedDate);
    _employeeBloc = EmployeeBloc(EmployeeRepository(api: ApiService()))
      ..add(LoadEmployees());

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  void _fetchForDate(DateTime date) {
    final formatted = DateFormat('yyyy-MM-dd').format(date);
    _bloc.add(FetchSubscriptionSchedules(formatted));
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: AppTheme.darkTheme.colorScheme,
          dialogBackgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
        ),
        child: child!,
      ),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
      _fetchForDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _bloc),
        BlocProvider(
          create: (_) =>
          EmployeeBloc(EmployeeRepository(api: ApiService()))..add(LoadEmployees()),
        ),
      ],
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          title: Text(
            "Schedules • ${DateFormat.yMMMEd().format(selectedDate)}",
            style: theme.textTheme.headlineSmall,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.calendar_month, color: theme.colorScheme.onPrimary),
              onPressed: () => _selectDate(context),
            )
          ],
        ),
        body: RefreshIndicator(
          backgroundColor: theme.primaryColor,
          color: theme.colorScheme.onPrimary,
          onRefresh: () async => _fetchForDate(selectedDate),
          child: BlocBuilder<SubscriptionScheduleBloc, SubscriptionScheduleState>(
            builder: (context, state) {
              if (state is SubscriptionScheduleLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is SubscriptionScheduleError) {
                return Center(
                  child: Text("Error: ${state.message}", style: theme.textTheme.bodyMedium),
                );
              }
              if (state is SubscriptionScheduleLoaded && state.schedules.isEmpty) {
                return Center(
                  child: Text("No schedules found.", style: theme.textTheme.bodyMedium),
                );
              }
              return BlocSelector<EmployeeBloc, EmployeeState, List<Employee>>(
                selector: (empState) =>
                empState is EmployeeLoaded ? empState.employees : [],
                builder: (context, employees) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    itemCount: (state as SubscriptionScheduleLoaded).schedules.length,
                    itemBuilder: (context, i) {
                      final schedule = state.schedules[i];
                      final slideAnim = Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
                      );
                      _animationController.forward();

                      return SlideTransition(
                        position: slideAnim,
                        child: Card(
                          color: theme.cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 6,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // header row
                                Row(
                                  children: [
                                    Icon(Icons.assignment_turned_in,
                                        color: theme.colorScheme.secondary),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Order #${schedule.order.id}",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    const Spacer(),
                                    Chip(
                                      label: Text(
                                        schedule.dayOfWeek.toUpperCase(),
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          color: theme.colorScheme.onPrimary,
                                          fontSize: 12,
                                        ),
                                      ),
                                      backgroundColor:
                                      theme.colorScheme.primary.withOpacity(0.8),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                // date & time
                                _infoLine(
                                  theme,
                                  icon: Icons.schedule,
                                  label:
                                  "Time: ${DateFormat('hh:mm a').format(DateTime.parse(schedule.date))}",
                                ),
                                _infoLine(theme, icon: Icons.date_range, label: "Date: ${schedule.date}"),
                                const Divider(),

                                // customer
                                _sectionLabel(theme, "Customer"),
                                _infoLine(theme,
                                    icon: Icons.person, label: schedule.customer.name),
                                _infoLine(theme,
                                    icon: Icons.phone, label: schedule.customer.phone),
                                _infoLine(theme,
                                    icon: Icons.home, label: schedule.customer.address),
                                const Divider(),

                                // category
                                _sectionLabel(theme, "Category"),
                                _infoLine(theme,
                                    icon: Icons.category,
                                    label: schedule.category.name),
                                _infoLine(theme,
                                    icon: Icons.notes,
                                    label: schedule.category.description),
                                const Divider(),

                                // order info
                                _sectionLabel(theme, "Order"),
                                _infoLine(theme,
                                    icon: Icons.attach_money,
                                    label:
                                    "Total: AED ${schedule.order.total.toStringAsFixed(2)}"),
                                _infoLine(theme,
                                    icon: Icons.group,
                                    label:
                                    "Req’d Emps: ${schedule.order.employeeCount}"),
                                _infoLine(theme,
                                    icon: Icons.confirmation_num,
                                    label: "Sched ID: ${schedule.scheduleId}"),
                                const Divider(),

                                // assigned employees
                                Text("Assigned Employees", style: theme.textTheme.titleMedium),
                                const SizedBox(height: 6),
                                Wrap(
                                  spacing: 6,
                                  runSpacing: 4,
                                  children: schedule.assignedEmployees.map((e) {
                                    return Chip(
                                      backgroundColor:
                                      theme.colorScheme.secondary.withOpacity(0.2),
                                      avatar: Icon(Icons.person, color: theme.colorScheme.secondary),
                                      label: Text(
                                        '${e.name} (${e.status})',
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      deleteIcon: Icon(Icons.cancel, size: 18, color: theme.colorScheme.error),
                                      onDeleted: () {
                                        _bloc.add(RemoveScheduleEmployee(
                                          assignmentId: e.id,
                                          date: schedule.date,
                                        ));
                                      },
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 12),

                                // assign button
                                Center(
                                  child: ElevatedButton.icon(
                                    icon: Icon(Icons.person_add_alt_1,
                                        color: theme.colorScheme.onPrimary),
                                    label: Text("Assign Employee",
                                        style: theme.textTheme.labelLarge
                                            ?.copyWith(color: theme.colorScheme.onPrimary)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.colorScheme.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12)),
                                      minimumSize: const Size.fromHeight(44),
                                    ),
                                    onPressed: () async {
                                      if (employees.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text("No employees available.",
                                                  style: theme.textTheme.bodyMedium)),
                                        );
                                        return;
                                      }
                                      final selected = await showDialog<Employee?>(
                                        context: context,
                                        builder: (_) => _EmployeeDialog(employees: employees),
                                      );
                                      if (selected != null) {
                                        final already = schedule.assignedEmployees
                                            .any((e) => e.id == selected.id);
                                        if (already) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text("Already assigned.",
                                                    style: theme.textTheme.bodyMedium)),
                                          );
                                        } else {
                                          final dow = DateFormat('EEEE')
                                              .format(DateTime.parse(schedule.date))
                                              .toLowerCase();
                                          _bloc.add(AssignScheduleEmployee(
                                            scheduleId: schedule.scheduleId,
                                            employeeId: selected.id,
                                            workDate: schedule.date,
                                            dayOfWeek: dow,
                                          ));
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _infoLine(ThemeData theme, {required IconData icon, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Icon(icon, size: 20, color: theme.colorScheme.secondary),
        const SizedBox(width: 8),
        Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
      ]),
    );
  }

  Widget _sectionLabel(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(text, style: theme.textTheme.titleMedium),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    _animationController.dispose();
    super.dispose();
    _employeeBloc.close();
  }
}

class _EmployeeDialog extends StatelessWidget {
  final List<Employee> employees;
  const _EmployeeDialog({required this.employees});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.dialogBackgroundColor,
      title: Text("Select Employee", style: theme.textTheme.headlineSmall),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: ListView.builder(
          itemCount: employees.length,
          itemBuilder: (_, i) {
            final e = employees[i];
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(e.image)),
              title: Text(e.name, style: theme.textTheme.bodyMedium),
              subtitle: Text(e.email, style: theme.textTheme.bodyMedium),
              onTap: () => Navigator.pop(context, e),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: theme.textTheme.labelLarge),
        ),
      ],
    );
  }
}
