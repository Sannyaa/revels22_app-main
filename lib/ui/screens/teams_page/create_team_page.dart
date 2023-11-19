import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mitrevels22/logic/blocs/teams/bloc/teams_bloc.dart';
import 'package:mitrevels22/ui/screens/teams_page/scan_qr_page.dart';

import '../../../data/models/team_model.dart';
import 'constants.dart';

class CreateTeamPage extends StatefulWidget {
  final List<Team> teamList;
  final TeamsBloc teamsBloc;
  const CreateTeamPage(
      {Key? key, required this.teamList, required this.teamsBloc})
      : super(key: key);

  @override
  State<CreateTeamPage> createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  final TextStyle buttonText =
      GoogleFonts.cabin(fontSize: 25, fontWeight: FontWeight.w600);

  final TextStyle titleText = GoogleFonts.montserrat(
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );

  final TextStyle hintStyle = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.4),
  );

  bool usingQr = false;

  int _groupValue = 0;
  int membersAdded = 0;
  String userId = '';
  bool _showError = false;

  Widget _buildRadios() {
    return SizedBox(
      height: 200,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              widget.teamList.length,
              (index) => buildEventTile(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEventTile(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: NeumorphicRadio(
            style: const NeumorphicRadioStyle(
                selectedColor: Color(0xff16B694),
                unselectedDepth: 4,
                selectedDepth: -2,
                boxShape: NeumorphicBoxShape.circle()),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 35, minWidth: 35),
            ),
            value: index,
            groupValue: _groupValue,
            onChanged: (_) {
              setState(() {
                _groupValue = index;
              });
            },
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Text(
            widget.teamList[index].event.name,
            style: GoogleFonts.cabin(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildMemberAddedTile(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          NeumorphicRadio(
            style: Constants.elevatedNeumorphicRadio,
            child: const Icon(
              Icons.done,
              color: Colors.green,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Member ${index + 1} added',
            style: hintStyle.copyWith(
                color: Colors.white.withOpacity(0.6), fontSize: 15.0),
          ),
        ],
      ),
    );
  }

  TextEditingController controller = TextEditingController();
  Widget _buildAddMemberTile() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(),
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 70,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
              onChanged: (x) => setState(() {
                userId = x;
              }),
              onSubmitted: (x) => setState(() {
                userId = x;
              }),
              decoration: InputDecoration(
                hintText: 'User ID',
                hintStyle: hintStyle,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                widget.teamsBloc.add(TeamsAdd(
                    controller.text,
                    widget.teamList[_groupValue].teamID,
                    widget.teamList[_groupValue].event.eventID,
                    context));
              },
              child: Text(
                'Add',
                style: GoogleFonts.cabin(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.white),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final joinButtonStyle = GoogleFonts.montserrat(
      color: const Color.fromRGBO(22, 182, 148, 1),
      fontSize: 25,
      fontWeight: FontWeight.w600,
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.bgColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: kToolbarHeight),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: BackButton(
                  color: Colors.white,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create Team',
                        style: GoogleFonts.montserrat(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    const SizedBox(height: 30),
                    Text(
                      'Select an Event',
                      style: GoogleFonts.cabin(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.7)),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    _buildRadios(),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: height / 2.5,
                      minHeight: height / 2.5 - 30,
                      minWidth: width),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Constants.bottomSheetRadius,
                            topRight: Constants.bottomSheetRadius),
                        color: Constants.bottomSheetColor),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 30.0, bottom: 15.0),
                            child: Text(
                              'Add Members',
                              style: buttonText.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 70, maxHeight: 80),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      // setState(() {
                                      //   usingQr = true;
                                      // });
                                      final result = Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ScanQrPage()),
                                      );
                                      Fluttertoast.showToast(msg: '$result');
                                    },
                                    child: Text(
                                      'Scan QR',
                                      style: joinButtonStyle,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 70,
                                  child: VerticalDivider(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 20,
                                    thickness: 1,
                                    indent: 20,
                                    endIndent: 10,
                                  ),
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        usingQr = false;
                                      });
                                    },
                                    child: Text(
                                      'Enter ID',
                                      style: joinButtonStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ...List.generate(membersAdded,
                              (index) => _buildMemberAddedTile(index)),
                          const SizedBox(
                            height: 10,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: width,
                                maxHeight: 100,
                                minWidth: width - 30),
                            child:
                                !usingQr ? _buildAddMemberTile() : Text('qr'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
