part of 'proshow_bloc.dart';

@immutable
abstract class ProshowState {}

class ProshowLoading extends ProshowState {}

class ProshowLoaded extends ProshowState {
    List<Proshow> data;
    ProshowLoaded({required this.data});
}

