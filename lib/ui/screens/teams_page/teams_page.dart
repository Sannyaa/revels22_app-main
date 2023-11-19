import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mitrevels22/logic/blocs/teams/bloc/teams_bloc.dart';
import 'package:mitrevels22/ui/screens/teams_page/team_button.dart';

import '../../../logic/blocs/teams/bloc/teams_bloc.dart';
import 'constants.dart';
import 'create_team_page.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key}) : super(key: key);

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  final TeamsBloc teamsBloc = TeamsBloc();
  final TextStyle buttonText =
      GoogleFonts.cabin(fontSize: 25, fontWeight: FontWeight.w600);

  final TextStyle hintStyle = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.4),
  );

  int joinedTeams = 0;

  void displayBottomSheet(BuildContext context, String title) {
    final height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      backgroundColor: Constants.bottomSheetColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Constants.bottomSheetRadius,
            topRight: Constants.bottomSheetRadius),
      ),
      context: context,
      builder: (context) => ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: height / 3, minHeight: height / 3 - 30),
        child: Container(
          alignment: Alignment.center,
          child: Text(title),
        ),
      ),
    );
  }

  Future<String> joinTeam(BuildContext buildContext) async {
    final TeamsBloc teamsBloc = TeamsBloc();
    bool _submitted = false;
    TextEditingController teamIdController = TextEditingController();
    TextEditingController eventIdController = TextEditingController();
    String res = await showDialog(
          barrierColor: Constants.barrierColor,
          context: buildContext,
          builder: (context) =>
              StatefulBuilder(builder: (context, StateSetter setState) {
            return ValueListenableBuilder(
              valueListenable: teamIdController,
              builder: (context, _, __) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: Constants.bgColor,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                        controller: eventIdController,
                        decoration: InputDecoration(
                          hintText: 'Event ID',
                          hintStyle: GoogleFonts.montserrat(
                              fontSize: 18, fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          errorText: !_submitted
                              ? null
                              : teamIdController.value.text.isEmpty
                                  ? 'Team code cannot be empty.'
                                  : null,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                        onSubmitted: (eventID) =>
                            eventIdController.text = eventID,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextField(
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                        controller: teamIdController,
                        decoration: InputDecoration(
                          hintText: 'Team Code',
                          hintStyle: GoogleFonts.montserrat(
                              fontSize: 18, fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          errorText: !_submitted
                              ? null
                              : teamIdController.value.text.isEmpty
                                  ? 'Team code cannot be empty.'
                                  : null,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                        onSubmitted: (teamCode) =>
                            teamIdController.text = teamCode,
                      ),
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                    child: NeumorphicButton(
                      onPressed: () {
                        teamsBloc.add(TeamsJoin(teamIdController.text,
                            buildContext, int.parse(eventIdController.text)));
                        Navigator.of(context).pop();
                      },
                      style: NeumorphicStyle(
                        depth: 4,
                        shadowDarkColor: Colors.black,
                        shadowLightColor: const Color(0xFF454954),
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "JOIN",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cabin(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff16B694)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ) ??
        '';
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Theme(
        data: ThemeData.dark(),
        child: Scaffold(
          backgroundColor: Constants.bgColor,
          body: BlocBuilder<TeamsBloc, TeamsState>(
            bloc: teamsBloc..add(TeamsInit()),
            builder: (context, state) {
              print(state);
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: kToolbarHeight),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(0.0),
                            padding: const EdgeInsets.only(bottom: 10.0),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Constants.underlineColor, width: 1),
                              ),
                            ),
                            child: Text('Teams',
                                style: GoogleFonts.cabin(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                          ),
                          const SizedBox(height: 70),
                          Center(
                            child: NeumorphicButton(
                              onPressed: () async {
                                joinTeam(context);
                              },
                              style: NeumorphicStyle(
                                depth: 4,
                                shadowDarkColor: Colors.black,
                                shadowLightColor: const Color(0xFF454954),
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(8)),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                padding: const EdgeInsets.all(13),
                                child: Text(
                                  "Join Team",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cabin(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          NeumorphicButton(
                            onPressed: () {
                              if (state is TeamsLoaded)
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        CreateTeamPage(
                                      teamsBloc: teamsBloc,
                                      teamList: (state).teamList,
                                    ),
                                  ),
                                );
                            },
                            style: NeumorphicStyle(
                              depth: 4,
                              shadowDarkColor: Colors.black,
                              shadowLightColor: const Color(0xFF454954),
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(8)),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.55,
                              padding: const EdgeInsets.all(13),
                              child: Text(
                                "Create Team",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cabin(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (!(MediaQuery.of(context).viewInsets.bottom > 100))
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: height / 3,
                              minHeight: height / 3 - 30,
                              minWidth: width),
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Constants.bottomSheetRadius,
                                    topRight: Constants.bottomSheetRadius),
                                color: Constants.bottomSheetColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 25),
                                  child: Text(
                                    'Current Teams',
                                    style: GoogleFonts.cabin(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: width,
                                      maxHeight: 100,
                                      minWidth: width - 30),
                                  child: !(state is TeamsLoaded) ||
                                          (state).teamList.isEmpty
                                      ? (state is TeamsLoading)
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : Center(
                                              child: Text(
                                                'You are currently not part of a team.\nJoin or Create one now.',
                                                style: GoogleFonts.cabin(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                      : ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, i) => Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 10,
                                                ),
                                                child: TeamButton(
                                                  team: state.teamList[i],
                                                  teamsBloc: teamsBloc,
                                                ),
                                              ),
                                          separatorBuilder: (context, i) =>
                                              const SizedBox(
                                                width: 2,
                                              ),
                                          itemCount: state.teamList.length),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
