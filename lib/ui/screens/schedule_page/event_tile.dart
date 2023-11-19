import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitrevels22/data/models/event_model.dart';
import 'package:intl/intl.dart';
import 'package:mitrevels22/logic/router.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EventTile extends StatefulWidget {
  final RevelsAppState appState;
  final DateFormat dateFormat = DateFormat("HH:mm a");
  final Event data;
  EventTile({
    Key? key,
    required this.colorIndex,
    required this.data,
    required this.appState,
  }) : super(key: key);
  final int colorIndex;
  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  List<Color> lineColors = const [
    Color(0xFF16B694),
    Color(0xFFFADC50),
    Color(0xFFE9436F),
    Color(0xFF4382BB),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: NeumorphicButton(
        padding: EdgeInsets.only(top: 15, bottom: 10, left: 10),
        onPressed: () {
          widget.appState.event = widget.data;
          widget.appState.eventId = widget.data.id;
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    20,
                  ),
                ),
                child: VerticalDivider(
                  color: lineColors[widget.colorIndex],
                  thickness: 8,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.name,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.clock,
                                  color: Colors.white54,
                                  size: 13,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.data.eventDateTime != null
                                      ? DateFormat.jm()
                                          .format(widget.data.eventDateTime!)
                                      : "4:00 PM",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Image.asset(
                                    'assets/Picture 1.png',
                                    width: 14,
                                    height: 14,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.data.eventVenue != null &&
                                            widget.data.eventVenue!.length > 0
                                        ? "${widget.data.eventVenue![0].toUpperCase()}"
                                            "${widget.data.eventVenue!.substring(1).toLowerCase()}"
                                        : "Location",
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: IconButton(
                  onPressed: () {
                    Hive.box('liked_events').get(widget.data.id) == null
                        ? Hive.box('liked_events').put(widget.data.id, true)
                        : Hive.box('liked_events').delete(widget.data.id);
                  },
                  icon: ValueListenableBuilder<Box>(
                    valueListenable: Hive.box('liked_events').listenable(),
                    builder: (context, box, widge) =>
                        box.get(widget.data.id) != null &&
                                box.get(widget.data.id) == true
                            ? const FaIcon(
                                FontAwesomeIcons.solidHeart,
                                color: Colors.pink,
                              )
                            : const FaIcon(
                                FontAwesomeIcons.heart,
                                color: Colors.white,
                              ),
                  ),
                ),
              ),
            ],
          ),
        ),
        style: NeumorphicStyle(
          depth: 4,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
          shadowDarkColor: Colors.black,
          shadowLightColor: const Color(0xFF454954),
          color: const Color(0xFF21242B),
        ),
      ),
    );
  }
}
