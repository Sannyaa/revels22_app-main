import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitrevels22/data/models/team_model.dart';
import 'package:mitrevels22/logic/blocs/teams/bloc/teams_bloc.dart';
import 'constants.dart';

class TeamDetailDialog extends StatelessWidget {
  final Team team;
  final TeamsBloc teamsBloc;
  TeamDetailDialog({Key? key, required this.team, required this.teamsBloc})
      : super(key: key);
  final TextStyle leaveButtonStyle = GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  final TextStyle titleStyle = GoogleFonts.montserrat(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  final TextStyle subTitleStyle = GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.7),
  );
  final TextStyle memberStyle = GoogleFonts.cabin(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  final TextStyle teamCodeStyle = GoogleFonts.cabin(
    color: Color.fromRGBO(22, 182, 148, 1),
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  Widget buildMemberTile(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          team.members[index].name,
          style: memberStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //TODO: remove the delete icon if created by = team member id
            NeumorphicButton(
              padding: EdgeInsets.all(8),
              style: const NeumorphicStyle(
                depth: 2,
                shape: NeumorphicShape.flat,
                shadowDarkColor: Colors.black,
                shadowLightColor: Color(0xFF454954),
              ),
              child: Container(
                child: Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red,
                  size: 18,
                ),
              ),
              onPressed: () {
                //delete member from team
              },
            ),
            Text(
              '#${team.members[index].userID}',
              style: teamCodeStyle,
            ),
          ],
        )
      ],
    );
  }

  Widget buildPendingMemberTile(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          team.requestedMembers[index].name,
          style: memberStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NeumorphicButton(
                padding: EdgeInsets.all(8),
                style: const NeumorphicStyle(
                  depth: 2,
                  shape: NeumorphicShape.flat,
                  shadowDarkColor: Colors.black,
                  shadowLightColor: Color(0xFF454954),
                ),
                child: Container(
                  child: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                    size: 18,
                  ),
                ),
                onPressed: () {
                  //decline request
                },
              ),
            ),
            NeumorphicButton(
              padding: EdgeInsets.all(8),
              style: const NeumorphicStyle(
                depth: 2,
                shape: NeumorphicShape.flat,
                shadowDarkColor: Colors.black,
                shadowLightColor: Color(0xFF454954),
              ),
              child: Container(
                child: Icon(
                  Icons.check,
                  color: Color.fromRGBO(22, 182, 148, 1),
                  size: 18,
                ),
              ),
              onPressed: () {
                //Add to Team
              },
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool pendingRequests = team.requestedMembers.isNotEmpty;
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Constants.bgColor,
      title: Column(
        children: [
          Text(
            team.event.name,
            style: GoogleFonts.montserrat(
                fontSize: 30, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            team.teamID,
            style: subTitleStyle,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int index = 0; index < team.members.length; index++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: buildMemberTile(index),
            ),
          if (pendingRequests)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Pending Requests',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          for (int index = 0; index < team.requestedMembers.length; index++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: buildPendingMemberTile(index),
            ),
        ],
      ),
      actions: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 30),
            child: NeumorphicButton(
              style: NeumorphicStyle(
                depth: 4,
                shadowDarkColor: Colors.black,
                shadowLightColor: Color(0xFF454954),
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
              ),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Leave',
                  textAlign: TextAlign.center,
                  style: leaveButtonStyle,
                ),
              ]),
              onPressed: () {
                teamsBloc.add(TeamsLeave(team.teamID));
                Navigator.of(context).pop();
              },
            ),
          ),
        )
      ],
    );
  }
}
