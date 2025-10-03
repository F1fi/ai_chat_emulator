import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skelar_chat_emulator/data/auth/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(const AuthState());

  final AuthRepository _repository;

  Future<void> init() async {
    final response = await _repository.checkAuthorization();
    final login = response.result;
    emit(state.copyWith(login: () => login, isInitialized: true));
  }

  Future<bool> signIn(String login, String password) async {
    emit(state.copyWith(isLoading: true));

    final response = await _repository.signIn(login, password);

    final isSuccess = response.result == true;

    if (isSuccess) {
      emit(state.copyWith(login: () => login));
    }

    emit(state.copyWith(isLoading: false));

    return response.result == true;
  }

  Future<bool> signUp(String login, String password) async {
    emit(state.copyWith(isLoading: true));

    final response = await _repository.signUp(login, password);

    final isSuccess = response.result == true;
    if (isSuccess) {
      emit(state.copyWith(login: () => login));
    }

    emit(state.copyWith(isLoading: false));

    return response.result == true;
  }

  Future<void> signOut() async {
    _repository.signOut();

    emit(state.copyWith(login: () => null));
  }
}
