import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:developer_challenge_schedule/services/api.dart';
import 'package:developer_challenge_schedule/models/eventmodel.dart';
import 'package:meta/meta.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(EventsLoading()) {
    List<EventModel> _list = <EventModel>[];
    SchedulerApi _api = SchedulerApi();

    on<EventsEvent>((event, emit) async {
      if (event is EventsFetchEvent) {
        try {
          List list = await _api.getSchedule();
          for (var element in list) {
            print(element);
            try {
              _list.add(EventModel.fromJson(element!));
            } catch (e) {
              log(e.toString());
            }
          }

          emit(EventsFetchSuccess(eventlist: _list));
        } catch (e) {
          emit(EventsFetchFailed(message: e.toString()));
        }
      }
    });
  }
}
