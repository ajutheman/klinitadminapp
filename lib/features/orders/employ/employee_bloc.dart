import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../employee_repository.dart';
import '../models/employee_model.dart';

// import 'employee_model.dart';
// import 'employee_repository.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository repository;

  EmployeeBloc(this.repository) : super(EmployeeLoading()) {
    on<LoadEmployees>((event, emit) async {
      emit(EmployeeLoading());
      try {
        final employees = await repository.fetchEmployees();
        emit(EmployeeLoaded(employees));
      } catch (e) {
        emit(EmployeeError(e.toString()));
      }
    });

    on<AssignEmployees>((event, emit) async {
      try {
        await repository.assignEmployees(event.orderId, event.employeeIds);
        emit(EmployeeAssigned());
      } catch (e) {
        emit(EmployeeError("Assignment Failed: ${e.toString()}"));
      }
    });
  }
}
