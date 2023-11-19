part of 'teams_bloc.dart';

abstract class TeamsEvent extends Equatable {
  const TeamsEvent();

  @override
  List<Object> get props => [];
}

class TeamsInit extends TeamsEvent {}

class TeamsJoin extends TeamsEvent {
  final String teamId;
  final int eventId;
  final BuildContext context;
  TeamsJoin(this.teamId, this.context, this.eventId);
}

class TeamsLeave extends TeamsEvent {
  final String teamId;
  TeamsLeave(this.teamId);
}

class TeamsAdd extends TeamsEvent {
  final String userID;
  final String teamID;
  final int eventID;
  final BuildContext context;
  TeamsAdd(this.userID, this.teamID, this.eventID, this.context);
}
