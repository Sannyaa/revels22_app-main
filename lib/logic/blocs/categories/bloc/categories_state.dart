part of 'categories_bloc.dart';

@immutable
abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<Category> data;

  const CategoriesLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class CategoriesError extends CategoriesState {}
