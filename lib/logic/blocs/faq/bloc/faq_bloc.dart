import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:mitrevels22/data/models/faq_model.dart';

part 'faq_event.dart';
part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  FaqBloc() : super(FaqLoading()) {
    on<FaqInit>((event, emit) async {
      List<FAQ> data = [];
      CollectionReference faq = FirebaseFirestore.instance.collection('faq');
      final docs = await faq.get();
      docs.docs.forEach((e) {
        print(e.data());
        if (e.data() != null)
          data.add(FAQ(
              question: (e.data()! as Map<String, dynamic>)["question"],
              answer: (e.data()! as Map<String, dynamic>)["answer"]));
      });
      emit(FaqLoaded(data: data));
    });
  }
}
