import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:mitrevels22/data/models/delegate_card_model.dart';
import 'package:mitrevels22/data/repositories/delegate_card_pro_show_repository.dart';

part 'delegate_card_event.dart';
part 'delegate_card_state.dart';

class DelegateCardBloc extends Bloc<DelegateCardEvent, DelegateCardState> {
  DelegateCardRepository delegateCardRepository = DelegateCardRepository();

  final storage = const FlutterSecureStorage();
  DelegateCardBloc() : super(DelegateCardLoading()) {
    on<DelegateCardInit>((event, emit) async {
      List<DelegateCard> data =
          await delegateCardRepository.getAllDelegateCardsFunc();
      emit(DelegateCardLoaded(data));
    });
  }
}
