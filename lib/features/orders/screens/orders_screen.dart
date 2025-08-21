// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// //
// // import '../../../core/api_service.dart';
// // import '../bloc/order_bloc.dart';
// // import '../bloc/order_event.dart';
// // import '../bloc/order_state.dart';
// // import '../employ/employee_bloc.dart';
// // import '../employee_repository.dart';
// // import '../order_repository.dart';
// //
// // class OrdersPage extends StatefulWidget {
// //   const OrdersPage({Key? key}) : super(key: key);
// //
// //   @override
// //   State<OrdersPage> createState() => _OrdersPageState();
// // }
// //
// // class _OrdersPageState extends State<OrdersPage> {
// //   final ScrollController _scrollController = ScrollController();
// //   late OrderBloc _orderBloc;
// //   late EmployeeBloc _employeeBloc;
// //
// //   final Map<int, List<int>> selectedEmployeeMap = {};
// //   // final selectedIds = selectedEmployeeMap[order.id] ?? [];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _orderBloc =
// //         OrderBloc(orderRepository: OrderRepository(apiService: ApiService()));
// //     _employeeBloc = EmployeeBloc(EmployeeRepository(api: ApiService()));
// //     _orderBloc.add(FetchOrders());
// //     _employeeBloc.add(LoadEmployees());
// //     _scrollController.addListener(_onScroll);
// //   }
// //
// //   void _onScroll() {
// //     if (_scrollController.position.pixels >=
// //             _scrollController.position.maxScrollExtent &&
// //         !_orderBloc.isFetching) {
// //       _orderBloc.add(FetchOrders());
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MultiBlocProvider(
// //       providers: [
// //         BlocProvider.value(value: _orderBloc),
// //         BlocProvider.value(value: _employeeBloc),
// //       ],
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text("Orders"),
// //           backgroundColor: Colors.indigo,
// //         ),
// //         body: BlocBuilder<OrderBloc, OrderState>(
// //           builder: (context, state) {
// //             if (state is OrderInitial) {
// //               return const Center(child: CircularProgressIndicator());
// //             } else if (state is OrderFailure) {
// //               return Center(child: Text("Failed: ${state.error}"));
// //             } else if (state is OrderLoaded) {
// //               if (state.orders.isEmpty) {
// //                 return const Center(child: Text("No Orders"));
// //               }
// //
// //               return ListView.builder(
// //                 controller: _scrollController,
// //                 itemCount: state.hasReachedMax
// //                     ? state.orders.length
// //                     : state.orders.length + 1,
// //                 itemBuilder: (context, index) {
// //                   if (index >= state.orders.length) {
// //                     return const Center(child: CircularProgressIndicator());
// //                   }
// //
// //                   final order = state.orders[index];
// //
// //                   return StatefulBuilder(
// //                     builder: (context, setOrderState) {
// //                       final selectedIds = selectedEmployeeMap[order.id] ?? [];
// //
// //                       return Padding(
// //                         padding: const EdgeInsets.symmetric(
// //                             horizontal: 12, vertical: 10),
// //                         child: Card(
// //                           elevation: 6,
// //                           shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(16)),
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(16),
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     Text(order.orderNumber,
// //                                         style: const TextStyle(
// //                                             fontSize: 16,
// //                                             fontWeight: FontWeight.bold)),
// //                                     Container(
// //                                       padding: const EdgeInsets.symmetric(
// //                                           horizontal: 10, vertical: 4),
// //                                       decoration: BoxDecoration(
// //                                         color: _statusColor(order.orderStatus),
// //                                         borderRadius: BorderRadius.circular(8),
// //                                       ),
// //                                       child: Text(
// //                                           order.orderStatus.toUpperCase(),
// //                                           style: const TextStyle(
// //                                               color: Colors.white,
// //                                               fontSize: 12)),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 const Divider(height: 20),
// //                                 _infoRow(Icons.payment,
// //                                     "${order.paymentMethod} - ${order.paymentStatus}"),
// //                                 if (order.customer != null)
// //                                   _infoRow(Icons.person,
// //                                       "${order.customer!.name} | ${order.customer!.mobile}"),
// //                                 if (order.address != null)
// //                                   _infoRow(Icons.location_on,
// //                                       "${order.address!.buildingName}, ${order.address!.area}"),
// //                                 _infoRow(Icons.attach_money,
// //                                     "AED ${order.total.toStringAsFixed(2)}"),
// //                                 const SizedBox(height: 12),
// //                                 if (order.orderItems.isNotEmpty)
// //                                   Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [
// //                                       const Text("Items:",
// //                                           style: TextStyle(
// //                                               fontWeight: FontWeight.bold,
// //                                               fontSize: 15)),
// //                                       const SizedBox(height: 4),
// //                                       ...order.orderItems
// //                                           .map((item) => ListTile(
// //                                                 contentPadding: EdgeInsets.zero,
// //                                                 dense: true,
// //                                                 leading: const Icon(
// //                                                     Icons.cleaning_services,
// //                                                     color: Colors.indigo),
// //                                                 title: Text(
// //                                                     "${item.thirdCategory?.name ?? "Cleaning"} × ${item.employeeCount}"),
// //                                               )),
// //                                     ],
// //                                   ),
// //                                 const SizedBox(height: 16),
// //                                 const Text("Assign Employees:",
// //                                     style: TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                         fontSize: 15)),
// //                                 BlocBuilder<EmployeeBloc, EmployeeState>(
// //                                   builder: (context, empState) {
// //                                     if (empState is EmployeeLoaded) {
// //                                       return Column(
// //                                         crossAxisAlignment:
// //                                             CrossAxisAlignment.start,
// //                                         children: [
// //                                           const SizedBox(height: 6),
// //                                           _roundedButton(
// //                                             icon: Icons.group_add,
// //                                             label: "Select Employees",
// //                                             color: Colors.indigoAccent,
// //                                             onPressed: () async {
// //                                               final tempSelected =
// //                                                   List<int>.from(selectedIds);
// //                                               final selected =
// //                                                   await showDialog<List<int>>(
// //                                                 context: context,
// //                                                 builder: (_) =>
// //                                                     _employeeSelectDialog(
// //                                                         empState.employees,
// //                                                         tempSelected),
// //                                               );
// //                                               if (selected != null) {
// //                                                 setOrderState(() {
// //                                                   selectedEmployeeMap[
// //                                                       order.id] = selected;
// //                                                 });
// //                                               }
// //                                             },
// //                                           ),
// //                                           const SizedBox(height: 8),
// //                                           Wrap(
// //                                             spacing: 6,
// //                                             children: selectedIds.map((id) {
// //                                               final emp = empState.employees
// //                                                   .firstWhere(
// //                                                       (e) => e.id == id);
// //                                               return Chip(
// //                                                 label: Text(emp.name),
// //                                                 avatar: CircleAvatar(
// //                                                     backgroundImage:
// //                                                         NetworkImage(
// //                                                             emp.image)),
// //                                                 deleteIcon:
// //                                                     const Icon(Icons.close),
// //                                                 onDeleted: () {
// //                                                   setOrderState(() {
// //                                                     selectedEmployeeMap[
// //                                                             order.id]
// //                                                         ?.remove(id);
// //                                                   });
// //                                                 },
// //                                               );
// //                                             }).toList(),
// //                                           ),
// //                                           const SizedBox(height: 8),
// //                                           _roundedButton(
// //                                             icon: Icons.done,
// //                                             label: "Assign Selected",
// //                                             color: Colors.green,
// //                                             disabled: selectedIds.isEmpty,
// //                                             onPressed: selectedIds.isEmpty
// //                                                 ? null
// //                                                 : () {
// //                                                     context
// //                                                         .read<EmployeeBloc>()
// //                                                         .add(
// //                                                           AssignEmployees(
// //                                                               orderId: order.id,
// //                                                               employeeIds:
// //                                                                   selectedIds),
// //                                                         );
// //                                                     ScaffoldMessenger.of(
// //                                                             context)
// //                                                         .showSnackBar(
// //                                                       const SnackBar(
// //                                                           content: Text(
// //                                                               "Employees assigned successfully!")),
// //                                                     );
// //                                                   },
// //                                           ),
// //                                         ],
// //                                       );
// //                                     } else if (empState is EmployeeError) {
// //                                       return Text(empState.message,
// //                                           style: const TextStyle(
// //                                               color: Colors.red));
// //                                     } else {
// //                                       return const Center(
// //                                           child: CircularProgressIndicator());
// //                                     }
// //                                   },
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   );
// //                 },
// //               );
// //             }
// //             return const SizedBox();
// //           },
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _infoRow(IconData icon, String text) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 4),
// //       child: Row(
// //         children: [
// //           Icon(icon, size: 18, color: Colors.grey[700]),
// //           const SizedBox(width: 6),
// //           Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _roundedButton({
// //     required IconData icon,
// //     required String label,
// //     required Color color,
// //     required VoidCallback? onPressed,
// //     bool disabled = false,
// //   }) {
// //     return ElevatedButton.icon(
// //       onPressed: disabled ? null : onPressed,
// //       icon: Icon(icon, size: 18),
// //       label: Text(label),
// //       style: ElevatedButton.styleFrom(
// //         backgroundColor: disabled ? Colors.grey : color,
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
// //       ),
// //     );
// //   }
// //
// //   Widget _employeeSelectDialog(
// //       List<dynamic> employees, List<int> tempSelected) {
// //     return StatefulBuilder(
// //       builder: (context, setDialogState) {
// //         return AlertDialog(
// //           title: const Text('Select Employees'),
// //           content: SizedBox(
// //             width: double.maxFinite,
// //             child: ListView.builder(
// //               itemCount: employees.length,
// //               itemBuilder: (context, index) {
// //                 final emp = employees[index];
// //                 final isSelected = tempSelected.contains(emp.id);
// //                 return CheckboxListTile(
// //                   value: isSelected,
// //                   onChanged: (checked) {
// //                     setDialogState(() {
// //                       if (checked == true) {
// //                         tempSelected.add(emp.id);
// //                       } else {
// //                         tempSelected.remove(emp.id);
// //                       }
// //                     });
// //                   },
// //                   title: Text(emp.name),
// //                   secondary:
// //                       CircleAvatar(backgroundImage: NetworkImage(emp.image)),
// //                 );
// //               },
// //             ),
// //           ),
// //           actions: [
// //             TextButton(
// //                 onPressed: () => Navigator.pop(context, null),
// //                 child: const Text("Cancel")),
// //             ElevatedButton(
// //                 onPressed: () => Navigator.pop(context, tempSelected),
// //                 child: const Text("Done")),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     _scrollController.dispose();
// //     _orderBloc.close();
// //     _employeeBloc.close();
// //     super.dispose();
// //   }
// // }
// //
// // Color _statusColor(String status) {
// //   switch (status.toLowerCase()) {
// //     case 'completed':
// //       return Colors.green;
// //     case 'confirmed':
// //       return Colors.orange;
// //     case 'pending':
// //       return Colors.amber;
// //     case 'cancelled':
// //       return Colors.red;
// //     default:
// //       return Colors.blueGrey;
// //   }
// // }
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// //
// // import '../../../base/widget_utils.dart';
// // import '../../../core/api_service.dart';
// // import '../bloc/order_bloc.dart';
// // import '../bloc/order_event.dart';
// // import '../bloc/order_state.dart';
// // import '../employ/employee_bloc.dart';
// // import '../employee_repository.dart';
// // import '../models/employee_model.dart';
// // import '../order_repository.dart';
// // import 'OrderDetailPage.dart';
// //
// // class OrdersPage extends StatefulWidget {
// //   const OrdersPage({super.key});
// //
// //   @override
// //   State<OrdersPage> createState() => _OrdersPageState();
// // }
// //
// // class _OrdersPageState extends State<OrdersPage> {
// //   final _scrollController = ScrollController();
// //   late final OrderBloc _orderBloc;
// //   late final EmployeeBloc _employeeBloc;
// //
// //   final Map<int, List<int>> selectedMap = {}; // orderId -> employeeIds
// //   final Map<int, bool> isAssigning = {}; // orderId -> loading
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _orderBloc =
// //         OrderBloc(orderRepository: OrderRepository(apiService: ApiService()));
// //     _employeeBloc = EmployeeBloc(EmployeeRepository(api: ApiService()));
// //
// //     _orderBloc.add(FetchOrders());
// //     _employeeBloc.add(LoadEmployees());
// //     _scrollController.addListener(_onScroll);
// //   }
// //
// //   void _onScroll() {
// //     if (_scrollController.position.pixels >=
// //             _scrollController.position.maxScrollExtent &&
// //         !_orderBloc.isFetching) {
// //       _orderBloc.add(FetchOrders());
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MultiBlocProvider(
// //       providers: [
// //         BlocProvider.value(value: _orderBloc),
// //         BlocProvider.value(value: _employeeBloc),
// //       ],
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: getCustomFont("  Orders  ", 22, Colors.black, 2,
// //               fontWeight: FontWeight.bold),
// //         ),
// //         // AppBar(title: const Text("Orders"), backgroundColor: Colors.indigo),
// //         body: BlocBuilder<OrderBloc, OrderState>(
// //           builder: (context, state) {
// //             if (state is OrderInitial) {
// //               return const Center(child: CircularProgressIndicator());
// //             } else if (state is OrderFailure) {
// //               return Center(child: Text('Error: ${state.error}'));
// //             } else if (state is OrderLoaded) {
// //               if (state.orders.isEmpty) {
// //                 return const Center(child: Text("No Orders"));
// //               }
// //               return ListView.builder(
// //                 controller: _scrollController,
// //                 itemCount: state.hasReachedMax
// //                     ? state.orders.length
// //                     : state.orders.length + 1,
// //                 itemBuilder: (context, index) {
// //                   if (index >= state.orders.length) {
// //                     return const Padding(
// //                       padding: EdgeInsets.all(16),
// //                       child: Center(child: CircularProgressIndicator()),
// //                     );
// //                   }
// //
// //                   final order = state.orders[index];
// //                   selectedMap.putIfAbsent(
// //                       order.id,
// //                       () => order.workAssignments
// //                           .map((e) => e.employee.id)
// //                           .toList());
// //
// //                   return StatefulBuilder(
// //                     builder: (context, setOrderState) {
// //                       return Padding(
// //                         padding: const EdgeInsets.all(12),
// //                         child: GestureDetector(
// //                           onTap: () {
// //                             Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                 builder: (_) => OrderDetailPage(order: order),
// //                               ),
// //                             );
// //                           },
// //                           child: Card(
// //                             elevation: 6,
// //                             shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(16)),
// //                             child: Padding(
// //                               padding: const EdgeInsets.all(16),
// //                               child: Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   /// Header
// //                                   Row(
// //                                     mainAxisAlignment:
// //                                         MainAxisAlignment.spaceBetween,
// //                                     children: [
// //                                       Text(order.orderNumber,
// //                                           style: const TextStyle(
// //                                               fontSize: 16,
// //                                               fontWeight: FontWeight.bold)),
// //                                       Container(
// //                                         padding: const EdgeInsets.symmetric(
// //                                             horizontal: 10, vertical: 4),
// //                                         decoration: BoxDecoration(
// //                                           color:
// //                                               _statusColor(order.orderStatus),
// //                                           borderRadius:
// //                                               BorderRadius.circular(8),
// //                                         ),
// //                                         child: Text(
// //                                             order.orderStatus.toUpperCase(),
// //                                             style: const TextStyle(
// //                                                 color: Colors.white,
// //                                                 fontSize: 12)),
// //                                       ),
// //                                     ],
// //                                   ),
// //
// //                                   const SizedBox(height: 10),
// //                                   _infoRow(Icons.payment,
// //                                       "${order.paymentMethod} - ${order.paymentStatus}"),
// //                                   if (order.customer != null)
// //                                     _infoRow(Icons.person,
// //                                         "${order.customer!.name} | ${order.customer!.mobile}"),
// //                                   if (order.address != null)
// //                                     _infoRow(Icons.location_on,
// //                                         "${order.address!.buildingName}, ${order.address!.area}"),
// //                                   _infoRow(Icons.attach_money,
// //                                       "AED ${order.total.toStringAsFixed(2)}"),
// // // Customer information
// //                                   Text("Customer Info"),
// //                                   if (order.customer != null) ...[
// //                                     _infoRow(Icons.person,
// //                                         "Name: ${order.customer!.name}"),
// //                                     _infoRow(Icons.email,
// //                                         "Email: ${order.customer!.email}"),
// //                                     _infoRow(Icons.phone,
// //                                         "Mobile: ${order.customer!.mobile}"),
// //                                   ],
// // // Address information
// //                                   Text("Address"),
// //                                   if (order.address != null)
// //                                     _infoRow(Icons.location_on,
// //                                         "Building: ${order.address!.buildingName}, Area: ${order.address!.area}"),
// //
// //                                   /// Order Items
// //                                   if (order.orderItems.isNotEmpty) ...[
// //                                     const SizedBox(height: 12),
// //                                     const Text("Items:",
// //                                         style: TextStyle(
// //                                             fontWeight: FontWeight.bold)),
// //                                     const SizedBox(height: 4),
// //                                     ...order.orderItems.map((item) => ListTile(
// //                                           dense: true,
// //                                           contentPadding: EdgeInsets.zero,
// //                                           leading: const Icon(
// //                                               Icons.cleaning_services,
// //                                               color: Colors.indigo),
// //                                           title: Text(
// //                                               "${item.thirdCategory?.name ?? 'Cleaning'} × ${item.employeeCount}"),
// //                                         )),
// //                                   ],
// //
// //                                   const SizedBox(height: 12),
// //                                   const Text("Assign Employees:",
// //                                       style: TextStyle(
// //                                           fontWeight: FontWeight.bold,
// //                                           fontSize: 15)),
// //
// //                                   BlocBuilder<EmployeeBloc, EmployeeState>(
// //                                     builder: (context, empState) {
// //                                       if (empState is EmployeeLoaded) {
// //                                         final selected = selectedMap[order.id]!;
// //                                         return Column(
// //                                           crossAxisAlignment:
// //                                               CrossAxisAlignment.start,
// //                                           children: [
// //                                             const SizedBox(height: 6),
// //                                             _roundedButton(
// //                                               icon: Icons.group_add,
// //                                               label: "Select Employees",
// //                                               color: Colors.indigo,
// //                                               onPressed: () async {
// //                                                 final result =
// //                                                     await showDialog<List<int>>(
// //                                                   context: context,
// //                                                   builder: (_) =>
// //                                                       _employeeSelectDialog(
// //                                                           empState.employees,
// //                                                           selected),
// //                                                 );
// //                                                 if (result != null) {
// //                                                   setOrderState(() {
// //                                                     selectedMap[order.id] =
// //                                                         result;
// //                                                   });
// //                                                 }
// //                                               },
// //                                             ),
// //                                             const SizedBox(height: 8),
// //                                             Wrap(
// //                                               spacing: 6,
// //                                               children: selected.map((id) {
// //                                                 final emp = empState.employees
// //                                                     .firstWhere(
// //                                                         (e) => e.id == id);
// //                                                 return Chip(
// //                                                   label: Text(emp.name),
// //                                                   avatar: CircleAvatar(
// //                                                       backgroundImage:
// //                                                           NetworkImage(
// //                                                               emp.image)),
// //                                                   onDeleted: () {
// //                                                     setOrderState(() {
// //                                                       selectedMap[order.id]
// //                                                           ?.remove(id);
// //                                                     });
// //                                                   },
// //                                                 );
// //                                               }).toList(),
// //                                             ),
// //                                             const SizedBox(height: 8),
// //                                             _roundedButton(
// //                                               icon:
// //                                                   isAssigning[order.id] == true
// //                                                       ? Icons.sync
// //                                                       : Icons.check_circle,
// //                                               label:
// //                                                   isAssigning[order.id] == true
// //                                                       ? "Assigning..."
// //                                                       : "Assign Selected",
// //                                               color: Colors.green,
// //                                               disabled: selected.isEmpty ||
// //                                                   isAssigning[order.id] == true,
// //                                               onPressed: () async {
// //                                                 setOrderState(() =>
// //                                                     isAssigning[order.id] =
// //                                                         true);
// //                                                 await context
// //                                                     .read<EmployeeBloc>()
// //                                                     .repository
// //                                                     .assignEmployees(
// //                                                         order.id, selected);
// //                                                 setOrderState(() =>
// //                                                     isAssigning[order.id] =
// //                                                         false);
// //
// //                                                 if (context.mounted) {
// //                                                   ScaffoldMessenger.of(context)
// //                                                       .showSnackBar(
// //                                                     const SnackBar(
// //                                                         content: Text(
// //                                                             "Employees assigned successfully")),
// //                                                   );
// //                                                 }
// //                                               },
// //                                             ),
// //                                           ],
// //                                         );
// //                                       } else if (empState is EmployeeError) {
// //                                         return Text(empState.message,
// //                                             style: const TextStyle(
// //                                                 color: Colors.red));
// //                                       } else {
// //                                         return const Center(
// //                                             child: CircularProgressIndicator());
// //                                       }
// //                                     },
// //                                   )
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   );
// //                 },
// //               );
// //             }
// //             return const SizedBox();
// //           },
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _infoRow(IconData icon, String text) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 4),
// //       child: Row(
// //         children: [
// //           Icon(icon, size: 18, color: Colors.grey[700]),
// //           const SizedBox(width: 6),
// //           Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _roundedButton({
// //     required IconData icon,
// //     required String label,
// //     required Color color,
// //     required VoidCallback? onPressed,
// //     bool disabled = false,
// //   }) {
// //     return ElevatedButton.icon(
// //       icon: Icon(icon, size: 18),
// //       label: Text(label),
// //       onPressed: disabled ? null : onPressed,
// //       style: ElevatedButton.styleFrom(
// //         backgroundColor: disabled ? Colors.grey : color,
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
// //       ),
// //     );
// //   }
// //
// //   Widget _employeeSelectDialog(
// //       List<Employee> employees, List<int> selectedIds) {
// //     final temp = List<int>.from(selectedIds);
// //     return StatefulBuilder(
// //       builder: (context, setState) {
// //         return AlertDialog(
// //           title: const Text('Select Employees'),
// //           content: SizedBox(
// //             width: double.maxFinite,
// //             child: ListView.builder(
// //               itemCount: employees.length,
// //               itemBuilder: (_, index) {
// //                 final emp = employees[index];
// //                 final isSelected = temp.contains(emp.id);
// //                 return CheckboxListTile(
// //                   value: isSelected,
// //                   onChanged: (val) {
// //                     setState(() {
// //                       if (val == true) {
// //                         temp.add(emp.id);
// //                       } else {
// //                         temp.remove(emp.id);
// //                       }
// //                     });
// //                   },
// //                   title: Text(emp.name),
// //                   secondary:
// //                       CircleAvatar(backgroundImage: NetworkImage(emp.image)),
// //                 );
// //               },
// //             ),
// //           ),
// //           actions: [
// //             TextButton(
// //                 onPressed: () => Navigator.pop(context),
// //                 child: const Text("Cancel")),
// //             ElevatedButton(
// //                 onPressed: () => Navigator.pop(context, temp),
// //                 child: const Text("Done")),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     _scrollController.dispose();
// //     _orderBloc.close();
// //     _employeeBloc.close();
// //     super.dispose();
// //   }
// // }
// //
// // Color _statusColor(String status) {
// //   switch (status.toLowerCase()) {
// //     case 'completed':
// //       return Colors.green;
// //     case 'confirmed':
// //       return Colors.orange;
// //     case 'pending':
// //       return Colors.amber;
// //     case 'cancelled':
// //       return Colors.red;
// //     default:
// //       return Colors.blueGrey;
// //   }
// // }
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:intl/intl.dart';
// //
// // import '../../../base/widget_utils.dart';
// // import '../../../core/api_service.dart';
// // import '../bloc/order_bloc.dart';
// // import '../bloc/order_event.dart';
// // import '../bloc/order_state.dart';
// // import '../employ/employee_bloc.dart';
// // import '../employee_repository.dart';
// // import '../models/employee_model.dart';
// // import '../order_repository.dart';
// // import 'OrderDetailPage.dart';
// //
// // class OrdersPage extends StatefulWidget {
// //   const OrdersPage({super.key});
// //
// //   @override
// //   State<OrdersPage> createState() => _OrdersPageState();
// // }
// //
// // class _OrdersPageState extends State<OrdersPage> {
// //   final _scrollController = ScrollController();
// //   late final OrderBloc _orderBloc;
// //   late final EmployeeBloc _employeeBloc;
// //
// //   // currently selected filter date
// //   DateTime _selectedDate = DateTime.now();
// //
// //   final Map<int, List<int>> selectedMap = {}; // orderId -> employeeIds
// //   final Map<int, bool> isAssigning = {};      // orderId -> loading
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _orderBloc = OrderBloc(
// //       orderRepository: OrderRepository(apiService: ApiService()),
// //     );
// //     _employeeBloc = EmployeeBloc(
// //       EmployeeRepository(api: ApiService()),
// //     );
// //
// //     // load employees once
// //     _employeeBloc.add(LoadEmployees());
// //
// //     // initial fetch for today
// //     _fetchFor(_selectedDate, isRefresh: true);
// //
// //     _scrollController.addListener(_onScroll);
// //   }
// //
// //   void _fetchFor(DateTime date, { bool isRefresh = false }) {
// //     _orderBloc.add(FetchOrders(date: date, isRefresh: isRefresh));
// //   }
// //
// //   void _onScroll() {
// //     // only trigger when at bottom, not currently loading, and not already at end
// //     if (_scrollController.position.pixels >=
// //         _scrollController.position.maxScrollExtent &&
// //         !_orderBloc.isFetching &&
// //         _orderBloc.state is OrderLoaded &&
// //         !(_orderBloc.state as OrderLoaded).hasReachedMax) {
// //       _orderBloc.add(FetchOrders(date: _selectedDate));
// //     }
// //   }
// //
// //
// //   Future<void> _pickDate() async {
// //     final picked = await showDatePicker(
// //       context: context,
// //       initialDate: _selectedDate,
// //       firstDate: DateTime(2020),
// //       lastDate: DateTime.now().add(const Duration(days: 365)),
// //     );
// //     if (picked != null && picked != _selectedDate) {
// //       setState(() => _selectedDate = picked);
// //       _fetchFor(picked, isRefresh: true);
// //       _scrollController.jumpTo(0);
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MultiBlocProvider(
// //       providers: [
// //         BlocProvider.value(value: _orderBloc),
// //         BlocProvider.value(value: _employeeBloc),
// //       ],
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: getCustomFont("Orders", 22, Colors.black, 2,
// //               fontWeight: FontWeight.bold),
// //           actions: [
// //             IconButton(
// //               icon: const Icon(Icons.calendar_today),
// //               onPressed: _pickDate,
// //             ),
// //           ],
// //         ),
// //         body: Column(
// //           children: [
// //             // Date filter display
// //             Padding(
// //               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// //               child: Row(
// //                 children: [
// //                   const Text("Showing: "),
// //                   Text(
// //                     DateFormat.yMMMMd().format(_selectedDate),
// //                     style: const TextStyle(fontWeight: FontWeight.bold),
// //                   ),
// //                   const Spacer(),
// //                   TextButton(
// //                     onPressed: _pickDate,
// //                     child: const Text("Change Date"),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             // Order list
// //             Expanded(
// //               child: BlocBuilder<OrderBloc, OrderState>(
// //                 builder: (context, state) {
// //                   if (state is OrderInitial) {
// //                     return const Center(child: CircularProgressIndicator());
// //                   } else if (state is OrderFailure) {
// //                     return Center(child: Text('Error: ${state.error}'));
// //                   } else if (state is OrderLoaded) {
// //                     if (state.orders.isEmpty) {
// //                       return const Center(child: Text("No Orders"));
// //                     }
// //                     return ListView.builder(
// //                       controller: _scrollController,
// //                       itemCount: state.hasReachedMax
// //                           ? state.orders.length
// //                           : state.orders.length + 1,
// //                       itemBuilder: (context, index) {
// //                         if (index >= state.orders.length) {
// //                           return const Padding(
// //                             padding: EdgeInsets.all(16),
// //                             child:
// //                             Center(child: CircularProgressIndicator()),
// //                           );
// //                         }
// //                         final order = state.orders[index];
// //                         selectedMap.putIfAbsent(
// //                           order.id,
// //                               () => order.workAssignments
// //                               .map((e) => e.employee.id)
// //                               .toList(),
// //                         );
// //
// //                         return _buildOrderCard(order);
// //                       },
// //                     );
// //                   }
// //                   return const SizedBox();
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildOrderCard(order) {
// //     return StatefulBuilder(
// //       builder: (context, setOrderState) {
// //         return Padding(
// //           padding: const EdgeInsets.all(12),
// //           child: GestureDetector(
// //             onTap: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (_) => OrderDetailPage(order: order),
// //                 ),
// //               );
// //             },
// //             child: Card(
// //               elevation: 6,
// //               shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(16)),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(16),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     /// Header
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Text(order.orderNumber,
// //                             style: const TextStyle(
// //                                 fontSize: 16, fontWeight: FontWeight.bold)),
// //                         Container(
// //                           padding: const EdgeInsets.symmetric(
// //                               horizontal: 10, vertical: 4),
// //                           decoration: BoxDecoration(
// //                             color: _statusColor(order.orderStatus),
// //                             borderRadius: BorderRadius.circular(8),
// //                           ),
// //                           child: Text(order.orderStatus.toUpperCase(),
// //                               style: const TextStyle(
// //                                   color: Colors.white, fontSize: 12)),
// //                         ),
// //                       ],
// //                     ),
// //
// //                     // CREATED / SCHEDULED
// //                     _infoRow(Icons.date_range,
// //                         DateFormat.yMMMd().add_jm().format(order.createdAt!)),
// //                     _infoRow(Icons.event,
// //                         "Scheduled time ID: ${order.scheduledTimeId}"),
// //
// //                     // FINANCIALS
// //                     _infoRow(Icons.receipt,
// //                         "Subtotal: AED ${order.subtotal.toStringAsFixed(2)}"),
// //                     _infoRow(Icons.percent,
// //                         "Tax (${order.taxRate}%): AED ${order.taxAmount.toStringAsFixed(2)}"),
// //                     _infoRow(Icons.attach_money,
// //                         "Total: AED ${order.total.toStringAsFixed(2)}"),
// //
// //                     // COUPONS & REFERRALS
// //                     if (order.couponCode != null && order.couponCode!.isNotEmpty)
// //                       _infoRow(Icons.card_giftcard,
// //                           "Coupon: ${order.couponCode} (-AED ${order.couponDiscount.toStringAsFixed(2)})"),
// //                     if (order.referralCode != null && order.referralCode!.isNotEmpty)
// //                       _infoRow(Icons.redeem,
// //                           "Referral: ${order.referralCode} (+${order.referralBonusCoins} coins)"),
// //
// //                     // ASSIGN / SUBSCRIPTION
// //                     _infoRow(Icons.group, "Assign status: ${order.assignStatus}"),
// //                     _infoRow(Icons.event_repeat, order.hasSubscription
// //                         ? "Subscription: every ${order.subscriptionDuration} month(s)"
// //                         : "Subscription: none"),
// //
// //                     // CUSTOMER & ADDRESS (existing)
// //                     if (order.customer != null)
// //                       _infoRow(Icons.person,
// //                           "${order.customer!.name} | ${order.customer!.mobile ?? '—'}"),
// //                     if (order.address != null)
// //                       _infoRow(Icons.location_on,
// //                           "${order.address!.buildingName}, ${order.address!.area}"),
// //
// //                     // NOTES
// //                     if (order.notes != null && order.notes!.isNotEmpty)
// //                       Padding(
// //                         padding: const EdgeInsets.only(top: 8),
// //                         child: Text("Notes: ${order.notes!}",
// //                             style: const TextStyle(fontStyle: FontStyle.italic)),
// //                       ),
// //
// //                     const SizedBox(height: 10),
// //                     _infoRow(Icons.date_range,
// //                         DateFormat.yMMMd().add_jm().format(order.createdAt!)),
// //                     _infoRow(Icons.payment,
// //                         "${order.paymentMethod} — ${order.paymentStatus}"),
// //                     if (order.customer != null)
// //                       _infoRow(Icons.person,
// //                           "${order.customer!.name} | ${order.customer!.mobile}"),
// //                     if (order.address != null)
// //                       _infoRow(Icons.location_on,
// //                           "${order.address!.buildingName}, ${order.address!.area}"),
// //                     _infoRow(Icons.attach_money,
// //                         "AED ${order.total.toStringAsFixed(2)}"),
// //
// //                     const SizedBox(height: 12),
// //                     const Text("Items:",
// //                         style: TextStyle(fontWeight: FontWeight.bold)),
// //                     ...order.orderItems.map((item) => ListTile(
// //                       dense: true,
// //                       contentPadding: EdgeInsets.zero,
// //                       leading: const Icon(Icons.cleaning_services,
// //                           color: Colors.indigo),
// //                       title: Text(
// //                           "${item.thirdCategory?.name ?? 'Service'} × ${item.employeeCount}"),
// //                     )),
// //
// //                     const SizedBox(height: 12),
// //                     const Text("Assign Employees:",
// //                         style: TextStyle(
// //                             fontWeight: FontWeight.bold, fontSize: 15)),
// //                     BlocBuilder<EmployeeBloc, EmployeeState>(
// //                       builder: (context, empState) {
// //                         if (empState is EmployeeLoaded) {
// //                           final selected = selectedMap[order.id]!;
// //                           return Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               const SizedBox(height: 6),
// //                               _roundedButton(
// //                                 icon: Icons.group_add,
// //                                 label: "Select",
// //                                 color: Colors.indigo,
// //                                 onPressed: () async {
// //                                   final result = await showDialog<List<int>>(
// //                                     context: context,
// //                                     builder: (_) => _employeeSelectDialog(
// //                                         empState.employees, selected),
// //                                   );
// //                                   if (result != null) {
// //                                     setOrderState(
// //                                             () => selectedMap[order.id] = result);
// //                                   }
// //                                 },
// //                               ),
// //                               const SizedBox(height: 8),
// //                               Wrap(
// //                                 spacing: 6,
// //                                 children: selected.map((id) {
// //                                   final emp = empState.employees
// //                                       .firstWhere((e) => e.id == id);
// //                                   return Chip(
// //                                     label: Text(emp.name),
// //                                     avatar: CircleAvatar(
// //                                         backgroundImage:
// //                                         NetworkImage(emp.image)),
// //                                     onDeleted: () {
// //                                       setOrderState(() =>
// //                                           selectedMap[order.id]!.remove(id));
// //                                     },
// //                                   );
// //                                 }).toList(),
// //                               ),
// //                               const SizedBox(height: 8),
// //                               _roundedButton(
// //                                 icon: isAssigning[order.id] == true
// //                                     ? Icons.sync
// //                                     : Icons.check_circle,
// //                                 label: isAssigning[order.id] == true
// //                                     ? "Assigning…"
// //                                     : "Assign",
// //                                 color: Colors.green,
// //                                 disabled: selected.isEmpty ||
// //                                     isAssigning[order.id] == true,
// //                                 onPressed: () async {
// //                                   setOrderState(
// //                                           () => isAssigning[order.id] = true);
// //                                   await context
// //                                       .read<EmployeeBloc>()
// //                                       .repository
// //                                       .assignEmployees(order.id, selected);
// //                                   setOrderState(
// //                                           () => isAssigning[order.id] = false);
// //                                   if (context.mounted) {
// //                                     ScaffoldMessenger.of(context).showSnackBar(
// //                                       const SnackBar(
// //                                           content: Text(
// //                                               "Employees assigned successfully")),
// //                                     );
// //                                   }
// //                                 },
// //                               ),
// //                             ],
// //                           );
// //                         } else if (empState is EmployeeError) {
// //                           return Text(empState.message,
// //                               style: const TextStyle(color: Colors.red));
// //                         }
// //                         return const Center(
// //                             child: CircularProgressIndicator());
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _infoRow(IconData icon, String text) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 4),
// //       child: Row(
// //         children: [
// //           Icon(icon, size: 18, color: Colors.grey[700]),
// //           const SizedBox(width: 6),
// //           Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _roundedButton({
// //     required IconData icon,
// //     required String label,
// //     required Color color,
// //     required VoidCallback? onPressed,
// //     bool disabled = false,
// //   }) {
// //     return ElevatedButton.icon(
// //       icon: Icon(icon, size: 18),
// //       label: Text(label),
// //       onPressed: disabled ? null : onPressed,
// //       style: ElevatedButton.styleFrom(
// //         backgroundColor: disabled ? Colors.grey : color,
// //         shape:
// //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
// //       ),
// //     );
// //   }
// //
// //   Widget _employeeSelectDialog(
// //       List<Employee> employees, List<int> selectedIds) {
// //     final temp = List<int>.from(selectedIds);
// //     return StatefulBuilder(
// //       builder: (context, setState) {
// //         return AlertDialog(
// //           title: const Text('Select Employees'),
// //           content: SizedBox(
// //             width: double.maxFinite,
// //             child: ListView.builder(
// //               itemCount: employees.length,
// //               itemBuilder: (_, i) {
// //                 final emp = employees[i];
// //                 final isSelected = temp.contains(emp.id);
// //                 return CheckboxListTile(
// //                   value: isSelected,
// //                   onChanged: (val) {
// //                     setState(() {
// //                       if (val == true) temp.add(emp.id);
// //                       else temp.remove(emp.id);
// //                     });
// //                   },
// //                   title: Text(emp.name),
// //                   secondary:
// //                   CircleAvatar(backgroundImage: NetworkImage(emp.image)),
// //                 );
// //               },
// //             ),
// //           ),
// //           actions: [
// //             TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
// //             ElevatedButton(onPressed: () => Navigator.pop(context, temp), child: const Text("Done")),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     _scrollController.dispose();
// //     _orderBloc.close();
// //     _employeeBloc.close();
// //     super.dispose();
// //   }
// // }
// //
// // Color _statusColor(String status) {
// //   switch (status.toLowerCase()) {
// //     case 'completed':
// //       return Colors.green;
// //     case 'confirmed':
// //       return Colors.orange;
// //     case 'pending':
// //       return Colors.amber;
// //     case 'cancelled':
// //       return Colors.red;
// //     default:
// //       return Colors.blueGrey;
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
//
// import '../../../base/widget_utils.dart';
// import '../../../core/api_service.dart';
// import '../bloc/order_bloc.dart';
// import '../bloc/order_event.dart';
// import '../bloc/order_state.dart';
// import '../employ/employee_bloc.dart';
// import '../employee_repository.dart';
// import '../models/employee_model.dart';
// import '../order_repository.dart';
// import 'OrderDetailPage.dart';
//
// // class OrdersPage extends StatefulWidget {
// //   const OrdersPage({Key? key}) : super(key: key);
// //
// //   @override
// //   State<OrdersPage> createState() => _OrdersPageState();
// // }
//
// class OrdersPage extends StatefulWidget {
//   const OrdersPage({Key? key, this.initialDate, this.focusOrderId}) : super(key: key);
//
//   final DateTime? initialDate;
//   final int? focusOrderId;
//
//   @override
//   State<OrdersPage> createState() => _OrdersPageState();
// }
//
// class _OrdersPageState extends State<OrdersPage> {
//   final _scrollController = ScrollController();
//   late final OrderBloc _orderBloc;
//   late final EmployeeBloc _employeeBloc;
//
//   DateTime _selectedDate = DateTime.now();
//   final Map<int, List<int>> selectedMap = {};
//   final Map<int, bool> isAssigning = {};
//
//   // bool get hasPets => null;
//
//   @override
//   void initState() {
//     super.initState();
//     _orderBloc = OrderBloc(orderRepository: OrderRepository(apiService: ApiService()));
//     _employeeBloc = EmployeeBloc(EmployeeRepository(api: ApiService()));
//
//     _employeeBloc.add(LoadEmployees());
//     _fetchFor(_selectedDate, isRefresh: true);
//     _scrollController.addListener(_onScroll);
//   }
//
//   void _fetchFor(DateTime date, {bool isRefresh = false}) {
//     _orderBloc.add(FetchOrders(date: date, isRefresh: isRefresh));
//   }
//
//   void _onScroll() {
//     if (_scrollController.position.pixels >=
//         _scrollController.position.maxScrollExtent &&
//         !_orderBloc.isFetching &&
//         _orderBloc.state is OrderLoaded &&
//         !(_orderBloc.state as OrderLoaded).hasReachedMax) {
//       _orderBloc.add(FetchOrders(date: _selectedDate));
//     }
//   }
//
//   Future<void> _pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() => _selectedDate = picked);
//       _fetchFor(picked, isRefresh: true);
//       _scrollController.jumpTo(0);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider.value(value: _orderBloc),
//         BlocProvider.value(value: _employeeBloc),
//       ],
//       child: Scaffold(
//         backgroundColor: theme.scaffoldBackgroundColor,
//         appBar: AppBar(
//           backgroundColor: theme.primaryColor,
//           title: Text('Orders', style: theme.textTheme.headlineSmall),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.calendar_today, color: theme.colorScheme.secondary),
//               onPressed: _pickDate,
//             )
//           ],
//         ),
//         body: Column(
//           children: [
//             // ─── Date filter ─────────────────────────────────────
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               child:
//               Row(
//                 children: [
//                   // Text('Showing : ', style: theme.textTheme.titleMedium ),
//                   Text(
//                     DateFormat.yMMMMd().format(_selectedDate),
//                     style: theme.textTheme.titleMedium,
//                   ),
//                   const Spacer(),
//
//                   // ← wrap in Flexible so Row gives it a finite max‑width
//                   Flexible(
//                     fit: FlexFit.loose,
//                     child: OutlinedButton(
//                       onPressed: _pickDate,
//                       style: OutlinedButton.styleFrom(
//                         // allow it to shrink to its content
//                         minimumSize: const Size(0, 44),
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         foregroundColor: theme.colorScheme.secondary,
//                         side: BorderSide(color: theme.colorScheme.secondary),
//                         backgroundColor: theme.cardColor,
//                       ),
//                       child: Text(
//                         'Change Date',
//                         style: theme.textTheme.labelLarge
//                             ?.copyWith(color: theme.colorScheme.secondary),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//
//             ),
//
//             // ─── Order list ──────────────────────────────────────
//             Expanded(
//               child: BlocBuilder<OrderBloc, OrderState>(
//                 builder: (context, state) {
//                   if (state is OrderInitial) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (state is OrderFailure) {
//                     return Center(child: Text('Error: ${state.error}',
//                         style: theme.textTheme.bodyMedium));
//                   } else if (state is OrderLoaded) {
//                     if (state.orders.isEmpty) {
//                       return Center(child: Text("No Orders",
//                           style: theme.textTheme.bodyMedium));
//                     }
//                     return ListView.builder(
//                       controller: _scrollController,
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       itemCount: state.hasReachedMax
//                           ? state.orders.length
//                           : state.orders.length + 1,
//                       itemBuilder: (context, index) {
//                         if (index >= state.orders.length) {
//                           return const Padding(
//                             padding: EdgeInsets.all(16),
//                             child: Center(child: CircularProgressIndicator()),
//                           );
//                         }
//                         final order = state.orders[index];
//                         selectedMap.putIfAbsent(
//                           order.id,
//                               () => order.workAssignments.map((e) => e.employee.id).toList(),
//                         );
//                         return _buildOrderCard(order, theme);
//                       },
//                     );
//                   }
//                   return const SizedBox();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// //   Widget _buildOrderCard(order, ThemeData theme) {
// //     // 1️⃣ guard against null
// //     final status = order.orderStatus ?? '';
// //     final statusColor = _statusColor(status);
// //     // final hasPets = order.petsPresent;      // bool
// //     // final petCount = order.petCount ?? 0;   // int?
// //
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //       child: Card(
// //         color: theme.cardColor,
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //         elevation: 4,
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: ExpansionTile
// //             (
// //             // styling
// //             tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //             childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //             backgroundColor: theme.cardColor,
// //             collapsedBackgroundColor: theme.cardColor,
// //             iconColor: theme.colorScheme.secondary,
// //             collapsedIconColor: theme.colorScheme.secondary,
// //             // header row
// //             title: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text(order.orderNumber, style: theme.textTheme.titleMedium),
// //                 Container(
// //                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// //                   decoration: BoxDecoration(
// //                     color: _statusColor(order.orderStatus),
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                   child: Text(
// //                     order.orderStatus.toUpperCase(),
// //                     style: theme.textTheme.bodyMedium
// //                         ?.copyWith(color: Colors.white, fontSize: 12),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             // the “chevron” is provided automatically by ExpansionTile
// //             children: [
// //               // CORE METADATA
// //               _infoRow(theme, Icons.date_range,
// //                   DateFormat.yMMMd().add_jm().format(order.createdAt!)),
// //               _infoRow(theme, Icons.event, "Scheduled: ${order.scheduledTimeId}"),
// //               _infoRow(theme, Icons.attach_money,
// //                   "Total: AED ${order.total.toStringAsFixed(2)}"),
// //               const Divider(color: Colors.transparent),
// //
// //               // PREFERENCES (modeled fields)
// //               Text("Preferences", style: theme.textTheme.titleMedium),
// //               const SizedBox(height: 6),
// //               _infoRow(theme, Icons.bedroom_parent_outlined,
// //                   "Bedrooms: ${order.bedrooms ?? '-'}"),
// //               // _infoRow(theme, Icons.pets,
// //               //     "Pets Present: ${order.petsPresent > 0 ? order.petsPresent : 'None'}"),
// //
// //         // _infoRow(theme, Icons.pets, hasPets
// //         // ? "Pets Present: $petCount"
// //         //     : "Pets Present: No"),
// // // … inside _buildOrderCard …
// // //               _infoRow(theme, Icons.pets,
// // //                   "Pets Present: ${order.petsPresent ? 'Yes' : 'No'}"),
// //
// //           _infoRow(theme, Icons.bed, "Beds: ${order.beds ?? '-'}"),
// //               _infoRow(theme, Icons.weekend, "Sofa Beds: ${order.sofaBeds ?? '-'}"),
// //               _infoRow(theme, Icons.label_outline_sharp,
// //                   "With Linen: ${order.withLinen == 1 ? 'Yes' : 'No'}"),
// //               _infoRow(theme, Icons.shopping_bag,
// //                   "With Supplies: ${order.withSupplies == 1 ? 'Yes' : 'No'}"),
// //               _infoRow(theme, Icons.door_front_door,
// //                   "Door Access Code: ${order.doorAccessCode ?? '-'}"),
// //               _infoRow(theme, Icons.people, "Occupancy: ${order.occupancy ?? '-'}"),
// //               const Divider(color: Colors.transparent),
// //
// //               // DATE & TIME
// //               Text("Time & Date", style: theme.textTheme.titleMedium),
// //               const SizedBox(height: 6),
// //               _infoRow(theme, Icons.access_time,
// //                   "Check‐in: ${order.checkInTime != null ? DateFormat.jm().format(order.checkInTime! as DateTime) : '-'}"),
// //               _infoRow(theme, Icons.access_time_outlined,
// //                   "Check‐out: ${order.checkOutTime != null ? DateFormat.jm().format(order.checkOutTime! as DateTime) : '-'}"),
// //               if (order.bookingDate != null)
// //                 _infoRow(theme, Icons.book_online,
// //                     "Booking Date: ${DateFormat.yMMMd().format(order.bookingDate!)}"),
// //               const Divider(color: Colors.transparent),
// //
// //               // COUPON & REFERRAL
// //               Text("Coupon & Referral", style: theme.textTheme.titleMedium),
// //               const SizedBox(height: 6),
// //               _infoRow(theme, Icons.local_offer,
// //                   "Coupon Code: ${order.couponCode ?? '-'}"),
// //               _infoRow(theme, Icons.money_off,
// //                   "Coupon Discount: AED ${order.couponDiscount.toStringAsFixed(2)}"),
// //               _infoRow(theme, Icons.redeem,
// //                   "Referral Code: ${order.referralCode ?? '-'}"),
// //               _infoRow(theme, Icons.stars,
// //                   "Referral Bonus: ${order.referralBonusCoins} coins"),
// //               const Divider(color: Colors.transparent),
// //
// //               // CUSTOMER & ADDRESS
// //               if (order.customer != null) ...[
// //                 Text("Customer", style: theme.textTheme.titleMedium),
// //                 const SizedBox(height: 6),
// //                 _infoRow(theme, Icons.person,
// //                     "${order.customer!.name} | ${order.customer!.mobile ?? '-'}"),
// //                 const Divider(color: Colors.transparent),
// //               ],
// //               if (order.address != null) ...[
// //                 Text("Address", style: theme.textTheme.titleMedium),
// //                 const SizedBox(height: 6),
// //                 _infoRow(theme, Icons.location_on,
// //                     "${order.address!.buildingName}, ${order.address!.area}"),
// //                 const Divider(color: Colors.transparent),
// //               ],
// //
// //               // ITEMS
// //               if (order.orderItems.isNotEmpty) ...[
// //                 Text("Items", style: theme.textTheme.titleMedium),
// //                 const SizedBox(height: 6),
// //                 ...order.orderItems.map((item) => _itemRow(theme, item)),
// //                 const Divider(color: Colors.transparent),
// //               ],
// //
// //               // ASSIGNMENTS
// //               Text("Assign Employees", style: theme.textTheme.titleMedium),
// //               const SizedBox(height: 6),
// //               BlocBuilder<EmployeeBloc, EmployeeState>(
// //                 builder: (context, empState) {
// //                   if (empState is EmployeeLoaded) {
// //                     final selected = selectedMap[order.id]!;
// //                     return Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         _roundedButton(
// //                           theme,
// //                           icon: Icons.group_add,
// //                           label: "Select",
// //                           color: theme.colorScheme.secondary,
// //                           onPressed: () async {
// //                             final result = await showDialog<List<int>>(
// //                               context: context,
// //                               builder: (_) =>
// //                                   _employeeSelectDialog(empState.employees, selected),
// //                             );
// //                             if (result != null) {
// //                               setState(() => selectedMap[order.id] = result);
// //                             }
// //                           },
// //                         ),
// //                         const SizedBox(height: 8),
// //                         Wrap(
// //                           spacing: 6,
// //                           children: selected.map((id) {
// //                             final emp = empState.employees
// //                                 .firstWhere((e) => e.id == id);
// //                             return Chip(
// //                               label: Text(emp.name,
// //                                   style: theme.textTheme.bodyMedium),
// //                               avatar: CircleAvatar(
// //                                   backgroundImage: NetworkImage(emp.image)),
// //                               backgroundColor:
// //                               theme.colorScheme.secondary.withOpacity(0.2),
// //                               onDeleted: () {
// //                                 setState(() =>
// //                                     selectedMap[order.id]!.remove(id));
// //                               },
// //                             );
// //                           }).toList(),
// //                         ),
// //                         const SizedBox(height: 8),
// //                         _roundedButton(
// //                           theme,
// //                           icon: isAssigning[order.id] == true
// //                               ? Icons.sync
// //                               : Icons.check_circle,
// //                           label: isAssigning[order.id] == true
// //                               ? "Assigning…"
// //                               : "Assign",
// //                           color: Colors.green,
// //                           disabled: selected.isEmpty ||
// //                               isAssigning[order.id] == true,
// //                           onPressed: () async {
// //                             setState(() => isAssigning[order.id] = true);
// //                             await context
// //                                 .read<EmployeeBloc>()
// //                                 .repository
// //                                 .assignEmployees(order.id, selected);
// //                             setState(() => isAssigning[order.id] = false);
// //                             if (mounted) {
// //                               ScaffoldMessenger.of(context).showSnackBar(
// //                                 const SnackBar(
// //                                     content: Text(
// //                                         "Employees assigned successfully")),
// //                               );
// //                             }
// //                           },
// //                         ),
// //                       ],
// //                     );
// //                   } else if (empState is EmployeeError) {
// //                     return Text(empState.message,
// //                         style: theme.textTheme.bodyMedium
// //                             ?.copyWith(color: Colors.red));
// //                   }
// //                   return const Center(child: CircularProgressIndicator());
// //                 },
// //               ),
// //
// //               // VIEW FULL DETAILS BUTTON
// //               Align(
// //                 alignment: Alignment.centerRight,
// //                 child: TextButton(
// //                   onPressed: () => Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: (_) => OrderDetailPage(order: order))),
// //                   child: const Text("View Full Details →"),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
//
//   Widget _buildOrderCard(order, ThemeData theme) {
//     return StatefulBuilder(
//       builder: (context, setOrderState) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: GestureDetector(
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => OrderDetailPage(order: order)),
//             ),
//             child: Card(
//               color: theme.cardColor,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16)),
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Header
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(order.orderNumber,
//                             style: theme.textTheme.titleMedium),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: _statusColor(order.orderStatus),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(order.orderStatus.toUpperCase(),
//                               style: theme.textTheme.bodyMedium
//                                   ?.copyWith(color: Colors.white, fontSize: 12)),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//
//                     // Metadata
//                     // _infoRow(theme, Icons.date_range,
//                     //     DateFormat.yMMMd().add_jm().format(order.createdAt!)),
//                     // _infoRow(
//                     //   theme,
//                     //   Icons.event,
//                     //   "Scheduled: ${formatDateTime(parseUtcToLocal(order.scheduledTime))}",
//                     // ),
//                     _infoRow(
//                       theme,
//                       Icons.event,
//                       "Created time: ${DateFormat.yMMMd().add_jm().format(order.createdAt!.toLocal())}",
//                     ),
//
//                     _infoRow(
//                       theme,
//                       Icons.book_online,
//                       'Booked Date: ${DateFormat.yMMMd().format(order.bookingDate!)}',
//                     ),
//                     // _infoRow(
//                     //   theme,
//                     //   Icons.book_online,
//                     //   'Booking created Date: ${DateFormat.yMMMd().format(order.createdAt!)}',
//                     // ),
//
//                     // _infoRow(theme, Icons.event,
//                     //     "Scheduled id : ${order.scheduledTimeId}"),
//                   _infoRow(
//                     theme,
//                     Icons.access_time,
//                     "Scheduled time: ${order.scheduledTime ?? 'N/A'}",
//                   ),
//
//
//
//
//
//                   // _infoRow(theme, Icons.event,
//                     //     "Scheduled: ${order.scheduledTimeId}"),
//                     _infoRow(theme, Icons.attach_money,
//                         "Total: AED ${order.total.toStringAsFixed(2)}"),
//
//                     // Coupons & referral
//                     if ((order.couponCode ?? '').isNotEmpty)
//                       _infoRow(theme, Icons.card_giftcard,
//                           "Coupon: ${order.couponCode}"),
//                     if ((order.referralCode ?? '').isNotEmpty)
//                       _infoRow(theme, Icons.redeem,
//                           "Referral: +${order.referralBonusCoins} coins"),
//
//                     const SizedBox(height: 12),
//                     Text("Items:", style: theme.textTheme.titleMedium),
//                     ...order.orderItems.map((item) => _itemRow(theme, item)),
//
//                     const SizedBox(height: 12),
//                     Text("Assign Employees:", style: theme.textTheme.titleMedium),
//                     const SizedBox(height: 6),
//                     BlocBuilder<EmployeeBloc, EmployeeState>(
//                       builder: (context, empState) {
//                         if (empState is EmployeeLoaded) {
//                           final selected = selectedMap[order.id]!;
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               _roundedButton(
//                                 theme,
//                                 icon: Icons.group_add,
//                                 label: "Select",
//                                 color: theme.colorScheme.secondary,
//                                 onPressed: () async {
//                                   final result = await showDialog<List<int>>(
//                                     context: context,
//                                     builder: (_) => _employeeSelectDialog(
//                                         empState.employees, selected),
//                                   );
//                                   if (result != null) {
//                                     setOrderState(
//                                             () => selectedMap[order.id] = result);
//                                   }
//                                 },
//                               ),
//                               const SizedBox(height: 8),
//                               Wrap(
//                                 spacing: 6,
//                                 children: selected.map((id) {
//                                   final emp = empState.employees
//                                       .firstWhere((e) => e.id == id);
//                                   return Chip(
//                                     label: Text(emp.name,
//                                         style: theme.textTheme.bodyMedium),
//                                     avatar: CircleAvatar(
//                                         backgroundImage:
//                                         NetworkImage(emp.image)),
//                                     backgroundColor:
//                                     theme.colorScheme.secondary
//                                         .withOpacity(0.2),
//                                     onDeleted: () {
//                                       setOrderState(() =>
//                                           selectedMap[order.id]!.remove(id));
//                                     },
//                                   );
//                                 }).toList(),
//                               ),
//                               const SizedBox(height: 8),
//                               _roundedButton(
//                                 theme,
//                                 icon: isAssigning[order.id] == true
//                                     ? Icons.sync
//                                     : Icons.check_circle,
//                                 label: isAssigning[order.id] == true
//                                     ? "Assigning…"
//                                     : "Assign",
//                                 color: Colors.green,
//                                 disabled: selected.isEmpty ||
//                                     isAssigning[order.id] == true,
//                                 onPressed: () async {
//                                   setOrderState(
//                                           () => isAssigning[order.id] = true);
//                                   await context
//                                       .read<EmployeeBloc>()
//                                       .repository
//                                       .assignEmployees(order.id, selected);
//                                   setOrderState(
//                                           () => isAssigning[order.id] = false);
//                                   if (context.mounted) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                           content: Text(style: TextStyle(color: Colors.white),
//                                               "Employees assigned successfully ")),
//                                     );
//                                   }
//                                 },
//                               ),
//                             ],
//                           );
//                         } else if (empState is EmployeeError) {
//                           return Text(empState.message,
//                               style: theme.textTheme.bodyMedium
//                                   ?.copyWith(color: Colors.red));
//                         }
//                         return const Center(child: CircularProgressIndicator());
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _infoRow(ThemeData theme, IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(children: [
//         Icon(icon, size: 20, color: theme.colorScheme.secondary),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Text(text, style: theme.textTheme.bodyMedium),
//         ),
//       ]),
//     );
//   }
//
//   Widget _itemRow(ThemeData theme, item) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 32, top: 4),
//       child: Text(
//         "• ${item.thirdCategory?.name ?? 'Service'} × ${item.employeeCount}",
//         style: theme.textTheme.bodyMedium,
//       ),
//     );
//   }
//
//   Widget _roundedButton(
//       ThemeData theme, {
//         required IconData icon,
//         required String label,
//         required Color color,
//         VoidCallback? onPressed,
//         bool disabled = false,
//       }) {
//     return ElevatedButton.icon(
//       icon: Icon(icon, size: 18, color: Colors.white),
//       label: Text(label, style: theme.textTheme.labelLarge?.copyWith(color: Colors.white)),
//       onPressed: disabled ? null : onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: disabled ? Colors.grey : color,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         minimumSize: const Size.fromHeight(44),
//       ),
//     );
//   }
//
//   Widget _employeeSelectDialog(List<Employee> employees, List<int> selectedIds) {
//     final temp = List<int>.from(selectedIds);
//     return StatefulBuilder(builder: (context, setState) {
//       return AlertDialog(
//         backgroundColor: Theme.of(context).cardColor,
//         title: Text('Select Employees',
//             style: Theme.of(context).textTheme.titleMedium),
//         content: SizedBox(
//           width: double.maxFinite,
//           child: ListView.builder(
//             itemCount: employees.length,
//             itemBuilder: (_, i) {
//               final emp = employees[i];
//               final isSel = temp.contains(emp.id);
//               return CheckboxListTile(
//                 value: isSel,
//                 onChanged: (v) {
//                   setState(() {
//                     if (v == true) temp.add(emp.id);
//                     else temp.remove(emp.id);
//                   });
//                 },
//                 title: Text(emp.name, style: Theme.of(context).textTheme.bodyMedium),
//                 secondary: CircleAvatar(backgroundImage: NetworkImage(emp.image)),
//                 activeColor: Theme.of(context).colorScheme.secondary,
//               );
//             },
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () => Navigator.pop(context, temp),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Theme.of(context).colorScheme.secondary,
//             ),
//             child: const Text('Done'),
//           ),
//         ],
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _orderBloc.close();
//     _employeeBloc.close();
//     super.dispose();
//   }
//
//   String formatDateTime(DateTime dateTime) {
//     // Example: "Jul 7, 2025 04:00 PM"
//     return DateFormat.yMMMd().add_jm().format(dateTime);
//   }
//
//   DateTime parseUtcToLocal(String utcString) {
//     return DateTime.parse(utcString).toLocal();
//   }
//
// }
//
// Color _statusColor(String status) {
//   switch (status.toLowerCase()) {
//     case 'completed':
//       return const Color(0xFF3FB984); // mint green
//     case 'confirmed':
//       return const Color(0xFF1ED8C1); // aqua blue
//     case 'pending':
//       return const Color(0xFFE63946); // soft red
//     case 'cancelled':
//       return Colors.red;
//     default:
//       return Colors.grey;
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
  const OrdersPage({
    Key? key,
    this.initialDate,
    this.focusOrderId,
  }) : super(key: key);

  /// Open the page showing orders of this date (defaults to today)
  final DateTime? initialDate;

  /// If provided, the list will auto-scroll to this order and highlight it
  final int? focusOrderId;

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final _scrollController = ScrollController();

  // Rough per-card extent for scroll math; adjust if your card is taller/shorter
  static const double _cardExtent = 260;

  late final OrderBloc _orderBloc;
  late final EmployeeBloc _employeeBloc;

  late DateTime _selectedDate;
  bool _didScrollToFocus = false;

  final Map<int, List<int>> selectedMap = {};
  final Map<int, bool> isAssigning = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();

    _orderBloc = OrderBloc(orderRepository: OrderRepository(apiService: ApiService()));
    _employeeBloc = EmployeeBloc(EmployeeRepository(api: ApiService()))..add(LoadEmployees());

    _fetchFor(_selectedDate, isRefresh: true);
    _scrollController.addListener(_onScroll);
  }

  void _fetchFor(DateTime date, {bool isRefresh = false}) {
    _orderBloc.add(FetchOrders(date: date, isRefresh: isRefresh));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
        !_orderBloc.isFetching &&
        _orderBloc.state is OrderLoaded &&
        !(_orderBloc.state as OrderLoaded).hasReachedMax) {
      _orderBloc.add(FetchOrders(date: _selectedDate));
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _didScrollToFocus = false; // reset auto-scroll for a new date
      });
      _fetchFor(picked, isRefresh: true);
      _scrollController.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _orderBloc),
        BlocProvider.value(value: _employeeBloc),
      ],
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          title: Text('Orders', style: theme.textTheme.headlineSmall),
          actions: [
            IconButton(
              icon: Icon(Icons.calendar_today, color: theme.colorScheme.secondary),
              onPressed: _pickDate,
            )
          ],
        ),
        body: Column(
          children: [
            // Date filter
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Text(
                    DateFormat.yMMMMd().format(_selectedDate),
                    style: theme.textTheme.titleMedium,
                  ),
                  const Spacer(),
                  Flexible(
                    fit: FlexFit.loose,
                    child: OutlinedButton(
                      onPressed: _pickDate,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 44),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        foregroundColor: theme.colorScheme.secondary,
                        side: BorderSide(color: theme.colorScheme.secondary),
                        backgroundColor: theme.cardColor,
                      ),
                      child: Text(
                        'Change Date',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Order list
            Expanded(
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderInitial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is OrderFailure) {
                    return Center(
                      child:
                      Text('Error: ${state.error}', style: theme.textTheme.bodyMedium),
                    );
                  } else if (state is OrderLoaded) {
                    if (state.orders.isEmpty) {
                      return Center(
                        child: Text("No Orders", style: theme.textTheme.bodyMedium),
                      );
                    }

                    // Auto-scroll to the focused order once
                    if (!_didScrollToFocus && widget.focusOrderId != null) {
                      final idx = state.orders.indexWhere((o) => o.id == widget.focusOrderId);
                      if (idx >= 0) {
                        _didScrollToFocus = true;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (_scrollController.hasClients) {
                            final target = (idx * _cardExtent)
                                .clamp(0, _scrollController.position.maxScrollExtent);
                            _scrollController.animateTo(
                              target.toDouble(),
                              duration: const Duration(milliseconds: 450),
                              curve: Curves.easeOut,
                            );
                          }
                        });
                      }
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount:
                      state.hasReachedMax ? state.orders.length : state.orders.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.orders.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        final order = state.orders[index];
                        final isFocus =
                        (widget.focusOrderId != null && order.id == widget.focusOrderId);

                        selectedMap.putIfAbsent(
                          order.id,
                              () => order.workAssignments.map((e) => e.employee.id).toList(),
                        );

                        return _buildOrderCard(order, theme, isFocus: isFocus);
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(order, ThemeData theme, {bool isFocus = false}) {
    return StatefulBuilder(
      builder: (context, setOrderState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OrderDetailPage(order: order)),
            ),
            child: Card(
              color: theme.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: isFocus
                    ? BorderSide(color: theme.colorScheme.secondary, width: 2)
                    : BorderSide(color: Colors.transparent, width: 0),
              ),
              elevation: isFocus ? 8 : 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(order.orderNumber, style: theme.textTheme.titleMedium),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _statusColor(order.orderStatus),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            order.orderStatus.toUpperCase(),
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Metadata
                    _infoRow(
                      theme,
                      Icons.event,
                      "Created time: ${DateFormat.yMMMd().add_jm().format(order.createdAt!.toLocal())}",
                    ),
                    _infoRow(
                      theme,
                      Icons.book_online,
                      'Booked Date: ${DateFormat.yMMMd().format(order.bookingDate!)}',
                    ),
                    _infoRow(
                      theme,
                      Icons.access_time,
                      "Scheduled time: ${order.scheduledTime ?? 'N/A'}",
                    ),
                    _infoRow(
                      theme,
                      Icons.attach_money,
                      "Total: AED ${order.total.toStringAsFixed(2)}",
                    ),

                    if ((order.couponCode ?? '').isNotEmpty)
                      _infoRow(theme, Icons.card_giftcard, "Coupon: ${order.couponCode}"),
                    if ((order.referralCode ?? '').isNotEmpty)
                      _infoRow(theme, Icons.redeem,
                          "Referral: +${order.referralBonusCoins} coins"),

                    const SizedBox(height: 12),
                    Text("Items:", style: theme.textTheme.titleMedium),
                    ...order.orderItems.map((item) => _itemRow(theme, item)),

                    const SizedBox(height: 12),
                    Text("Assign Employees:", style: theme.textTheme.titleMedium),
                    const SizedBox(height: 6),
                    BlocBuilder<EmployeeBloc, EmployeeState>(
                      builder: (context, empState) {
                        if (empState is EmployeeLoaded) {
                          final selected = selectedMap[order.id]!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _roundedButton(
                                theme,
                                icon: Icons.group_add,
                                label: "Select",
                                color: theme.colorScheme.secondary,
                                onPressed: () async {
                                  final result = await showDialog<List<int>>(
                                    context: context,
                                    builder: (_) =>
                                        _employeeSelectDialog(empState.employees, selected),
                                  );
                                  if (result != null) {
                                    setOrderState(() => selectedMap[order.id] = result);
                                  }
                                },
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 6,
                                children: selected.map((id) {
                                  final emp =
                                  empState.employees.firstWhere((e) => e.id == id);
                                  return Chip(
                                    label:
                                    Text(emp.name, style: theme.textTheme.bodyMedium),
                                    avatar: CircleAvatar(
                                      backgroundImage: NetworkImage(emp.image),
                                    ),
                                    backgroundColor:
                                    theme.colorScheme.secondary.withOpacity(0.2),
                                    onDeleted: () {
                                      setOrderState(() => selectedMap[order.id]!.remove(id));
                                    },
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 8),
                              _roundedButton(
                                theme,
                                icon: isAssigning[order.id] == true
                                    ? Icons.sync
                                    : Icons.check_circle,
                                label: isAssigning[order.id] == true
                                    ? "Assigning…"
                                    : "Assign",
                                color: Colors.green,
                                disabled: selected.isEmpty || isAssigning[order.id] == true,
                                onPressed: () async {
                                  setOrderState(() => isAssigning[order.id] = true);
                                  await context
                                      .read<EmployeeBloc>()
                                      .repository
                                      .assignEmployees(order.id, selected);
                                  setOrderState(() => isAssigning[order.id] = false);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Employees assigned successfully ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          );
                        } else if (empState is EmployeeError) {
                          return Text(
                            empState.message,
                            style:
                            theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _infoRow(ThemeData theme, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Icon(icon, size: 20, color: theme.colorScheme.secondary),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
      ]),
    );
  }

  Widget _itemRow(ThemeData theme, item) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 4),
      child: Text(
        "• ${item.thirdCategory?.name ?? 'Service'} × ${item.employeeCount}",
        style: theme.textTheme.bodyMedium,
      ),
    );
  }

  Widget _roundedButton(
      ThemeData theme, {
        required IconData icon,
        required String label,
        required Color color,
        VoidCallback? onPressed,
        bool disabled = false,
      }) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 18, color: Colors.white),
      label: Text(label, style: theme.textTheme.labelLarge?.copyWith(color: Colors.white)),
      onPressed: disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: disabled ? Colors.grey : color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size.fromHeight(44),
      ),
    );
  }

  Widget _employeeSelectDialog(List<Employee> employees, List<int> selectedIds) {
    final temp = List<int>.from(selectedIds);
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text('Select Employees', style: Theme.of(context).textTheme.titleMedium),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: employees.length,
            itemBuilder: (_, i) {
              final emp = employees[i];
              final isSel = temp.contains(emp.id);
              return CheckboxListTile(
                value: isSel,
                onChanged: (v) {
                  setState(() {
                    if (v == true) {
                      temp.add(emp.id);
                    } else {
                      temp.remove(emp.id);
                    }
                  });
                },
                title: Text(emp.name, style: Theme.of(context).textTheme.bodyMedium),
                secondary: CircleAvatar(backgroundImage: NetworkImage(emp.image)),
                activeColor: Theme.of(context).colorScheme.secondary,
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, temp),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            child: const Text('Done'),
          ),
        ],
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _orderBloc.close();
    _employeeBloc.close();
    super.dispose();
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat.yMMMd().add_jm().format(dateTime);
  }

  DateTime parseUtcToLocal(String utcString) {
    return DateTime.parse(utcString).toLocal();
  }
}

Color _statusColor(String status) {
  switch (status.toLowerCase()) {
    case 'completed':
      return const Color(0xFF3FB984); // mint green
    case 'confirmed':
      return const Color(0xFF1ED8C1); // aqua blue
    case 'pending':
      return const Color(0xFFE63946); // soft red
    case 'cancelled':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
