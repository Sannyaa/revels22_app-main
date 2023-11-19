import 'package:dio/dio.dart';
import 'package:mitrevels22/config/apis/delegate_cards_pro_shows_transactions_apis.dart';
import 'package:mitrevels22/data/models/delegate_card_model.dart';

class DelegateCardRepository {
  Future<List<DelegateCard>> getAllDelegateCardsFunc() async {
    Response response = await Dio().get(
      getAllDelegateCardProShows(),
    );
    List<DelegateCard> data = [];
    print(response.data);
    if (response.statusCode == 200) {
      for (var d in response.data["data"]) {
        if(d["type"] == "PROSHOW")
        print(d);
        try {
          DelegateCard temp = DelegateCard.fromJson(d);
          data.add(temp);
        } catch (e) {
          print(e);
        }
      }
    }

    return data;
  }
}
