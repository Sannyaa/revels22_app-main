import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitrevels22/data/models/team_model.dart';
import 'package:mitrevels22/logic/blocs/teams/bloc/teams_bloc.dart';
import 'team_detail_dialog.dart';

import 'constants.dart';

class TeamButton extends StatelessWidget {
  final Team team;
  final TeamsBloc teamsBloc;
  TeamButton({Key? key, required this.team, required this.teamsBloc})
      : super(key: key);

  final TextStyle contentStyle =
      GoogleFonts.cabin(fontSize: 18, fontWeight: FontWeight.w600);
  final TextStyle subContentStyle =
      GoogleFonts.cabin(fontSize: 15, fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    return Badge(
      padding: EdgeInsets.all(8),
      badgeColor: Colors.red,
      //position: BadgePosition.topEnd(),
      badgeContent: Text(
        team.requestedMembers.length.toString(),
        style: TextStyle(color: Colors.white),
      ),
      child: NeumorphicButton(
        padding: EdgeInsets.zero,
        style: NeumorphicStyle(
          depth: 4,
          shadowDarkColor: Colors.black,
          shadowLightColor: const Color(0xFF454954),
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        ),
        onPressed: () async {
          bool res = await showDialog(
                useRootNavigator: false,
                context: context,
                builder: (context) => TeamDetailDialog(
                  team: team,
                  teamsBloc: teamsBloc,
                ),
              ) ??
              false;

          print('Res: $res');
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(123, 31, 246, 1),
              Color.fromRGBO(164, 86, 222, 1),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    team.event.name,
                    style: contentStyle,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '${team.members.length} ${team.members.length > 1 ? 'members' : 'member'}',
                      style: subContentStyle,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
