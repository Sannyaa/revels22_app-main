part of 'teams_bloc.dart';

abstract class TeamsState extends Equatable {
  const TeamsState();

  @override
  List<Object> get props => [];
}

class TeamsLoading extends TeamsState {}

class TeamsLoaded extends TeamsState {
  final List<Team> teamList;

  TeamsLoaded(this.teamList);
}
