import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitrevels22/config/apis/event_apis.dart';
import 'package:mitrevels22/config/apis/team_apis.dart';
import 'package:mitrevels22/data/models/event_model.dart';
import 'package:mitrevels22/data/models/team_model.dart';

part 'teams_event.dart';
part 'teams_state.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  final storage = const FlutterSecureStorage();
  List<Team> teamList = [];
  TeamsBloc() : super(TeamsLoading()) {
    on<TeamsInit>((event, emit) async {
      String? token = await storage.read(key: "token");
      teamList = [];
      if (token != null) {
        // try {
          var res = await Dio().get(viewRegisteredEvent(),
              options: Options(headers: {"authorization": token}));

          for (var data in res.data["data"]) {
            // data["event"]["delegateCards"] = [];
            // data["event"]["pendingDelegateCards"] = [];
            data["event"]["category"] = null;
            print(data["event"]);
            print(data["members"]);
            print(data["teamID"]);
            // print(Event.fromJson(data["event"]));
            Team teamData = Team.fromJson(data);
            teamList.add(teamData);
          }
        // }
        //  catch (e) {
        //   print(e);
        // }
      }
      print("Teams loaded");
      emit(TeamsLoaded(teamList));
    });

    on<TeamsJoin>((event, emit) async {
      String? token = await storage.read(key: "token");

      try {
        if (token != null) {
          var response = await Dio().post(joinTeam(),
              data: {"eventID": event.eventId, "teamID": event.teamId},
              options: Options(headers: {"authorization": token}));
          print(response);
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(event.context).showMaterialBanner(
              MaterialBanner(
                elevation: 4,
                contentTextStyle: GoogleFonts.cabin(color: Colors.white),
                content: const Text("Team Joined!!"),
                backgroundColor: NeumorphicTheme.baseColor(event.context),
                actions: [
                  TextButton(
                    onPressed: () => ScaffoldMessenger.of(event.context)
                        .hideCurrentMaterialBanner(),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          } else {
            ScaffoldMessenger.of(event.context).showMaterialBanner(
              MaterialBanner(
                elevation: 4,
                contentTextStyle: GoogleFonts.cabin(color: Colors.white),
                content: Text(response.data["msg"]),
                backgroundColor: NeumorphicTheme.baseColor(event.context),
                actions: [
                  TextButton(
                    onPressed: () => ScaffoldMessenger.of(event.context)
                        .hideCurrentMaterialBanner(),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          }
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(event.context).showMaterialBanner(
          MaterialBanner(
            elevation: 4,
            contentTextStyle: GoogleFonts.cabin(color: Colors.white),
            content: Text("Failed to join the team. Try again later."),
            backgroundColor: NeumorphicTheme.baseColor(event.context),
            actions: [
              TextButton(
                onPressed: () => ScaffoldMessenger.of(event.context)
                    .hideCurrentMaterialBanner(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    });

    on<TeamsLeave>((event, emit) async {
      emit(TeamsLoading());
      String? token = await storage.read(key: "token");
      if (!event.teamId.isEmpty && token != null) {
        try {
          var res = await Dio().post(leaveTeam(),
              data: {"teamID": event.teamId},
              options: Options(headers: {"authorization": token}));

          if (res.statusCode == 200) {
            add(TeamsInit());
          }
        } catch (e) {
          print(e);
        }
      }
    });

    on<TeamsAdd>((event, emit) async {
      print("Started member adding");
      emit(TeamsLoading());
      String? token = await storage.read(key: "token");
      if (!event.teamID.isEmpty && !event.userID.isEmpty && token != null) {
        try {
          var res = await Dio().post(addToTeam(),
              data: {
                "teamID": event.teamID,
                "userID": event.userID,
                "eventID": event.eventID
              },
              options: Options(headers: {"authorization": token}));
          print(res.data);
          if (res.statusCode == 200) {
            ScaffoldMessenger.of(event.context).showMaterialBanner(
              MaterialBanner(
                elevation: 4,
                contentTextStyle: GoogleFonts.cabin(color: Colors.white),
                content: Text("Added to the team"),
                backgroundColor: NeumorphicTheme.baseColor(event.context),
                actions: [
                  TextButton(
                    onPressed: () => ScaffoldMessenger.of(event.context)
                        .hideCurrentMaterialBanner(),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
            add(TeamsInit());
          }
        } catch (e) {
          ScaffoldMessenger.of(event.context).showMaterialBanner(
            MaterialBanner(
              elevation: 4,
              contentTextStyle: GoogleFonts.cabin(color: Colors.white),
              content: Text("Failed to add member!!"),
              backgroundColor: NeumorphicTheme.baseColor(event.context),
              actions: [
                TextButton(
                  onPressed: () => ScaffoldMessenger.of(event.context)
                      .hideCurrentMaterialBanner(),
                  child: const Text("OK"),
                ),
              ],
            ),
          );
          print(e);
        }
      }
    });
  }
}
