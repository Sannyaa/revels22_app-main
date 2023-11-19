import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mitrevels22/data/models/event_model.dart';
import 'package:mitrevels22/logic/router.dart';

class NeumorphicEventTile extends StatefulWidget {
  final Event data;
  final RevelsAppState appState;
  const NeumorphicEventTile({
    Key? key,
    required this.data,
    required this.appState,
  }) : super(key: key);

  @override
  State<NeumorphicEventTile> createState() => _NeumorphicEventTileState();
}

class _NeumorphicEventTileState extends State<NeumorphicEventTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(
            Icons.circle,
            color: Color(0xFFE9436F),
            size: 12,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: NeumorphicButton(
              minDistance: -4,
              onPressed: () {
                widget.appState.event = widget.data;
                widget.appState.eventId = widget.data.id;
              },
              child: EventTileCustom(
                data: widget.data,
              ),
              style: const NeumorphicStyle(
                depth: 4,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class EventTileCustom extends StatelessWidget {
  final Event data;

  const EventTileCustom({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Text(
                data.eventDateTime != null
                    ? data.eventDateTime!.day.toString()
                    : "",
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                data.eventDateTime != null
                    ? DateFormat.MMM().format(data.eventDateTime!)
                    : DateTime.april.toString(),
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 65,
          child: VerticalDivider(color: Colors.white),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: GoogleFonts.cabin(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data.category!.category,
                  style: GoogleFonts.cabin(
                    fontSize: 13,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
        ),
        NeumorphicIcon(
          Icons.arrow_forward_sharp,
          size: 25,
          style: const NeumorphicStyle(
            intensity: 0.5,
            depth: 1,
            lightSource: LightSource.topLeft,
            color: Color(0xFFE9436F),
          ),
        ),
      ],
    );
  }
}
