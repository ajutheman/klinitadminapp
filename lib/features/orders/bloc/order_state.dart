import 'package:equatable/equatable.dart';

import '../models/order_model.dart';

// import '../models/order.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;
  final bool hasReachedMax;

  OrderLoaded({required this.orders, required this.hasReachedMax});

  OrderLoaded copyWith({List<Order>? orders, bool? hasReachedMax}) {
    return OrderLoaded(
      orders: orders ?? this.orders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [orders, hasReachedMax];
}

class OrderFailure extends OrderState {
  final String error;
  OrderFailure({required this.error});

  @override
  List<Object> get props => [error];
}
