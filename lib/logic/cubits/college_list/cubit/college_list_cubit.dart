import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mitrevels22/config/apis/user_auth_profile_apis.dart';
import 'package:mitrevels22/data/models/college_model.dart';

part 'college_list_state.dart';

class CollegeListCubit extends HydratedCubit<CollegeListState> {
  CollegeListCubit() : super(CollegeListInitial());

  static List<College> parseColleges(dynamic data) {
    return data.map<College>((json) => College.fromJson(json)).toList();
  }

  void getColleges() async {
    if (state is! CollegeListLoaded) {
      emit(const CollegeListLoading());
    }
    final dio = Dio();
    try {
      final response = await dio.get(getCollegeList());
      if (response.statusCode == 200) {
        final bool success = response.data['success'];
        if (success) {
          List<College> colleges =
              await compute(parseColleges, response.data['data']);
          return emit(CollegeListLoaded(colleges: colleges));
        } else {
          return emit(
            const CollegeListError(message: "Error while fetching colleges"),
          );
        }
      } else {
        return emit(
          const CollegeListError(message: "Error while fetching colleges"),
        );
      }
    } catch (e) {
      return emit(
        const CollegeListError(message: "Error while fetching colleges"),
      );
    }
  }

  @override
  Map<String, dynamic>? toJson(CollegeListState state) {
    if (state is CollegeListLoaded) {
      return {
        'colleges': state.colleges.map((college) => college.toJson()).toList(),
      };
    }
    return null;
  }

  @override
  CollegeListState? fromJson(Map<String, dynamic> json) {
    if (json.containsKey('colleges')) {
      return CollegeListLoaded(
        colleges: json['colleges']
            .map<College>((json) => College.fromJson(json))
            .toList(),
      );
    }
    return null;
  }
}
