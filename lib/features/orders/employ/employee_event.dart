part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadEmployees extends EmployeeEvent {}

class AssignEmployees extends EmployeeEvent {
  final int orderId;
  final List<int> employeeIds;

  AssignEmployees({required this.orderId, required this.employeeIds});

  @override
  List<Object?> get props => [orderId, employeeIds];
}
