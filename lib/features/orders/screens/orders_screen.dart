// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../core/api_service.dart';
// import '../bloc/order_bloc.dart';
// import '../bloc/order_event.dart';
// import '../bloc/order_state.dart';
// import '../employ/employee_bloc.dart';
// import '../employee_repository.dart';
// import '../order_repository.dart';
//
// class OrdersPage extends StatefulWidget {
//   const OrdersPage({Key? key}) : super(key: key);
//
//   @override
//   State<OrdersPage> createState() => _OrdersPageState();
// }
//
// class _OrdersPageState extends State<OrdersPage> {
//   final ScrollController _scrollController = ScrollController();
//   late OrderBloc _orderBloc;
//   late EmployeeBloc _employeeBloc;
//
//   final Map<int, List<int>> selectedEmployeeMap = {};
//   // final selectedIds = selectedEmployeeMap[order.id] ?? [];
//
//   @override
//   void initState() {
//     super.initState();
//     _orderBloc =
//         OrderBloc(orderRepository: OrderRepository(apiService: ApiService()));
//     _employeeBloc = EmployeeBloc(EmployeeRepository(api: ApiService()));
//     _orderBloc.add(FetchOrders());
//     _employeeBloc.add(LoadEmployees());
//     _scrollController.addListener(_onScroll);
//   }
//
//   void _onScroll() {
//     if (_scrollController.position.pixels >=
//             _scrollController.position.maxScrollExtent &&
//         !_orderBloc.isFetching) {
//       _orderBloc.add(FetchOrders());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider.value(value: _orderBloc),
//         BlocProvider.value(value: _employeeBloc),
//       ],
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Orders"),
//           backgroundColor: Colors.indigo,
//         ),
//         body: BlocBuilder<OrderBloc, OrderState>(
//           builder: (context, state) {
//             if (state is OrderInitial) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is OrderFailure) {
//               return Center(child: Text("Failed: ${state.error}"));
//             } else if (state is OrderLoaded) {
//               if (state.orders.isEmpty) {
//                 return const Center(child: Text("No Orders"));
//               }
//
//               return ListView.builder(
//                 controller: _scrollController,
//                 itemCount: state.hasReachedMax
//                     ? state.orders.length
//                     : state.orders.length + 1,
//                 itemBuilder: (context, index) {
//                   if (index >= state.orders.length) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//
//                   final order = state.orders[index];
//
//                   return StatefulBuilder(
//                     builder: (context, setOrderState) {
//                       final selectedIds = selectedEmployeeMap[order.id] ?? [];
//
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 10),
//                         child: Card(
//                           elevation: 6,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16)),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(order.orderNumber,
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold)),
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 10, vertical: 4),
//                                       decoration: BoxDecoration(
//                                         color: _statusColor(order.orderStatus),
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       child: Text(
//                                           order.orderStatus.toUpperCase(),
//                                           style: const TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 12)),
//                                     ),
//                                   ],
//                                 ),
//                                 const Divider(height: 20),
//                                 _infoRow(Icons.payment,
//                                     "${order.paymentMethod} - ${order.paymentStatus}"),
//                                 if (order.customer != null)
//                                   _infoRow(Icons.person,
//                                       "${order.customer!.name} | ${order.customer!.mobile}"),
//                                 if (order.address != null)
//                                   _infoRow(Icons.location_on,
//                                       "${order.address!.buildingName}, ${order.address!.area}"),
//                                 _infoRow(Icons.attach_money,
//                                     "AED ${order.total.toStringAsFixed(2)}"),
//                                 const SizedBox(height: 12),
//                                 if (order.orderItems.isNotEmpty)
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const Text("Items:",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15)),
//                                       const SizedBox(height: 4),
//                                       ...order.orderItems
//                                           .map((item) => ListTile(
//                                                 contentPadding: EdgeInsets.zero,
//                                                 dense: true,
//                                                 leading: const Icon(
//                                                     Icons.cleaning_services,
//                                                     color: Colors.indigo),
//                                                 title: Text(
//                                                     "${item.thirdCategory?.name ?? "Cleaning"} × ${item.employeeCount}"),
//                                               )),
//                                     ],
//                                   ),
//                                 const SizedBox(height: 16),
//                                 const Text("Assign Employees:",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15)),
//                                 BlocBuilder<EmployeeBloc, EmployeeState>(
//                                   builder: (context, empState) {
//                                     if (empState is EmployeeLoaded) {
//                                       return Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           const SizedBox(height: 6),
//                                           _roundedButton(
//                                             icon: Icons.group_add,
//                                             label: "Select Employees",
//                                             color: Colors.indigoAccent,
//                                             onPressed: () async {
//                                               final tempSelected =
//                                                   List<int>.from(selectedIds);
//                                               final selected =
//                                                   await showDialog<List<int>>(
//                                                 context: context,
//                                                 builder: (_) =>
//                                                     _employeeSelectDialog(
//                                                         empState.employees,
//                                                         tempSelected),
//                                               );
//                                               if (selected != null) {
//                                                 setOrderState(() {
//                                                   selectedEmployeeMap[
//                                                       order.id] = selected;
//                                                 });
//                                               }
//                                             },
//                                           ),
//                                           const SizedBox(height: 8),
//                                           Wrap(
//                                             spacing: 6,
//                                             children: selectedIds.map((id) {
//                                               final emp = empState.employees
//                                                   .firstWhere(
//                                                       (e) => e.id == id);
//                                               return Chip(
//                                                 label: Text(emp.name),
//                                                 avatar: CircleAvatar(
//                                                     backgroundImage:
//                                                         NetworkImage(
//                                                             emp.image)),
//                                                 deleteIcon:
//                                                     const Icon(Icons.close),
//                                                 onDeleted: () {
//                                                   setOrderState(() {
//                                                     selectedEmployeeMap[
//                                                             order.id]
//                                                         ?.remove(id);
//                                                   });
//                                                 },
//                                               );
//                                             }).toList(),
//                                           ),
//                                           const SizedBox(height: 8),
//                                           _roundedButton(
//                                             icon: Icons.done,
//                                             label: "Assign Selected",
//                                             color: Colors.green,
//                                             disabled: selectedIds.isEmpty,
//                                             onPressed: selectedIds.isEmpty
//                                                 ? null
//                                                 : () {
//                                                     context
//                                                         .read<EmployeeBloc>()
//                                                         .add(
//                                                           AssignEmployees(
//                                                               orderId: order.id,
//                                                               employeeIds:
//                                                                   selectedIds),
//                                                         );
//                                                     ScaffoldMessenger.of(
//                                                             context)
//                                                         .showSnackBar(
//                                                       const SnackBar(
//                                                           content: Text(
//                                                               "Employees assigned successfully!")),
//                                                     );
//                                                   },
//                                           ),
//                                         ],
//                                       );
//                                     } else if (empState is EmployeeError) {
//                                       return Text(empState.message,
//                                           style: const TextStyle(
//                                               color: Colors.red));
//                                     } else {
//                                       return const Center(
//                                           child: CircularProgressIndicator());
//                                     }
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
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
//
//   Widget _infoRow(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Icon(icon, size: 18, color: Colors.grey[700]),
//           const SizedBox(width: 6),
//           Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
//         ],
//       ),
//     );
//   }
//
//   Widget _roundedButton({
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback? onPressed,
//     bool disabled = false,
//   }) {
//     return ElevatedButton.icon(
//       onPressed: disabled ? null : onPressed,
//       icon: Icon(icon, size: 18),
//       label: Text(label),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: disabled ? Colors.grey : color,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       ),
//     );
//   }
//
//   Widget _employeeSelectDialog(
//       List<dynamic> employees, List<int> tempSelected) {
//     return StatefulBuilder(
//       builder: (context, setDialogState) {
//         return AlertDialog(
//           title: const Text('Select Employees'),
//           content: SizedBox(
//             width: double.maxFinite,
//             child: ListView.builder(
//               itemCount: employees.length,
//               itemBuilder: (context, index) {
//                 final emp = employees[index];
//                 final isSelected = tempSelected.contains(emp.id);
//                 return CheckboxListTile(
//                   value: isSelected,
//                   onChanged: (checked) {
//                     setDialogState(() {
//                       if (checked == true) {
//                         tempSelected.add(emp.id);
//                       } else {
//                         tempSelected.remove(emp.id);
//                       }
//                     });
//                   },
//                   title: Text(emp.name),
//                   secondary:
//                       CircleAvatar(backgroundImage: NetworkImage(emp.image)),
//                 );
//               },
//             ),
//           ),
//           actions: [
//             TextButton(
//                 onPressed: () => Navigator.pop(context, null),
//                 child: const Text("Cancel")),
//             ElevatedButton(
//                 onPressed: () => Navigator.pop(context, tempSelected),
//                 child: const Text("Done")),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _orderBloc.close();
//     _employeeBloc.close();
//     super.dispose();
//   }
// }
//
// Color _statusColor(String status) {
//   switch (status.toLowerCase()) {
//     case 'completed':
//       return Colors.green;
//     case 'confirmed':
//       return Colors.orange;
//     case 'pending':
//       return Colors.amber;
//     case 'cancelled':
//       return Colors.red;
//     default:
//       return Colors.blueGrey;
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/widget_utils.dart';
import '../../../core/api_service.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import '../employ/employee_bloc.dart';
import '../employee_repository.dart';
import '../models/employee_model.dart';
import '../order_repository.dart';
import 'OrderDetailPage.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final _scrollController = ScrollController();
  late final OrderBloc _orderBloc;
  late final EmployeeBloc _employeeBloc;

  final Map<int, List<int>> selectedMap = {}; // orderId -> employeeIds
  final Map<int, bool> isAssigning = {}; // orderId -> loading

  @override
  void initState() {
    super.initState();
    _orderBloc =
        OrderBloc(orderRepository: OrderRepository(apiService: ApiService()));
    _employeeBloc = EmployeeBloc(EmployeeRepository(api: ApiService()));
    _orderBloc.add(FetchOrders());
    _employeeBloc.add(LoadEmployees());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_orderBloc.isFetching) {
      _orderBloc.add(FetchOrders());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _orderBloc),
        BlocProvider.value(value: _employeeBloc),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: getCustomFont("  Orders  ", 22, Colors.black, 2,
              fontWeight: FontWeight.bold),
        ),
        // AppBar(title: const Text("Orders"), backgroundColor: Colors.indigo),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderFailure) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is OrderLoaded) {
              if (state.orders.isEmpty) {
                return const Center(child: Text("No Orders"));
              }
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.orders.length
                    : state.orders.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.orders.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final order = state.orders[index];
                  selectedMap.putIfAbsent(
                      order.id,
                      () => order.workAssignments
                          .map((e) => e.employee.id)
                          .toList());

                  return StatefulBuilder(
                    builder: (context, setOrderState) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OrderDetailPage(order: order),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Header
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(order.orderNumber,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color:
                                              _statusColor(order.orderStatus),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                            order.orderStatus.toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12)),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),
                                  _infoRow(Icons.payment,
                                      "${order.paymentMethod} - ${order.paymentStatus}"),
                                  if (order.customer != null)
                                    _infoRow(Icons.person,
                                        "${order.customer!.name} | ${order.customer!.mobile}"),
                                  if (order.address != null)
                                    _infoRow(Icons.location_on,
                                        "${order.address!.buildingName}, ${order.address!.area}"),
                                  _infoRow(Icons.attach_money,
                                      "AED ${order.total.toStringAsFixed(2)}"),
// Customer information
                                  Text("Customer Info"),
                                  if (order.customer != null) ...[
                                    _infoRow(Icons.person,
                                        "Name: ${order.customer!.name}"),
                                    _infoRow(Icons.email,
                                        "Email: ${order.customer!.email}"),
                                    _infoRow(Icons.phone,
                                        "Mobile: ${order.customer!.mobile}"),
                                  ],
// Address information
                                  Text("Address"),
                                  if (order.address != null)
                                    _infoRow(Icons.location_on,
                                        "Building: ${order.address!.buildingName}, Area: ${order.address!.area}"),

                                  /// Order Items
                                  if (order.orderItems.isNotEmpty) ...[
                                    const SizedBox(height: 12),
                                    const Text("Items:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    ...order.orderItems.map((item) => ListTile(
                                          dense: true,
                                          contentPadding: EdgeInsets.zero,
                                          leading: const Icon(
                                              Icons.cleaning_services,
                                              color: Colors.indigo),
                                          title: Text(
                                              "${item.thirdCategory?.name ?? 'Cleaning'} × ${item.employeeCount}"),
                                        )),
                                  ],

                                  const SizedBox(height: 12),
                                  const Text("Assign Employees:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),

                                  BlocBuilder<EmployeeBloc, EmployeeState>(
                                    builder: (context, empState) {
                                      if (empState is EmployeeLoaded) {
                                        final selected = selectedMap[order.id]!;
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 6),
                                            _roundedButton(
                                              icon: Icons.group_add,
                                              label: "Select Employees",
                                              color: Colors.indigo,
                                              onPressed: () async {
                                                final result =
                                                    await showDialog<List<int>>(
                                                  context: context,
                                                  builder: (_) =>
                                                      _employeeSelectDialog(
                                                          empState.employees,
                                                          selected),
                                                );
                                                if (result != null) {
                                                  setOrderState(() {
                                                    selectedMap[order.id] =
                                                        result;
                                                  });
                                                }
                                              },
                                            ),
                                            const SizedBox(height: 8),
                                            Wrap(
                                              spacing: 6,
                                              children: selected.map((id) {
                                                final emp = empState.employees
                                                    .firstWhere(
                                                        (e) => e.id == id);
                                                return Chip(
                                                  label: Text(emp.name),
                                                  avatar: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                              emp.image)),
                                                  onDeleted: () {
                                                    setOrderState(() {
                                                      selectedMap[order.id]
                                                          ?.remove(id);
                                                    });
                                                  },
                                                );
                                              }).toList(),
                                            ),
                                            const SizedBox(height: 8),
                                            _roundedButton(
                                              icon:
                                                  isAssigning[order.id] == true
                                                      ? Icons.sync
                                                      : Icons.check_circle,
                                              label:
                                                  isAssigning[order.id] == true
                                                      ? "Assigning..."
                                                      : "Assign Selected",
                                              color: Colors.green,
                                              disabled: selected.isEmpty ||
                                                  isAssigning[order.id] == true,
                                              onPressed: () async {
                                                setOrderState(() =>
                                                    isAssigning[order.id] =
                                                        true);
                                                await context
                                                    .read<EmployeeBloc>()
                                                    .repository
                                                    .assignEmployees(
                                                        order.id, selected);
                                                setOrderState(() =>
                                                    isAssigning[order.id] =
                                                        false);

                                                if (context.mounted) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            "Employees assigned successfully")),
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      } else if (empState is EmployeeError) {
                                        return Text(empState.message,
                                            style: const TextStyle(
                                                color: Colors.red));
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _roundedButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback? onPressed,
    bool disabled = false,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 18),
      label: Text(label),
      onPressed: disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: disabled ? Colors.grey : color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
    );
  }

  Widget _employeeSelectDialog(
      List<Employee> employees, List<int> selectedIds) {
    final temp = List<int>.from(selectedIds);
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text('Select Employees'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (_, index) {
                final emp = employees[index];
                final isSelected = temp.contains(emp.id);
                return CheckboxListTile(
                  value: isSelected,
                  onChanged: (val) {
                    setState(() {
                      if (val == true) {
                        temp.add(emp.id);
                      } else {
                        temp.remove(emp.id);
                      }
                    });
                  },
                  title: Text(emp.name),
                  secondary:
                      CircleAvatar(backgroundImage: NetworkImage(emp.image)),
                );
              },
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            ElevatedButton(
                onPressed: () => Navigator.pop(context, temp),
                child: const Text("Done")),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _orderBloc.close();
    _employeeBloc.close();
    super.dispose();
  }
}

Color _statusColor(String status) {
  switch (status.toLowerCase()) {
    case 'completed':
      return Colors.green;
    case 'confirmed':
      return Colors.orange;
    case 'pending':
      return Colors.amber;
    case 'cancelled':
      return Colors.red;
    default:
      return Colors.blueGrey;
  }
}
