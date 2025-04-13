part of 'subscription_schedule_bloc.dart';

abstract class SubscriptionScheduleEvent extends Equatable {
  const SubscriptionScheduleEvent();

  @override
  List<Object?> get props => [];
}

class FetchSubscriptionSchedules extends SubscriptionScheduleEvent {
  final String date; // format: "yyyy-MM-dd"

  const FetchSubscriptionSchedules(this.date);

  @override
  List<Object> get props => [date];
}

class AssignScheduleEmployee extends SubscriptionScheduleEvent {
  final int scheduleId;
  final int employeeId;
  final String workDate; // format: "yyyy-MM-dd"
  final String dayOfWeek;

  const AssignScheduleEmployee({
    required this.scheduleId,
    required this.employeeId,
    required this.workDate,
    required this.dayOfWeek,
  });

  @override
  List<Object> get props => [scheduleId, employeeId, workDate, dayOfWeek];
}

class RemoveScheduleEmployee extends SubscriptionScheduleEvent {
  final int assignmentId;
  final String date;

  const RemoveScheduleEmployee(
      {required this.assignmentId, required this.date});

  @override
  List<Object> get props => [assignmentId, date];
}
