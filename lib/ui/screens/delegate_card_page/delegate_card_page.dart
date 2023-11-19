import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:mitrevels22/config/constants/constants.dart';
import 'package:mitrevels22/config/enums/enums.dart';
import 'package:mitrevels22/logic/blocs/delegate_card/bloc/delegate_card_bloc.dart';
import 'package:mitrevels22/ui/screens/delegate_card_page/delegate_card_second_page.dart';
import 'package:mitrevels22/ui/widgets/loading.dart';

import '../unknown_page.dart';

class DelegateCardPage extends StatelessWidget {
  const DelegateCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DelegateCardBloc, DelegateCardState>(
      builder: ((context, state) {
        if (state is DelegateCardLoading) {
          return loading(context);
        }
        if (state is DelegateCardLoaded) {
          return Scaffold(
              body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 80,
              ),
              Stack(
                children: [
                  Padding(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "Delegate Cards",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Cabin"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: DelegateCardType.values.length,
                    itemBuilder: ((context, index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => DelegateCardSecondPage(
                                            type:
                                                DelegateCardType.values[index],
                                            data: state.data,
                                          )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 3,
                                              color: delegateCardColors[index %
                                                  delegateCardColors.length]))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, left: 2, right: 2),
                                    child: Text(
                                      DelegateCardType.values[index].name,
                                      style: const TextStyle(
                                          fontFamily: "Cabin",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 25,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
