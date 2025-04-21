// import 'package:flutter_bloc/flutter_bloc.dart';
//
// // import '../repository/order_repository.dart';
// import '../order_repository.dart';
// import 'order_event.dart';
// import 'order_state.dart';
//
// class OrderBloc extends Bloc<OrderEvent, OrderState> {
//   final OrderRepository orderRepository;
//   int currentPage = 1;
//   bool isFetching = false;
//
//   OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
//     on<FetchOrders>((event, emit) async {
//       if (isFetching) return;
//       isFetching = true;
//       try {
//         if (state is OrderInitial) {
//           final orders = await orderRepository.fetchOrders(page: currentPage);
//           emit(OrderLoaded(orders: orders, hasReachedMax: orders.isEmpty));
//         } else if (state is OrderLoaded) {
//           final currentState = state as OrderLoaded;
//           final orders = await orderRepository.fetchOrders(page: currentPage);
//           if (orders.isEmpty) {
//             emit(currentState.copyWith(hasReachedMax: true));
//           } else {
//             emit(OrderLoaded(
//               orders: currentState.orders + orders,
//               hasReachedMax: false,
//             ));
//           }
//         }
//         currentPage++;
//       } catch (e) {
//         emit(OrderFailure(error: e.toString()));
//       } finally {
//         isFetching = false;
//       }
//     });
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import '../order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  int _currentPage = 1;
  bool _isFetching = false;
  /// right below your private field
  bool get isFetching => _isFetching;

  OrderBloc({ required this.orderRepository }) : super(const OrderInitial()) {
    on<FetchOrders>(_onFetchOrders);
  }

  Future<void> _onFetchOrders(
      FetchOrders event,
      Emitter<OrderState> emit,
      ) async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      // if first load or user explicitly requested a refresh, reset paging
      if (state is OrderInitial || event.isRefresh) {
        _currentPage = 1;
        emit(const OrderInitial());
        final orders = await orderRepository.fetchOrders(
          date: event.date,
          page: _currentPage,
        );
        emit(OrderLoaded(
          orders: orders,
          hasReachedMax: orders.length < 15,
          date: event.date,
        ));
      }
      // otherwise load next page for the current date
      else if (state is OrderLoaded) {
        final current = state as OrderLoaded;
        _currentPage++;
        final orders = await orderRepository.fetchOrders(
          date: current.date,
          page: _currentPage,
        );
        if (orders.isEmpty) {
          emit(current.copyWith(hasReachedMax: true));
        } else {
          emit(OrderLoaded(
            orders: current.orders + orders,
            hasReachedMax: orders.length < 15,
            date: current.date,
          ));
        }
      }
    } catch (e) {
      emit(OrderFailure(error: e.toString()));
    } finally {
      _isFetching = false;
    }
  }
}
