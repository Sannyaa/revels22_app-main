import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:mitrevels22/data/models/event_model.dart';
import 'package:mitrevels22/data/repositories/event_repository.dart';

part 'featured_events_event.dart';
part 'featured_events_state.dart';

class FeaturedEventsBloc
    extends Bloc<FeaturedEventsEvent, FeaturedEventsState> {
  List<Event> data = [];
  final List<int> eventsList = [];
  DocumentReference featured = FirebaseFirestore.instance
      .collection('featuredEvents')
      .doc("jwjGYgnM0C6alj8Bj236");
  EventRepository eventRepository = EventRepository();
  FeaturedEventsBloc() : super(FeaturedEventsInitial()) {
    on<FeaturedEventsInit>((event, emit) async {
      data = [];
      var value = await featured.get();
      (value.data()! as Map<String, dynamic>)["events"].forEach((e) {
        eventsList.add(int.parse(e));
      });
      print(eventsList);
      List<Event>? temp = await eventRepository.getAllEventsFunc();
      if (temp != null)
        temp.forEach((element) {
          print(element.eventID);
          if (eventsList.contains(element.eventID)) {
            data.add(element);
          }
        });
      emit(FeaturedEventsLoaded(data));
    });
  }
}
