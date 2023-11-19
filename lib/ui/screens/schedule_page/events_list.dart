import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:mitrevels22/logic/router.dart';

import '../../../data/models/event_model.dart';
import 'event_tile.dart';

class EventsList extends StatelessWidget {
  final List<Event> data;

  final RevelsAppState appState;
  const EventsList({
    Key? key,
    required this.data,
    required this.appState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
        child: ListView.builder(
      itemBuilder: (context, index) {
        int colorIndex = index % 4;

        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            child: FadeInAnimation(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: EventTile(
                  data: data[index],
                  colorIndex: colorIndex,
                  appState: appState,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: data.length,
    ));
  }
}
