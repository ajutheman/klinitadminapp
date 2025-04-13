import 'package:flutter_bloc/flutter_bloc.dart';

// import '../repository/order_repository.dart';
import '../order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  int currentPage = 1;
  bool isFetching = false;

  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<FetchOrders>((event, emit) async {
      if (isFetching) return;
      isFetching = true;
      try {
        if (state is OrderInitial) {
          final orders = await orderRepository.fetchOrders(page: currentPage);
          emit(OrderLoaded(orders: orders, hasReachedMax: orders.isEmpty));
        } else if (state is OrderLoaded) {
          final currentState = state as OrderLoaded;
          final orders = await orderRepository.fetchOrders(page: currentPage);
          if (orders.isEmpty) {
            emit(currentState.copyWith(hasReachedMax: true));
          } else {
            emit(OrderLoaded(
              orders: currentState.orders + orders,
              hasReachedMax: false,
            ));
          }
        }
        currentPage++;
      } catch (e) {
        emit(OrderFailure(error: e.toString()));
      } finally {
        isFetching = false;
      }
    });
  }
}
