import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mitrevels22/data/models/event_model.dart';
import '../../config/apis/event_apis.dart';

class EventRepository {
  static List<Event> parseEvents(dynamic data) {
    return data.map<Event>((json) => Event.fromJson(json)).toList();
  }

  Future<List<Event>?> getAllEventsFunc() async {
    try {
      Response response = await Dio().get(viewAllEvents());
      if (response.statusCode == 200) {
        final events = await compute(parseEvents, response.data['data']);
        return events;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> registerEventMethod(String token, String eventID) async {
    try {
      Response response = await Dio().post(registerEvent(),
          data: {"eventID": eventID},
          options: Options(headers: {"authorization": token}));
      print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
