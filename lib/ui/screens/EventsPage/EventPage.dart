import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mitrevels22/config/enums/enums.dart';
import 'package:mitrevels22/data/models/event_model.dart';
import 'package:mitrevels22/logic/cubits/token/cubit/token_cubit.dart';
import 'package:mitrevels22/logic/cubits/user_data/cubit/user_data_cubit.dart';
import 'package:mitrevels22/logic/router.dart';
import 'package:url_launcher/url_launcher.dart';

class EventCustomPage extends StatefulWidget {
  final Event data;
  final RevelsAppState appState;
  EventCustomPage({Key? key, required this.data, required this.appState})
      : super(key: key);
  @override
  State<EventCustomPage> createState() => _EventState();
}

class _EventState extends State<EventCustomPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        await Future.delayed(const Duration(milliseconds: 200));
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF21242B),
          body: BlocConsumer<UserDataCubit, UserDataState>(
            listener: (context, state) {
              if (state is UserEventsLoadFailure) {
                context.read<TokenCubit>().deleteToken();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    backgroundColor: NeumorphicTheme.baseColor(context),
                    content: const Text(
                      'Please login again',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
              if (state is EventRegistrationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    backgroundColor: NeumorphicTheme.baseColor(context),
                    content: const Text(
                      'Successfully registered for the event',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
                context.read<UserDataCubit>().getRegisteredEvents(
                    (context.read<TokenCubit>().state as TokenExists).token);
              }
              if (state is EventRegistrationFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    backgroundColor: NeumorphicTheme.baseColor(context),
                    content: const Text(
                      'Failed to register for the event',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(36),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onTap: () {
                              widget.appState.eventId = null;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.data.name,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.data.category!.category,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF9B9B9B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            NeumorphicButton(
                              child: state is UserDataLoading ||
                                      state is EventRegistrationLoading
                                  ? CircularProgressIndicator()
                                  : Text(
                                      context.read<TokenCubit>().state
                                              is TokenEmpty
                                          ? "Login to Register"
                                          : state is UserEventsLoadSuccess
                                              ? state.events.any((element) =>
                                                      element.event.id ==
                                                      widget.data.id)
                                                  ? "Registered".toUpperCase()
                                                  : "Register".toUpperCase()
                                              : "Register".toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                              style: NeumorphicStyle(
                                depth: context.read<TokenCubit>().state
                                        is TokenExists
                                    ? state is UserEventsLoadSuccess
                                        ? state.events.any((element) =>
                                                element.event.id ==
                                                widget.data.id)
                                            ? 0
                                            : 4
                                        : 4
                                    : 4,
                                shape: NeumorphicShape.flat,
                                color: const Color(0xff21242B),
                                boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(100),
                                ),
                              ),
                              onPressed: context.read<TokenCubit>().state
                                      is TokenExists
                                  ? state is UserEventsLoadSuccess
                                      ? state.events.any((element) =>
                                              element.event.id ==
                                              widget.data.id)
                                          ? null
                                          : () {
                                              context
                                                  .read<UserDataCubit>()
                                                  .registerForEvent(
                                                    (context
                                                            .read<TokenCubit>()
                                                            .state as TokenExists)
                                                        .token,
                                                    widget.data.eventID
                                                        .toString(),
                                                  );
                                            }
                                      : () {
                                          context
                                              .read<UserDataCubit>()
                                              .registerForEvent(
                                                (context
                                                        .read<TokenCubit>()
                                                        .state as TokenExists)
                                                    .token,
                                                widget.data.eventID.toString(),
                                              );
                                        }
                                  : () {
                                      widget.appState.eventId = null;
                                      widget.appState.event = null;
                                      widget.appState.homePage = null;
                                      widget.appState.currentIndex = 2;
                                      widget.appState.authPage =
                                          AuthPages.login;
                                    },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(48, 48, 48, 0),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0XFF2C303A),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(60),
                          topLeft: Radius.circular(60),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Text(
                                  widget.data.description,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    "Team Size: ${widget.data.minMembers.toString()} - ${widget.data.maxMembers.toString()}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                if (widget.data.eventDateTime != null)
                                  Text(
                                    DateFormat.d().add_MMMM().format(
                                            widget.data.eventDateTime!) +
                                        ", " +
                                        DateFormat.EEEE()
                                            .format(widget.data.eventDateTime!),
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffE9436F),
                                      ),
                                    ),
                                  ),
                                if (widget.data.eventHeads.isNotEmpty)
                                  Neumorphic(
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    style: NeumorphicStyle(),
                                    child: ExpansionTile(
                                      iconColor: Color(0xffE9436F),
                                      tilePadding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      title: Text(
                                        "Event Heads",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      children: widget.data.eventHeads
                                          .map(
                                            (e) => ListTile(
                                              onTap: () => launch(
                                                  "mailto:${e.email}?subject=${widget.data.name}"),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              title: Text(
                                                e.name,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              subtitle: Text(
                                                e.email,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              trailing: NeumorphicButton(
                                                child: Icon(
                                                  Icons.call,
                                                  color: Color(0xffE9436F),
                                                ),
                                                onPressed: () {
                                                  launch("tel:${e.phoneNo}");
                                                },
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    "Location",
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Neumorphic(
                                        padding: const EdgeInsets.all(8),
                                        margin:
                                            const EdgeInsets.only(right: 16),
                                        child: Image.asset(
                                          'assets/Picture 1.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.data.mode == Mode.ONLINE
                                              ? "Online"
                                              : widget.data.eventVenue !=
                                                          null &&
                                                      widget.data.eventVenue!
                                                              .length >
                                                          0
                                                  ? "${widget.data.eventVenue![0].toUpperCase()}"
                                                      "${widget.data.eventVenue!.substring(1).toLowerCase()}"
                                                  : "Location",
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  endIndent: 0,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Text(
                                    "Delegate Card:",
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                if (widget.data.delegateCards.isNotEmpty)
                                  ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shrinkWrap: true,
                                    itemCount: widget.data.delegateCards.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Color(0xffb1b1b1),
                                          ),
                                        ),
                                        child: Text(
                                          widget.data.delegateCards[index].name,
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    },
                                  ),
                                state is UserDataLoading ||
                                        state is EventRegistrationLoading
                                    ? NeumorphicProgressIndeterminate()
                                    : NeumorphicButton(
                                        padding: const EdgeInsets.all(16),
                                        minDistance: -4,
                                        margin: const EdgeInsets.all(8),
                                        child: Text(
                                          context.read<TokenCubit>().state
                                                  is TokenExists
                                              ? state is UserEventsLoadSuccess
                                                  ? state.events.any(
                                                          (element) =>
                                                              element
                                                                  .event.id ==
                                                              widget.data.id)
                                                      ? "Registered"
                                                          .toUpperCase()
                                                      : "Register now"
                                                          .toUpperCase()
                                                  : "Register now".toUpperCase()
                                              : "Login to register",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFFFFFFF),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        style: NeumorphicStyle(
                                          depth: context
                                                  .read<TokenCubit>()
                                                  .state is TokenExists
                                              ? state is UserEventsLoadSuccess
                                                  ? state.events.any(
                                                          (element) =>
                                                              element
                                                                  .event.id ==
                                                              widget.data.id)
                                                      ? 0
                                                      : 4
                                                  : 4
                                              : 4,
                                          color: const Color(0xFF4D5465),
                                          boxShape:
                                              NeumorphicBoxShape.stadium(),
                                        ),
                                        onPressed: context
                                                .read<TokenCubit>()
                                                .state is TokenExists
                                            ? state is UserEventsLoadSuccess
                                                ? state.events.any((element) =>
                                                        element.event.id ==
                                                        widget.data.id)
                                                    ? null
                                                    : () {
                                                        context
                                                            .read<
                                                                UserDataCubit>()
                                                            .registerForEvent(
                                                              (context
                                                                          .read<
                                                                              TokenCubit>()
                                                                          .state
                                                                      as TokenExists)
                                                                  .token,
                                                              widget
                                                                  .data.eventID
                                                                  .toString(),
                                                            );
                                                      }
                                                : () {
                                                    context
                                                        .read<UserDataCubit>()
                                                        .registerForEvent(
                                                          (context
                                                                      .read<
                                                                          TokenCubit>()
                                                                      .state
                                                                  as TokenExists)
                                                              .token,
                                                          widget.data.eventID
                                                              .toString(),
                                                        );
                                                  }
                                            : () {
                                                widget.appState.eventId = null;
                                                widget.appState.event = null;
                                                widget.appState.homePage = null;
                                                widget.appState.currentIndex =
                                                    2;
                                                widget.appState.authPage =
                                                    AuthPages.login;
                                              },
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
