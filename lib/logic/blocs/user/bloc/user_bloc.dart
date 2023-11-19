import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mitrevels22/data/models/user_model.dart';
import 'package:mitrevels22/data/repositories/user_auth_repositories.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  User? authUser;
  UserRepository userRepository = UserRepository();
  UserBloc() : super(UserInitial()) {
    on<FetchUser>((event, emit) async {
      if (state is! UserLoaded) {
        emit(const UserLoading());
      }
      try {
        final response =
            await userRepository.getUserFromTokenMethod(event.token);
        print(response.data['data'][0]);
        if (response.statusCode == 200) {
          final bool success = response.data['success'];
          if (success) {
            print(response.data);
            final user = User.fromJson(response.data['data'][0]);
            authUser = user;

            return emit(UserLoaded(user: user));
          } else {
            return emit(
              const UserError(error: "Error while fetching user"),
            );
          }
        } else {
          return emit(
            const UserError(error: "Error while fetching user"),
          );
        }
      } on DioError catch (e) {
        final error = e.response?.data['msg'];
        return emit(
          UserError(error: error ?? "Error while fetching user"),
        );
      } catch (e) {
        print(e);
        return emit(
          const UserError(error: "Error while fetching user"),
        );
      }
    });
    on<LoadUser>((event, emit) {
      emit(UserLoaded(user: event.user));
    });
    on<LogoutEvent>((event, emit) async {
      try {
        final response = await userRepository.logout(event.token);
        if (response.statusCode == 200) {
          final bool success = response.data['success'];
          if (success) {
            return emit(const UserLoggedOut());
          } else {
            return emit(
              const UserError(error: "Error while logging out"),
            );
          }
        } else {
          return emit(
            const UserError(error: "Error while logging out"),
          );
        }
      } on DioError catch (e) {
        final error = e.response?.data['msg'];
        return emit(
          UserError(error: error ?? "Error while logging out"),
        );
      } catch (e) {
        return emit(
          const UserError(error: "Error while logging out"),
        );
      }
    });
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    if (state is UserLoaded) {
      return {
        'user': state.user.toJson(),
      };
    }
    return null;
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    if (json.containsKey('user')) {
      return UserLoaded(user: User.fromJson(json['user']));
    }
    return null;
  }
}
