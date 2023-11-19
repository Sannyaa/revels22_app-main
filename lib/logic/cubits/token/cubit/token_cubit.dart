import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'token_state.dart';

class TokenCubit extends Cubit<TokenState> {
  TokenCubit() : super(TokenInitial());
  final storage = const FlutterSecureStorage();

  void loadToken() async {
    emit(TokenLoading());
    final token = await storage.read(key: 'token');
    if (token != null) {
      return emit(TokenExists(token: token));
    } else {
      return emit(TokenEmpty());
    }
  }

  void updateToken(String token) async {
    await storage.write(key: 'token', value: token);
    return emit(TokenExists(token: token));
  }

  void deleteToken() async {
    await storage.delete(key: 'token');
    return emit(TokenEmpty());
  }
}
