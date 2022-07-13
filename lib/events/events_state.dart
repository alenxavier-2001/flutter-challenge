part of 'events_bloc.dart';

@immutable
abstract class EventsState {}

class EventsInitial extends EventsState {}

class EventsLoading extends EventsState {}

class EventsFetchSuccess extends EventsState {
  final List<EventModel> eventlist;

  EventsFetchSuccess({required this.eventlist});
  @override
  List<Object> get props => [eventlist];
}

class EventsFetchFailed extends EventsState {
  final String message;

  EventsFetchFailed({required this.message});
  @override
  List<Object> get props => [message];
}
