import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mitrevels22/config/settings/settings.dart';
import 'package:mitrevels22/data/models/event_model.dart';
import 'package:mitrevels22/logic/router.dart';
import 'package:mitrevels22/ui/screens/EventsPage/EventPage.dart';
import 'package:mitrevels22/ui/widgets/loading.dart';

class EventDeep extends StatelessWidget {
  final Event? data;
  final String eventId;
  final RevelsAppState appState;
  const EventDeep({
    Key? key,
    this.data,
    required this.eventId,
    required this.appState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data == null
          ? FutureBuilder<Response>(
              future: Dio().post(
                baseUrl + '/api/user/event/getbyid',
                data: jsonEncode({'event_Id': eventId}),
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error while fetching event',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    final event = Event.fromJson(snapshot.data?.data['data']);
                    return EventCustomPage(
                      data: event,
                      appState: appState,
                    );
                  }
                }
                return Center(
                  child: loading(context),
                );
              },
            )
          : EventCustomPage(
              data: data!,
              appState: appState,
            ),
    );
  }
}
