import 'package:skelar_chat_emulator/models/message/message_base_model.dart';
import 'package:skelar_chat_emulator/models/message/message_status.dart';

class MessageModel extends MessageBaseModel {
  const MessageModel({
    required this.id,
    required this.chatId,
    this.toMessageId,
    required this.text,
    required this.isOwner,
  });

  static const _idKey = 'id';
  static const _chatIdKey = 'chatId';
  static const _textKey = 'text';
  static const _isOwnerKey = 'isOwner';

  final String id;

  @override
  final String chatId;

  final String? toMessageId;

  @override
  final String text;

  @override
  final bool isOwner;

  @override
  MessageStatus get status => MessageStatus.sent;

  Map toJson() {
    return {
      _idKey: id,
      _textKey: text,
      _isOwnerKey: isOwner,
      _chatIdKey: chatId,
    };
  }

  factory MessageModel.formJson(Map json) {
    return MessageModel(
      id: json[_idKey],
      chatId: json[_chatIdKey],
      text: json[_textKey],
      isOwner: json[_isOwnerKey],
    );
  }
}
