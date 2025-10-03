import 'package:skelar_chat_emulator/data/shared/custom_response.dart';
import 'package:skelar_chat_emulator/models/chat/chat_model.dart';
import 'package:skelar_chat_emulator/models/message/message_model.dart';
import 'package:skelar_chat_emulator/models/message/local_message_model.dart';

abstract class ChatRepository {
  Future<CustomResponse<List<ChatModel>>> loadChats();

  Future<CustomResponse<List<MessageModel>>> loadMessagesByChatId(
    String chatId,
  );

  Future<CustomResponse<MessageModel>> sendMessage(LocalMessageModel model);
}
