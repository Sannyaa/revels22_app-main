import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:intl/intl.dart';
import 'package:mitrevels22/logic/blocs/events/bloc/events_bloc.dart';
import 'package:mitrevels22/logic/cubits/user_data/cubit/user_data_cubit.dart';

import 'package:mitrevels22/logic/router.dart';
import 'package:mitrevels22/ui/screens/unknown_page.dart';
import 'package:mitrevels22/ui/widgets/loading.dart';
import 'events_list.dart';

class SchedulePage extends StatefulWidget {
  final RevelsAppState appState;
  const SchedulePage({Key? key, required this.appState}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final Box likedEventsBox = Hive.box('liked_events');
  bool showLikedEvents = false;

  @override
  void initState() {
    super.initState();
    context.read<EventsBloc>().add(EventsFetchEvent());
    if (widget.appState.token != null) {
      context.read<UserDataCubit>().getRegisteredEvents(widget.appState.token!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(builder: (context, state) {
      if (state is EventsLoading) {
        return loading(context);
      }
      if (state is EventsLoadFailure) {
        return UnknownPage();
      }
      if (state is EventsLoadSuccess) {
        return DefaultTabController(
          initialIndex: DateTime.now().difference(state.firstDate).inDays < 0
              ? 0
              : DateTime.now().difference(state.firstDate).inDays,
          length: state.lastDate.difference(state.firstDate).inDays + 1,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF21242B),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      showLikedEvents = !showLikedEvents;
                    });
                  },
                  icon: showLikedEvents
                      ? const FaIcon(
                          FontAwesomeIcons.solidHeart,
                          color: Colors.pink,
                        )
                      : const FaIcon(
                          FontAwesomeIcons.heart,
                          color: Colors.white,
                        ),
                ),
              ],
              centerTitle: true,
              title: Text(
                "Schedule",
                style: GoogleFonts.cabin(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
              ),
              bottom: TabBar(
                isScrollable: true,
                indicator: BoxDecoration(
                  color: Color(0xff4E5565),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                tabs: List<Tab>.generate(
                    state.lastDate.day - state.firstDate.day + 1, (index) {
                  return Tab(
                    text: (index + state.firstDate.day).toString(),
                    icon: Text(
                      DateFormat.E().format(
                        DateTime(2022, 4, index + state.firstDate.day),
                      ),
                      style: GoogleFonts.cabin(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            backgroundColor: const Color(0xFF21242B),
            body: SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: List<EventsList>.generate(
                        state.lastDate.day - state.firstDate.day + 1,
                        (index) => EventsList(
                          data: showLikedEvents
                              ? state.events
                                  .where((element) =>
                                      element.eventDateTime != null
                                          ? element.eventDateTime!.day ==
                                              state.firstDate.day + index
                                          : false)
                                  .where((element) =>
                                      likedEventsBox.containsKey(element.id))
                                  .toList()
                              : state.events
                                  .where((element) =>
                                      element.eventDateTime != null
                                          ? element.eventDateTime!.day ==
                                              state.firstDate.day + index
                                          : false)
                                  .toList(),
                          appState: widget.appState,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
      return Container();
    });
  }
}
