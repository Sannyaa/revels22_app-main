import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitrevels22/data/models/delegate_card_model.dart';
import 'package:mitrevels22/logic/router.dart';
import 'package:mitrevels22/ui/widgets/category_card.dart';

import '../../../config/constants/constants.dart';

class MyDelegateCards extends StatelessWidget {
  MyDelegateCards({Key? key, required this.pending, required this.purchased})
      : super(key: key);

  final List<DelegateCard> pending;
  final List<DelegateCard> purchased;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NeumorphicAppBar(
          title: Text(
            'My Delegate Cards',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Text(
                "Purchased Delegate Cards",
                style: GoogleFonts.cabin(color: Colors.white, fontSize: 24),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(24),
              itemCount: purchased.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical:16.0),
                  child: CategoryCard(
                      color1: categoryColors[index % (categoryColors.length)]
                          ["color1"],
                      color2: categoryColors[index % (categoryColors.length)]
                          ["color2"],
                      categoryName: purchased[index].name,
                      type: purchased[index].type,
                      cardId: purchased[index].cardID),
                );
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Text(
                "Pending Delegate Cards",
                style: GoogleFonts.cabin(color: Colors.white, fontSize: 24),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              itemCount: pending.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: CategoryCard(
                      color1: categoryColors[index % (categoryColors.length)]
                          ["color1"],
                      color2: categoryColors[index % (categoryColors.length)]
                          ["color2"],
                      categoryName: pending[index].name,
                      type: pending[index].type,
                      cardId: pending[index].cardID),
                );
              },
            ),
          ],
        ));
  }
}
