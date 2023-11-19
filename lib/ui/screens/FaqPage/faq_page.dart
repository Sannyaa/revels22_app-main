import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitrevels22/logic/blocs/faq/bloc/faq_bloc.dart';
import 'package:mitrevels22/logic/router.dart';
import '../../../config/constants/constants.dart';
import '../../widgets/loading.dart';
import '../unknown_page.dart';
import 'revels_tile.dart';

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.macOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key, required this.appState}) : super(key: key);
  final RevelsAppState appState;
  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: bgColor,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        scaffoldBackgroundColor: bgColor,
        textTheme: Typography.whiteMountainView,
      ),
      child: BlocBuilder(
          bloc: FaqBloc()..add(FaqInit()),
          builder: ((_, state) {
            if (state is FaqLoading) {
              return loading(context);
            }
            if (state is FaqLoaded) {
              return Scaffold(
                backgroundColor: bgColor,
                appBar: AppBar(
                  title: Text(
                    'FAQs',
                    style: GoogleFonts.cabin(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  leading: BackButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  centerTitle: true,
                  backgroundColor: bgColor,
                  elevation: 0,
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15.0),
                              child: RevealTile(data: state.data[index]),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return UnknownPage();
          })),
    );
  }
}
