import 'dart:convert';

import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mitrevels22/data/models/category_model.dart';
import 'package:mitrevels22/data/models/event_model.dart';
import 'package:mitrevels22/data/repositories/event_repository.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends HydratedBloc<EventsEvent, EventsState> {
  EventRepository eventRepository = EventRepository();

  static DateTime _getDate(Map<String, dynamic> data) {
    List<Event> events = data['events'] as List<Event>;
    bool first = data['first'] as bool;
    if (first) {
      return events.fold<DateTime>(
          DateTime(2022, 4, 9),
          (previousValue, element) => element.eventDateTime != null
              ? element.eventDateTime!.day < previousValue.day
                  ? element.eventDateTime!
                  : previousValue
              : previousValue);
    } else {
      return events.fold<DateTime>(
          DateTime(2022, 4, 16),
          (previousValue, element) => element.eventDateTime != null
              ? element.eventDateTime!.day > previousValue.day
                  ? element.eventDateTime!
                  : previousValue
              : previousValue);
    }
  }

  EventsBloc() : super(EventsInitial()) {
    on<EventsFetchEvent>((event, emit) async {
      if (state is! EventsLoadSuccess) {
        emit(EventsLoading());
      }
      final _asyncMemoizer = AsyncMemoizer<List<Event>?>();
      final events = await _asyncMemoizer
          .runOnce(() => eventRepository.getAllEventsFunc());
      if (events == null) {
        return emit(EventsLoadFailure());
      }
      final allCategories = events.map((e) => e.category!).toSet().toList();
      final firstDay =
          await compute(_getDate, {'first': true, 'events': events});
      final lastDay =
          await compute(_getDate, {'first': false, 'events': events});
      return emit(
        EventsLoadSuccess(
          events: events,
          allCategories: allCategories,
          selectedCategories: <Category>[],
          firstDate: firstDay,
          lastDate: lastDay,
        ),
      );
    });

    on<EventFilterEvent>((event, emit) {
      if (state is EventsLoadSuccess) {
        final selectedCategories = List<Category>.from(
            (state as EventsLoadSuccess).selectedCategories);
        if (selectedCategories.contains(event.category)) {
          selectedCategories.remove(event.category);
        } else {
          selectedCategories.add(event.category);
        }
        return emit(
          EventsLoadSuccess(
            events: (state as EventsLoadSuccess).events,
            allCategories: (state as EventsLoadSuccess).allCategories,
            selectedCategories: selectedCategories,
            firstDate: (state as EventsLoadSuccess).firstDate,
            lastDate: (state as EventsLoadSuccess).lastDate,
          ),
        );
      }
    });

    on<ClearFilterEvent>((event, emit) {
      if (state is EventsLoadSuccess) {
        return emit(
          EventsLoadSuccess(
            events: (state as EventsLoadSuccess).events,
            allCategories: (state as EventsLoadSuccess).allCategories,
            selectedCategories: <Category>[],
            firstDate: (state as EventsLoadSuccess).firstDate,
            lastDate: (state as EventsLoadSuccess).lastDate,
          ),
        );
      }
    });
  }

  @override
  Map<String, dynamic>? toJson(EventsState state) {
    if (state is EventsLoadSuccess) {
      return {
        'events': jsonEncode(state.events),
        'allCategories':
            jsonEncode(state.allCategories.map((e) => e.toJson()).toList()),
        'firstDate': state.firstDate.toIso8601String(),
        'lastDate': state.lastDate.toIso8601String(),
      };
    }
    return null;
  }

  @override
  EventsState? fromJson(Map<String, dynamic> json) {
    if (json.containsKey('events')) {
      final events = jsonDecode(json['events'] as String)
          .map<Event>((e) => Event.fromJson(e))
          .toList();
      final allCategories = jsonDecode(json['allCategories'] as String)
          .map<Category>((e) => Category.fromJson(e))
          .toList();
      final firstDate = DateTime.parse(json['firstDate'] as String);
      final lastDate = DateTime.parse(json['lastDate'] as String);
      return EventsLoadSuccess(
        events: events,
        allCategories: allCategories,
        selectedCategories: <Category>[],
        firstDate: firstDate,
        lastDate: lastDate,
      );
    }
    return null;
  }
}
