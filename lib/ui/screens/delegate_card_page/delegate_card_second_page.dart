import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitrevels22/config/constants/constants.dart';
import 'package:mitrevels22/config/enums/enums.dart';
import 'package:mitrevels22/data/models/delegate_card_model.dart';
import 'package:mitrevels22/logic/blocs/auth/bloc/auth_bloc.dart';
import 'package:mitrevels22/logic/blocs/user/bloc/user_bloc.dart';
import 'package:mitrevels22/logic/cubits/delegate_card/cubit/delegate_card_cubit.dart';
import 'package:mitrevels22/ui/screens/unknown_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/horizontal_list.dart';
import 'dart:math';

import '../../widgets/loading.dart';

class DelegateCardSecondPage extends StatefulWidget {
  const DelegateCardSecondPage(
      {Key? key, required this.type, required this.data})
      : super(key: key);
  final DelegateCardType type;
  final List<DelegateCard> data;

  @override
  State<DelegateCardSecondPage> createState() => _DelegateCardSecondPageState();
}

class _DelegateCardSecondPageState extends State<DelegateCardSecondPage> {
  int _focusIndex = 0;
  final DelegateCardCubit delegateCardCubit = DelegateCardCubit();
  void _onItemFocus(int index) {
    setState(() {
      _focusIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DelegateCardCubit, DelegateCardState>(
      listener: ((context, state) async {
        if (state is DelegateCardLaunchUrl) {
          if (await canLaunch(state.url)) {
            launch(state.url);
          }
          delegateCardCubit.loadData();
        }
      }),
      bloc: delegateCardCubit..getCards(widget.type, widget.data),
      builder: ((context, state) {
        if (state is DelegateCardLoading || state is DelegateCardLaunchUrl) {
          return loading(context);
        }
        if (state is DelegateCardLoaded) {
          return Scaffold(
              body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 80),
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: NeumorphicButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        style: const NeumorphicStyle(
                            depth: 4, boxShape: NeumorphicBoxShape.circle()),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            widget.type.name.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Cabin"),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.data.length,
                    itemBuilder: ((context, index) {
                      return Center(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width - 50,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      categoryColors[index %
                                          categoryColors.length]["color1"],
                                      categoryColors[index %
                                          categoryColors.length]["color2"],
                                    ])),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 30,
                                          ),
                                          child: Text(
                                            state.data[index].name,
                                            style: GoogleFonts.cabin(
                                                color: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        if (state.data[index].mitPrice > 0)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '\u{20B9}',
                                                  style: GoogleFonts.cabin(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  state.data[index].mitPrice
                                                      .toString(),
                                                  style: GoogleFonts.cabin(
                                                      color: Colors.white,
                                                      fontSize: 36,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (state.data[index].mahePrice > 0)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 20),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0)),
                                              child: Text(
                                                "\u{20B9}${state.data[index].mahePrice.toString()} for MAHE students",
                                                style: GoogleFonts.cabin(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        if (state.data[index].nonMahePrice > 0)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 20),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0)),
                                              child: Text(
                                                "\u{20B9}${state.data[index].nonMahePrice.toString()} for non MAHE students",
                                                style: GoogleFonts.cabin(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 30),
                                          child: NeumorphicButton(
                                            onPressed: (() {
                                              if (state.data[index].isActive ==
                                                  true)
                                                delegateCardCubit.purchase(
                                                    state.data[index],
                                                    BlocProvider.of<UserBloc>(
                                                            context)
                                                        .authUser);
                                            }),
                                            style: const NeumorphicStyle(
                                                color: Colors.white,
                                                depth: 3,
                                                lightSource:
                                                    LightSource.topLeft,
                                                shadowLightColor:
                                                    Color.fromARGB(
                                                        193, 95, 99, 37),
                                                shadowDarkColor: Color.fromARGB(
                                                    0, 0, 0, 24)),
                                            child: Text(
                                              "Buy Now",
                                              style: GoogleFonts.cabin(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            )),
                      );
                    })),
              )
            ],
          ));
        }
        return UnknownPage();
      }),
    );
  }
}
