import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mitrevels22/config/settings/settings.dart';
import '../../../../data/models/category_model.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends HydratedBloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<FetchCategoriesEvent>((event, emit) async {
      if (state is! CategoriesLoaded) {
        emit(CategoriesLoading());
      }
      final dio = Dio();
      try {
        final _asyncMemoizer = AsyncMemoizer<Response>();
        final response = await _asyncMemoizer.runOnce(
          () => dio.get(
            baseUrl + '/api/category/getall',
          ),
        );
        if (response.statusCode == 200) {
          if (response.data['success']) {
            final List<Category> categories = response.data['data']
                .map<Category>((json) => Category.fromJson(json))
                .toList();
            return emit(CategoriesLoaded(data: categories));
          } else {
            return emit(CategoriesError());
          }
        } else {
          return emit(CategoriesError());
        }
      } catch (e) {
        return emit(CategoriesError());
      }
    });
  }

  @override
  Map<String, dynamic>? toJson(CategoriesState state) {
    if (state is CategoriesLoaded) {
      return {
        'categories': state.data.map((category) => category.toJson()).toList(),
      };
    }
    return null;
  }

  @override
  CategoriesState? fromJson(Map<String, dynamic> json) {
    if (json.containsKey('categories')) {
      return CategoriesLoaded(
        data: json['categories']
            .map<Category>((json) => Category.fromJson(json))
            .toList(),
      );
    }
    return null;
  }
}
