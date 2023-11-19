import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitrevels22/config/constants/constants.dart';
import 'package:mitrevels22/logic/blocs/featured_events/bloc/featured_events_bloc.dart';
import 'package:mitrevels22/logic/router.dart';

import '../../widgets/featured_tile.dart';
import '../../widgets/loading.dart';

class FeaturedEvents extends StatefulWidget {
  final RevelsAppState appState;
  const FeaturedEvents({Key? key, required this.appState}) : super(key: key);

  @override
  State<FeaturedEvents> createState() => _FeaturedEventsState();
}

class _FeaturedEventsState extends State<FeaturedEvents> {
  Widget customTile(int index, FeaturedEventsLoaded state, bool fullWidth) {
    return FeaturedTile(
      fullWidth: fullWidth,
      categoryGradientOne: categoryColors[index % categoryColors.length]
          ["color1"],
      categoryGradientTwo: categoryColors[index % categoryColors.length]
          ["color2"],
      eventColor: categoryColors[index % categoryColors.length]["color2"],
      eventTitle: state.data[index].name,
      eventCategory: state.data[index].category != null
          ? state.data[index].category!.category
          : "CATEGORY",
      appState: widget.appState,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedEventsBloc, FeaturedEventsState>(
        builder: (context, state) {
      if (state is FeaturedEventsLoaded)
        return Scaffold(
          backgroundColor: Color(0xFF21242B),
          appBar: AppBar(
            title: Text(
              'Featured Events',
              style: GoogleFonts.cabin(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            centerTitle: true,
            backgroundColor: Color(0xFF21242B),
            shadowColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                customTile(0, state, true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    customTile(1, state, false),
                    customTile(2, state, false),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    customTile(3, state, false),
                    customTile(4, state, false),
                  ],
                ),
                customTile(5, state, true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    customTile(6, state, false),
                    customTile(7, state, false),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    customTile(8, state, false),
                    customTile(9, state, false),
                  ],
                ),
              ],
            ),
          ),
        );
      return loading(context);
    });
  }
}
