import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mitrevels22/data/models/event_model.dart';
import 'package:mitrevels22/logic/blocs/events/bloc/events_bloc.dart';
import 'package:mitrevels22/logic/cubits/user_data/cubit/user_data_cubit.dart';
import 'package:mitrevels22/logic/router.dart';
import 'package:mitrevels22/ui/widgets/loading.dart';
import 'event_tile.dart';

class EventsScreen extends StatefulWidget {
  final RevelsAppState appState;
  const EventsScreen({Key? key, required this.appState}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
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
    return SafeArea(
      child: BlocBuilder<EventsBloc, EventsState>(
        builder: (context, state) {
          if (state is EventsLoading) {
            return loading(context);
          }
          if (state is EventsLoadSuccess) {
            List<Event> events;
            if (state.selectedCategories.isNotEmpty) {
              events = List<Event>.from(state.events)
                ..retainWhere((element) =>
                    state.selectedCategories.contains(element.category));
            } else {
              events = state.events;
            }

            return Scaffold(
              backgroundColor: const Color(0xFF21242B),
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: Text(
                  "Events",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                backgroundColor: const Color(0xFF1B1D23),
                centerTitle: true,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(75),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    scrollDirection: Axis.horizontal,
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          NeumorphicButton(
                            minDistance: -4,
                            margin: const EdgeInsets.all(8),
                            onPressed: state.selectedCategories.isNotEmpty
                                ? () {
                                    context
                                        .read<EventsBloc>()
                                        .add(ClearFilterEvent());
                                  }
                                : null,
                            style: NeumorphicStyle(
                              color: const Color(0xff576075),
                            ),
                            child: Text(
                              'All',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          VerticalDivider(
                            thickness: 2,
                          ),
                          ...state.allCategories.map(
                            (e) => NeumorphicButton(
                              minDistance: -4,
                              onPressed: () {
                                context
                                    .read<EventsBloc>()
                                    .add(EventFilterEvent(category: e));
                              },
                              style: NeumorphicStyle(
                                color: const Color(0xff576075),
                                depth: state.selectedCategories.contains(e)
                                    ? -4
                                    : 4,
                              ),
                              margin: const EdgeInsets.all(8),
                              child: Text(
                                e.category,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: events.isEmpty
                  ? Center(
                      child: Text(
                        'No events found!',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : AnimationLimiter(
                      child: ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: NeumorphicEventTile(
                                  data: events[index],
                                  appState: widget.appState,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            );
          }
          if (state is EventsLoadFailure) {
            return Center(
              child: Text(
                "Error while loading events",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
