import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mitrevels22/data/models/team_model.dart';
import 'package:mitrevels22/data/repositories/event_repository.dart';
import 'package:mitrevels22/data/repositories/user_auth_repositories.dart';

part 'user_data_state.dart';

class UserDataCubit extends HydratedCubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());

  void getRegisteredEvents(String token) async {
    if (state is! UserEventsLoadSuccess) {
      emit(UserDataLoading());
    }
    try {
      final response = await UserRepository().getRegisteredEvents(token);
      if (response.statusCode == 200) {
        final bool success = response.data['success'];
        if (success) {
          final List<Team> events = response.data['data'].map<Team>((json) {
            json["event"]["category"] = null;
            return Team.fromJson(json);
          }).toList();
          return emit(UserEventsLoadSuccess(events: events));
        } else {
          return emit(
              UserEventsLoadFailure(message: "Error while fetching events"));
        }
      } else {
        return emit(
            UserEventsLoadFailure(message: "Error while fetching events"));
      }
    } catch (e) {
      return emit(
          UserEventsLoadFailure(message: "Error while fetching events"));
    }
  }

  void registerForEvent(String token, String eventId) async {
    emit(EventRegistrationLoading());
    final response =
        await EventRepository().registerEventMethod(token, eventId);
    if (response)
      return emit(EventRegistrationSuccess());
    else
      return emit(EventRegistrationFailure());
  }

  @override
  Map<String, dynamic>? toJson(UserDataState state) {
    if (state is UserEventsLoadSuccess) {
      return {
        'events': state.events.map((event) => jsonEncode(event)).toList(),
      };
    }
    return null;
  }

  @override
  UserDataState? fromJson(Map<String, dynamic> json) {
    if (json.containsKey('events')) {
      final List<dynamic> events = json['events'];
      final List<Team> teams =
          events.map((event) => Team.fromJson(event)).toList();
      return UserEventsLoadSuccess(events: teams);
    }
    return null;
  }
}
