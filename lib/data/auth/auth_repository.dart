import 'package:skelar_chat_emulator/data/shared/custom_response.dart';

abstract class AuthRepository {
  Future<CustomResponse<bool>> signIn(String login, String password);

  Future<CustomResponse<bool>> signUp(String login, String password);

  Future<CustomResponse<String?>> checkAuthorization();

  Future<CustomResponse<bool>> signOut();
}
