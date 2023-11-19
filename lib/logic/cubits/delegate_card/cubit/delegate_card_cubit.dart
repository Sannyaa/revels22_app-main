import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mitrevels22/config/apis/delegate_cards_pro_shows_transactions_apis.dart';
import 'package:mitrevels22/config/enums/enums.dart';
import 'package:mitrevels22/data/models/delegate_card_model.dart';

import '../../../../data/models/user_model.dart';

part 'delegate_card_state.dart';

class DelegateCardCubit extends Cubit<DelegateCardState> {
  late List<DelegateCard> delegateCardList;
  DelegateCardCubit() : super(DelegateCardLoading());
  FlutterSecureStorage storage = FlutterSecureStorage();
  void getCards(DelegateCardType type, List<DelegateCard> data) {
    List<DelegateCard> newData = [];
    data.forEach((element) {
      if (element.type == type) {
        newData.add(element);
      }
    });
    delegateCardList = newData;
    emit(DelegateCardLoaded(newData));
  }

  void purchase(DelegateCard delegateCard, User? user) async {
    if (user != null) {
      final List<String> ammountArray = [
        delegateCard.nonMahePrice.toString(),
        delegateCard.mitPrice.toString(),
        delegateCard.mahePrice.toString()
      ];
      final token = await storage.read(key: 'token');
      final Dio dio = Dio();
      dio
          .post(purchaseOnlinePayment(),
              data: {
                "login": "332432",
                "pass": "d59be440",
                "ttype": "NBFundTransfer",
                "prodid": "REVEL",
                "amt": user.isMahe == 1
                    ? user.college.toLowerCase() ==
                            "manipal institute of technology"
                        ? ammountArray[1]
                        : ammountArray[2]
                    : ammountArray[0],
                "txncur": "INR",
                "txnamt": user.isMahe == 1
                    ? user.college.toLowerCase() ==
                            "manipal institute of technology"
                        ? ammountArray[1]
                        : ammountArray[2]
                    : ammountArray[0],
                "clientcode": "Akash",
                "datepick": "01/03/2019 16:20:00",
                "custacc": "100000036600",
                "udf1": user.name,
                "udf2": user.email,
                "udf3": user.mobileNumber,
                "udf5": user.documentId,
                "udf4": delegateCard.documentId,
                "ru": "https://revelsmit.in/api/Response",
                "delegateCardID": delegateCard.documentId,
              },
              options: Options(headers: {"authorization": token}))
          .then((res) {
        if (res.statusCode == 200) emit(DelegateCardLaunchUrl(res.data["url"]));
      });
    }
  }

  void loadData() {
    emit(DelegateCardLoaded(delegateCardList));
  }
}
