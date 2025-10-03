import 'package:shared_preferences/shared_preferences.dart';
import 'package:skelar_chat_emulator/data/auth/auth_repository.dart';
import 'package:skelar_chat_emulator/data/shared/custom_response.dart';

class AuthLocalRepository extends AuthRepository {
  static const currentUserIdKey = 'currentUserIdKey';
  static const _userPasswordKeyPrefix = 'userPasswordKeyPrefix-';

  @override
  Future<CustomResponse<String?>> checkAuthorization() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString(currentUserIdKey);

    return CustomResponse(result: result);
  }

  @override
  Future<CustomResponse<bool>> signIn(String login, String password) async {
    final response = await checkAuthorization();
    final isAuthorized = response.result == true;

    if (isAuthorized) {
      return CustomResponse(error: Exception('User has already authorized!'));
    }

    final expectedPassword = await _getUserPassword(login);

    if (expectedPassword != _hashPassword(password)) {
      return CustomResponse(error: Exception('Wrong user data!'));
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(currentUserIdKey, login);

    return CustomResponse(result: true);
  }

  @override
  Future<CustomResponse<bool>> signUp(String login, String password) async {
    final userPassword = await _getUserPassword(login);

    if (userPassword != null) {
      return CustomResponse(error: Exception('User already exists!'));
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      '$_userPasswordKeyPrefix$login',
      _hashPassword(password),
    );
    prefs.setString(currentUserIdKey, login);

    return CustomResponse(result: true);
  }

  String _hashPassword(String password) {
    return password.hashCode.toString();
  }

  Future<String?> _getUserPassword(String login) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('$_userPasswordKeyPrefix$login');
  }

  @override
  Future<CustomResponse<bool>> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(currentUserIdKey);

    return CustomResponse(result: true);
  }
}
