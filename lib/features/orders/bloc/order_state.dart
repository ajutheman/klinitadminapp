// import 'package:equatable/equatable.dart';
//
// import '../models/order_model.dart';
//
// // import '../models/order.dart';
//
// abstract class OrderState extends Equatable {
//   @override
//   List<Object> get props => [];
// }
//
// class OrderInitial extends OrderState {}
//
// class OrderLoaded extends OrderState {
//   final List<Order> orders;
//   final bool hasReachedMax;
//
//   OrderLoaded({required this.orders, required this.hasReachedMax});
//
//   OrderLoaded copyWith({List<Order>? orders, bool? hasReachedMax}) {
//     return OrderLoaded(
//       orders: orders ?? this.orders,
//       hasReachedMax: hasReachedMax ?? this.hasReachedMax,
//     );
//   }
//
//   @override
//   List<Object> get props => [orders, hasReachedMax];
// }
//
// class OrderFailure extends OrderState {
//   final String error;
//   OrderFailure({required this.error});
//
//   @override
//   List<Object> get props => [error];
// }

import 'package:equatable/equatable.dart';
import '../models/order_model.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

/// When we have loaded one or more pages for a given date.
class OrderLoaded extends OrderState {
  final List<Order> orders;
  final bool hasReachedMax;
  final DateTime date;

  const OrderLoaded({
    required this.orders,
    required this.hasReachedMax,
    required this.date,
  });

  OrderLoaded copyWith({
    List<Order>? orders,
    bool? hasReachedMax,
    DateTime? date,
  }) {
    return OrderLoaded(
      orders: orders ?? this.orders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [orders, hasReachedMax, date];
}

class OrderFailure extends OrderState {
  final String error;
  const OrderFailure({ required this.error });

  @override
  List<Object?> get props => [error];
}
