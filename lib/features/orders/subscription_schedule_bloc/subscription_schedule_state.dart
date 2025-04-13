part of 'subscription_schedule_bloc.dart';

abstract class SubscriptionScheduleState extends Equatable {
  const SubscriptionScheduleState();

  @override
  List<Object?> get props => [];
}

class SubscriptionScheduleInitial extends SubscriptionScheduleState {}

class SubscriptionScheduleLoading extends SubscriptionScheduleState {}

class SubscriptionScheduleLoaded extends SubscriptionScheduleState {
  final List<SubscriptionSchedule> schedules;

  const SubscriptionScheduleLoaded({required this.schedules});

  @override
  List<Object> get props => [schedules];
}

class SubscriptionScheduleError extends SubscriptionScheduleState {
  final String message;

  const SubscriptionScheduleError(this.message);

  @override
  List<Object> get props => [message];
}

class ScheduleEmployeeAssigned extends SubscriptionScheduleState {}

class ScheduleEmployeeRemoved extends SubscriptionScheduleState {}
