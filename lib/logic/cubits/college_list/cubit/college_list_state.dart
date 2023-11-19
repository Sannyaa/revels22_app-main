part of 'college_list_cubit.dart';

abstract class CollegeListState extends Equatable {
  const CollegeListState();

  @override
  List<Object> get props => [];
}

class CollegeListInitial extends CollegeListState {}

class CollegeListLoading extends CollegeListState {
  const CollegeListLoading();

  @override
  List<Object> get props => [];
}

class CollegeListLoaded extends CollegeListState {
  final List<College> colleges;

  const CollegeListLoaded({required this.colleges});

  @override
  List<Object> get props => [colleges];
}

class CollegeListError extends CollegeListState {
  final String message;

  const CollegeListError({required this.message});

  @override
  List<Object> get props => [message];
}
