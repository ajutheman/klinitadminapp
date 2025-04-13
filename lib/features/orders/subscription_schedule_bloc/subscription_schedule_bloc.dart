import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/subscription_schedule_model.dart';
import '../subscription_schedule_repository.dart';

// import '../repository/subscription_schedule_repository.dart';

part 'subscription_schedule_event.dart';
part 'subscription_schedule_state.dart';

class SubscriptionScheduleBloc
    extends Bloc<SubscriptionScheduleEvent, SubscriptionScheduleState> {
  final SubscriptionScheduleRepository repository;

  SubscriptionScheduleBloc(this.repository)
      : super(SubscriptionScheduleInitial()) {
    on<FetchSubscriptionSchedules>(_onFetchSchedules);
    on<AssignScheduleEmployee>(_onAssignEmployee);
    on<RemoveScheduleEmployee>(_onRemoveEmployee);
  }

  Future<void> _onFetchSchedules(
      FetchSubscriptionSchedules event, Emitter emit) async {
    emit(SubscriptionScheduleLoading());
    try {
      final schedules = await repository.getSchedules(event.date);
      emit(SubscriptionScheduleLoaded(schedules: schedules));
    } catch (e) {
      emit(SubscriptionScheduleError("Failed to load schedules: $e"));
    }
  }

  Future<void> _onAssignEmployee(
      AssignScheduleEmployee event, Emitter emit) async {
    try {
      await repository.assignEmployee(
        scheduleId: event.scheduleId,
        employeeId: event.employeeId,
        date:
            // workDate:
            event.workDate,
        day:
            // dayOfWeek:
            event.dayOfWeek,
      );
      emit(ScheduleEmployeeAssigned());
      add(FetchSubscriptionSchedules(event.workDate));

      // add(FetchSubscriptionSchedules(event.workDate)); // reload after assignment
    } catch (e) {
      emit(SubscriptionScheduleError("Failed to assign employee: $e"));
    }
  }

  Future<void> _onRemoveEmployee(
      RemoveScheduleEmployee event, Emitter emit) async {
    try {
      await repository.removeAssignment(event.assignmentId);
      emit(ScheduleEmployeeRemoved());
      add(FetchSubscriptionSchedules(event.date)); // reload after removal
    } catch (e) {
      emit(SubscriptionScheduleError("Failed to remove employee: $e"));
    }
  }
}
