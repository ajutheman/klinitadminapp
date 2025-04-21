// import 'package:equatable/equatable.dart';
//
// abstract class OrderEvent extends Equatable {
//   @override
//   List<Object> get props => [];
// }
//
// class FetchOrders extends OrderEvent {}
import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

/// Load (or refresh) the first page for [date].
class FetchOrders extends OrderEvent {
  final DateTime date;
  final bool isRefresh;

  const FetchOrders({ required this.date, this.isRefresh = false });

  @override
  List<Object> get props => [date, isRefresh];
}
