part of 'faq_bloc.dart';

@immutable
abstract class FaqState {}

class FaqLoading extends FaqState {}

class FaqLoaded extends FaqState {
  List<FAQ> data;
  FaqLoaded({required this.data});
}
