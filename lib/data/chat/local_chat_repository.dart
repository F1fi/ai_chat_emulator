import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:skelar_chat_emulator/data/auth/auth_local_repository.dart';
import 'package:skelar_chat_emulator/data/chat/chat_repository.dart';
import 'package:skelar_chat_emulator/data/shared/custom_response.dart';
import 'package:skelar_chat_emulator/models/agent/agent_model.dart';
import 'package:skelar_chat_emulator/models/chat/chat_model.dart';
import 'package:skelar_chat_emulator/models/message/local_message_model.dart';
import 'package:skelar_chat_emulator/models/message/message_model.dart';

class LocalChatRepository extends ChatRepository {
  static const _messageLastIdKey = 'messageIdKey';
  static const _chatLastMessagesKeyPrefix = 'chatLastMessagesKey-';
  static const _chatMessagesKeyPrefix = 'chatMessagesKey-';

  @override
  Future<CustomResponse<MessageModel>> sendMessage(
    LocalMessageModel model,
  ) async {
    await Future.delayed(Duration(milliseconds: 500));

    final isCanceled = Random().nextBool();

    if (isCanceled) {
      return CustomResponse(error: Exception());
    }

    final id = await _getMessageModelId();
    final answerId = await _getMessageModelId();

    final newMessage = MessageModel(
      id: id,
      chatId: model.chatId,
      text: model.text,
      isOwner: model.isOwner,
    );

    final answerMessage = MessageModel(
      id: answerId,
      chatId: model.chatId,
      toMessageId: id,
      text: 'Answer to ${model.text}. Thanks for message!',
      isOwner: false,
    );

    final prefs = await SharedPreferences.getInstance();
    final messageKey = _getMessagesKey(model.chatId);
    final list = prefs.getStringList(messageKey) ?? [];
    list.addAll([newMessage, answerMessage].map((e) => jsonEncode(e.toJson())));
    await prefs.setStringList(messageKey, list);
    await prefs.setString(
      _getLastMessagesKey(model.chatId),
      answerMessage.text,
    );

    return CustomResponse<MessageModel>(result: answerMessage);
  }

  Future<String> _getMessageModelId() async {
    final prefs = await SharedPreferences.getInstance();

    final result = prefs.getInt(_messageLastIdKey);

    final id = result == null ? 0 : result + 1;
    prefs.setInt(_messageLastIdKey, id);

    return id.toString();
  }

  @override
  Future<CustomResponse<List<MessageModel>>> loadMessagesByChatId(
    String chatId,
  ) async {
    await Future.delayed(Duration(milliseconds: 500));
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_getMessagesKey(chatId)) ?? [];
    try {
      final messages =
          list.map((e) => MessageModel.formJson(jsonDecode(e))).toList();
      return CustomResponse<List<MessageModel>>(result: messages);
    } catch (error) {
      return CustomResponse<List<MessageModel>>(error: Exception());
    }
  }

  @override
  Future<CustomResponse<List<ChatModel>>> loadChats() async {
    final userId = await _getUserId();
    if (userId == null) return CustomResponse(error: Exception());

    final agents = _loadAgents();
    final result = <ChatModel>[];

    for (final agent in agents) {
      final chatId = '${agent.id}-$userId';
      final lastMessage = await _getLastChatMessageById(chatId);
      final model = ChatModel(
        id: chatId,
        userId: userId,
        agent: agent,
        lastMessage: lastMessage,
      );
      result.add(model);
    }

    return CustomResponse(result: result);
  }

  Future<String?> _getLastChatMessageById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_getLastMessagesKey(id));
  }

  String _getLastMessagesKey(String chatId) {
    return '$_chatLastMessagesKeyPrefix$chatId';
  }

  String _getMessagesKey(String chatId) {
    return '$_chatMessagesKeyPrefix$chatId';
  }

  List<AgentModel> _loadAgents() {
    final names = ['Bob', 'Marta'];

    final url1 = "https://picsum.photos/200/300";
    final url2 = "https://picsum.photos/400/600";

    return names
        .map(
          (e) => AgentModel(
            id: 'agent-$e',
            name: e,
            imageUrl: e == names[0] ? url1 : url2,
          ),
        )
        .toList();
  }

  Future<String?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AuthLocalRepository.currentUserIdKey);
  }
}
